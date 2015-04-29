//
//  PilightAbstractDevice.h
//  PilightKit
//
//  Created by Alexander Dittrich on 07.04.15.
//  Copyright (c) 2015 Alexander Dittrich. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PilightDeviceType) {
    PilightDeviceTypeSwitch = 1,
    PilightDeviceTypeDimmer = 2,
    PilightDeviceTypeWeather = 3,
    PilightDeviceTypeRelay = 4,
    PilightDeviceTypeScreen = 5,
    PilightDeviceTypePendingSwitch = 7,
    PilightDeviceTypeDateTime = 8,
    PilightDeviceTypeXBMC = 9,
    PilightDeviceTypeWebcam = 11
};

@class PilightControl, PilightGroup;

@interface PilightDevice : NSObject

@property (nonatomic, readonly) PilightControl* control;
@property (nonatomic) NSString* key;
@property (nonatomic, readonly) NSArray* protocols;
@property (nonatomic, readonly) NSString* name;
@property (nonatomic, readonly) NSMutableSet *groups;
@property (nonatomic, readonly) NSArray *mediaTypes;
@property (nonatomic, readonly) NSInteger order;
@property (nonatomic, readonly) PilightDeviceType type;
@property (nonatomic, readonly) NSDate* lastUpdate;

- (instancetype)initWithControl:(PilightControl*)control andDictionary:(NSDictionary*)dict;
- (void)updateFromDictionary:(NSDictionary*)dict;
- (void)addGroup:(PilightGroup*)group;

@end
