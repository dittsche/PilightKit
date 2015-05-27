//
//  PilightControl.m
//  PilightCommon
//
//  Created by Alexander Dittrich on 01.01.15.
//  Copyright (c) 2015 Alexander Dittrich. All rights reserved.
//

#import "PilightControl.h"

#import <CocoaAsyncSocket/GCDAsyncSocket.h>
#import <CocoaLumberjack/CocoaLumberjack.h>


#import "JSONCreator.h"
#import "PilightStringDefinitions.h"
#import "PilightDeviceFactory.h"
#import "PilightGroup.h"


#define REGISTER_CLIENT 0
#define REQUEST_CONFIG 1
#define REQUEST_VALUES 2

@interface GCDAsyncSocket (MyGCDAsyncSocket)
+(NSData*)LFLFData;
@end

@implementation GCDAsyncSocket (MyGCDAsyncSocket)

+(NSData*)LFLFData {
    NSMutableData *data = [NSMutableData dataWithData:[GCDAsyncSocket LFData]];
    [data appendData:[GCDAsyncSocket LFData]];
    return [NSData dataWithData:data];
}
@end




@interface PilightControl ()

@property (nonatomic) GCDAsyncSocket* socket;

@property (nonatomic) NSString* host;
@property (nonatomic) UInt16 port;

@property (nonatomic) NSNumber* cpu;
@property (nonatomic) NSNumber* ram;

@property (nonatomic) NSDictionary* registry;
@property (nonatomic) NSMutableDictionary* devices;
@property (nonatomic) NSMutableDictionary* groups;

@end


@implementation PilightControl

@synthesize delegate, host, port, mediaType, identificationOptions;

-(instancetype)initWithHost:(NSString *)aHost port:(UInt16)aPort {
    self = [super init];
    if (self) {
        dispatch_queue_t pilightQueue;
        pilightQueue = dispatch_queue_create("de.pilightKit.thread", NULL);
        
        self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:pilightQueue];
        
        self.host = aHost;
        self.port = aPort;
        self.mediaType = PilightMediaAll;
        self.identificationOptions = PilightIdentificationReceiver | PilightIdentificationConfig | PilightIdentificationCore | PilightIdentificationStats | PilightIdentificationForward;
        
        self.registry = [NSDictionary new];
        self.devices = [NSMutableDictionary new];
        self.groups = [NSMutableDictionary new];
    }
    return self;
}

-(void)connect {
    if (self.socket.isConnected)
        [self.socket disconnect];
    
    NSError *err = nil;
    
    if (![self.socket connectToHost:self.host onPort:self.port withTimeout:10 error:&err]) {
        DDLogError(@"Unable to connect to due to invalid configuration: %@", err);
    } else {
        DDLogInfo(@"Connecting to \"%@\" on port %ld", self.host, (long)self.port);
    }
}

- (void)disconnect {
    if (self.socket.isConnected)
        [self.socket disconnect];
}


#pragma mark GCDAsyncSocket delegate

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port {
    [self.delegate control:self didConnectToHost:self.host];
    
    DDLogInfo(@"Connected to \"%@\" on port %ld", self.host, (long)self.port);
    
    [self sendData:[JSONCreator clientIdentificationWithOptions:self.identificationOptions mediaType:self.mediaType uuid:self.uuid] tag:0];
    [self.socket readDataToData:[GCDAsyncSocket LFLFData] withTimeout:-1.0 tag:REGISTER_CLIENT];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)error {
    [self.delegate control:self didDisconnectFromHost:self.host withError:error];
    
    if (error)
        DDLogError(@"Disconnected: %@", error);
    else
        DDLogInfo(@"Disconnected");
}

