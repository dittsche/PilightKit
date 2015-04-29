//
//  PilightDeviceFactory.m
//  PilightCommon
//
//  Created by Alexander Dittrich on 04.02.15.
//  Copyright (c) 2015 Alexander Dittrich. All rights reserved.
//

#import "PilightDeviceFactory.h"

#import "PilightStringDefinitions.h"

#import "PilightSwitch.h"
#import "PilightDimmer.h"
#import "PilightWeather.h"
#import "PilightScreen.h"
#import "PilightWebcam.h"
#import "PilightRelay.h"
#import "PilightDateTime.h"

@implementation PilightDeviceFactory

+(PilightDevice*)getDeviceInstance:(NSDictionary*)dict forControl:(PilightControl*)control {
    
    switch ([[dict objectForKey:PILIGHT_KEY_TYPE] integerValue]) {
        case PilightDeviceTypeSwitch:
            return [[PilightSwitch alloc] initWithControl:control andDictionary:dict];
            
        case PilightDeviceTypeDimmer:
            return [[PilightDimmer alloc] initWithControl:control andDictionary:dict];
            
        case PilightDeviceTypeRelay:
            return [[PilightRelay alloc] initWithControl:control andDictionary:dict];
            
        case PilightDeviceTypeWeather:
            return [[PilightWeather alloc] initWithControl:control andDictionary:dict];
            
        case PilightDeviceTypeScreen:
            return [[PilightScreen alloc] initWithControl:control andDictionary:dict];
            
        case PilightDeviceTypeWebcam:
            return [[PilightWebcam alloc] initWithControl:control andDictionary:dict];
            
        case PilightDeviceTypeDateTime:
            return [[PilightDateTime alloc] initWithControl:control andDictionary:dict];
            
        default:
            return [[PilightDevice alloc] initWithControl:control andDictionary:dict];
    }
    
}

@end
