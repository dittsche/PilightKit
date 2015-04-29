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
@property (nonatomic) NSMutableDictionary* devices;

@end


@implementation PilightGroup

@synthesize devices;

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        self.name = name;
        self.devices = [NSMutableDictionary new];
    }
    return self;
}

- (void)addDevice:(PilightDevice *)device {
    [self.devices setObject:device forKey:device.key];
}

@end
