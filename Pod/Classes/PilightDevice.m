//
//  PilightAbstractDevice.m
//  PilightKit
//
//  Created by Alexander Dittrich on 07.04.15.
//  Copyright (c) 2015 Alexander Dittrich. All rights reserved.
//

#import "PilightDevice.h"

#import "PilightStringDefinitions.h"
#import "PilightControl.h"

@interface PilightDevice ()

@property (nonatomic) PilightControl* control;
@property (nonatomic) NSString* name;
@property (nonatomic) NSArray* protocols;
@property (nonatomic) NSSet *groups;
@property (nonatomic) NSArray *mediaTypes;
@property (nonatomic) NSInteger order;
@property (nonatomic) PilightDeviceType type;
@property (nonatomic) NSDate* lastUpdate;

@end

@implementation PilightDevice

- (instancetype)initWithControl:(PilightControl*)control andDictionary:(NSDictionary*)dict {
    self = [super init];
    if (self) {
        self.control = control;
        self.name = [dict objectForKey:PILIGHT_KEY_NAME];
        self.protocols = [dict objectForKey:PILIGHT_KEY_PROTOCOL];
        self.groups = [NSMutableSet new];
        
        NSMutableArray* mediaTypes = [NSMutableArray new];
        for (NSString* mediaTypeString in [dict objectForKey:PILIGHT_KEY_MEDIA]) {
            if ([mediaTypeString isEqualToString:PILIGHT_VALUE_ALL])
                [mediaTypes addObject:[NSNumber numberWithUnsignedInteger:PilightMediaAll]];
            if ([mediaTypeString isEqualToString:PILIGHT_VALUE_WEB])
                [mediaTypes addObject:[NSNumber numberWithUnsignedInteger:PilightMediaWeb]];
            if ([mediaTypeString isEqualToString:PILIGHT_VALUE_MOBILE])
                [mediaTypes addObject:[NSNumber numberWithUnsignedInteger:PilightMediaMobile]];
            if ([mediaTypeString isEqualToString:PILIGHT_VALUE_DESKTOP])
                [mediaTypes addObject:[NSNumber numberWithUnsignedInteger:PilightMediaDesktop]];
        }
        self.mediaTypes = [NSArray arrayWithArray:mediaTypes];
        self.order = [[dict objectForKey:PILIGHT_KEY_ORDER] integerValue];
        self.type = [[dict objectForKey:PILIGHT_KEY_TYPE] integerValue];
        
        self.lastUpdate = [NSDate new];
        
        [self updateFromDictionary:dict];
    }
    return self;
}

- (void)updateFromDictionary:(NSDictionary*)dict {
    
    if ([dict objectForKey:PILIGHT_KEY_TIMESTAMP]) {
        self.lastUpdate = [NSDate dateWithTimeIntervalSince1970:[[dict objectForKey:PILIGHT_KEY_TIMESTAMP] integerValue]];
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Device %@: type %ld, last update: %@", self.key, (long)self.type, self.lastUpdate];
}

- (void)addGroup:(PilightGroup *)group {
    NSMutableSet* tempGroups = [NSMutableSet setWithSet:self.groups];
    [tempGroups addObject:group];
    self.groups = tempGroups;
}

@end
