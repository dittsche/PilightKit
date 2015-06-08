//
//  PilightGroup.m
//  
//
//  Created by Alexander Dittrich on 04.04.15.
//
//

#import "PilightGroup.h"

#import "PilightDevice.h"

@interface PilightGroup ()

@property (nonatomic) NSString* name;
@property (nonatomic) NSDictionary* devices;

@end


@implementation PilightGroup

@synthesize devices;

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        self.name = name;
        self.devices = [NSDictionary new];
    }
    return self;
}

- (void)addDevice:(PilightDevice *)device {
    NSMutableDictionary* tempDevices = [NSMutableDictionary dictionaryWithDictionary:self.devices];
    [tempDevices setObject:device forKey:device.key];
    self.devices = tempDevices;
}

@end