- (void)socket:(GCDAsyncSocket *)sender didReadData:(NSData *)data withTag:(long)tag {
    DDLogInfo(@"Recevied: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    
    NSError *err;
    NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
    
    if (err) {
        DDLogError(@"%@", err);
    }
    
    if (object && [object isKindOfClass:[NSDictionary class]]) {
        if (tag == REGISTER_CLIENT) {
            if ([[object objectForKey:PILIGHT_KEY_STATUS] isEqualToString:PILIGHT_VALUE_SUCCESS]) {
                [self sendData:[JSONCreator requestConfig] tag:0];
                [self.socket readDataToData:[GCDAsyncSocket LFLFData] withTimeout:-1.0 tag:REQUEST_CONFIG];
                return;
            } else if ([[object objectForKey:PILIGHT_KEY_STATUS] isEqualToString:PILIGHT_VALUE_FAILURE]) {
                DDLogError(@"Unsuccessfull identification");
            }
        } else if (tag == REQUEST_CONFIG) {
            [self parseConfig:[object objectForKey:PILIGHT_KEY_CONFIG]];
            [self sendData:[JSONCreator requestValues] tag:0];
            [self.socket readDataToData:[GCDAsyncSocket LFLFData] withTimeout:-1.0 tag:REQUEST_VALUES];
        } else if (tag == REQUEST_VALUES) {
            [self parseValues:object];
        } else {
            NSString* origin = [object objectForKey:PILIGHT_KEY_ORIGIN];
            if ([origin isEqualToString:PILIGHT_VALUE_UPDATE]) {
                [self parseUpdate:object];
            }   else if ([origin isEqualToString:PILIGHT_VALUE_CORE]) {
                [self parseCore:[object objectForKey:PILIGHT_KEY_VALUES]];
            }   else if ([origin isEqualToString:PILIGHT_VALUE_RECEIVER] || [origin isEqualToString:PILIGHT_VALUE_SENDER]) {
                if ([self.delegate respondsToSelector:@selector(control:didReceiveMessage:)]) {
                    [self.delegate control:self didReceiveMessage:object];
                }
            }
            
            if (self.identificationOptions & PilightIdentificationForward) {
                if ([self.delegate respondsToSelector:@selector(control:didReceiveSocketData:)]) {
                    [self.delegate control:self didReceiveSocketData:object];
                }
            }
        }
    }
    
    [self.socket readDataToData:[GCDAsyncSocket LFLFData] withTimeout:-1.0 tag:-1];
}


#pragma mark private methods

- (void)sendData:(NSData *)data tag:(int)tag {
    DDLogInfo(@"Send: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    [self.socket writeData:data withTimeout:-1.0 tag:tag];
}

- (void)parseConfig:(NSDictionary*)config {
    
    NSDictionary *registry = [config objectForKey:PILIGHT_KEY_REGISTRY];
    if (registry) {
        self.registry = registry;
    }
    
    NSDictionary *guiDevices = [config objectForKey:PILIGHT_KEY_GUI];
    NSDictionary *devices = [config objectForKey:PILIGHT_KEY_DEVICES];
    
    [self.devices removeAllObjects];
    [self.groups removeAllObjects];
    
    for (NSString* guiDeviceKey in guiDevices) {
        NSMutableDictionary *guiDeviceDict = [guiDevices objectForKey:guiDeviceKey];
        
        NSDictionary *deviceDict = [devices objectForKey:guiDeviceKey];
        
        [guiDeviceDict addEntriesFromDictionary:deviceDict];
        
        PilightDevice *device = [PilightDeviceFactory getDeviceInstance:guiDeviceDict forControl:self];
        device.key = guiDeviceKey;
        
        for (NSString* groupName in [guiDeviceDict objectForKey:PILIGHT_KEY_GROUP]) {
            PilightGroup* group = [self.groups objectForKey:groupName];
            if (group == nil) {
                group = [[PilightGroup alloc] initWithName:groupName];
                [self.groups setValue:group forKey:groupName];
            }
            
            [group addDevice:device];
            [device addGroup:group];
        }
        
        [self.devices setValue:device forKey:guiDeviceKey];
    }
    
    [self.delegate controlDidParseConfig:self];
}

- (void)parseValues:(NSDictionary*)values {
    for (NSDictionary* value in [values objectForKey:PILIGHT_KEY_VALUES]) {
        [self parseUpdate:value];
    }
}

- (void)parseUpdate:(NSDictionary*)update {
    for (NSString* deviceKey in [update objectForKey:PILIGHT_KEY_DEVICES]) {
        PilightDevice* device = [self.devices objectForKey:deviceKey];
        if (device != nil) {
            [device updateFromDictionary:[update objectForKey:PILIGHT_KEY_VALUES]];
        }
    }
}

- (void)parseCore:(NSDictionary*)core {
    if ([core objectForKey:PILIGHT_KEY_CPU]) {
        self.cpu = [core objectForKey:PILIGHT_KEY_CPU];
    }
    if ([core objectForKey:PILIGHT_KEY_RAM]) {
        self.ram = [core objectForKey:PILIGHT_KEY_RAM];
    }
}


- (void)setState:(PilightSwitchState)state forSwitch:(PilightSwitch*)plSwitch {
    NSData *jsonData = [JSONCreator changeStateForSwitch:plSwitch toState:state];
    
    [self sendData:jsonData tag:0];
}

- (void)setDimLevel:(NSNumber*)dimLevel forDimmer:(PilightDimmer*)plDimmer {
    NSData *jsonData = [JSONCreator changeDimLevelForDimmer:plDimmer toLevel:dimLevel];
    
    [self sendData:jsonData tag:0];
}

- (void)setState:(PilightScreenState)state forScreen:(PilightScreen*)plScreen {
    NSData *jsonData = [JSONCreator changeStateForScreen:plScreen toState:state];
    
    [self sendData:jsonData tag:0];
}

- (void)updateWeatherDevice:(PilightWeather*)plWeather {
    NSData *jsonData = [JSONCreator updateWeatherDevice:plWeather];
    
    [self sendData:jsonData tag:0];
}

@end
