//
//  JSONCreator.h
//  PilightCommon
//
//  Created by Alexander Dittrich on 01.01.15.
//  Copyright (c) 2015 Alexander Dittrich. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PilightControl.h"
#import "PilightScreen.h"

@interface JSONCreator : NSObject

+(NSData *)clientIdentificationWithOptions:(PilightIdentificationOptions)opt mediaType:(PilightMediaType)mediaType uuid:(NSString*)uuid;
+(NSData *)requestConfig;
+(NSData *)requestValues;
+(NSData *)changeStateForSwitch:(PilightSwitch*)plSwitch toState:(PilightSwitchState)newState;
+(NSData *)changeDimLevelForDimmer:(PilightDimmer*)plDimmer toLevel:(NSNumber*)newLevel;
+(NSData *)changeStateForScreen:(PilightScreen*)plScreen toState:(PilightScreenState)newState;
+(NSData *)updateWeatherDevice:(PilightWeather*)plWeather;
@end
