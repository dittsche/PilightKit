//
//  JSONCreator.m
//  PilightCommon
//
//  Created by Alexander Dittrich on 01.01.15.
//  Copyright (c) 2015 Alexander Dittrich. All rights reserved.
//

#import "JSONCreator.h"

#import "PilightStringDefinitions.h"
#import "PilightSwitch.h"
#import "PilightDimmer.h"
#import "PilightScreen.h"

@implementation JSONCreator

+(NSData *)clientIdentificationWithOptions:(PilightIdentificationOptions)opt mediaType:(PilightMediaType)mediaType uuid:(NSString *)uuid {
    NSString* mediaTypeValue;
    
    switch (mediaType) {
        case PilightMediaAll:
            mediaTypeValue = PILIGHT_VALUE_ALL;
            break;
        case PilightMediaWeb:
            mediaTypeValue = PILIGHT_VALUE_WEB;
            break;
        case PilightMediaMobile:
            mediaTypeValue = PILIGHT_VALUE_MOBILE;
            break;
        case PilightMediaDesktop:
            mediaTypeValue = PILIGHT_VALUE_DESKTOP;
            break;
            
        default:
            mediaTypeValue = PILIGHT_VALUE_ALL;
            break;
    }
    
    NSArray* optionsKeys = @[PILIGHT_KEY_RECEVIER, PILIGHT_KEY_CONFIG, PILIGHT_KEY_CORE, PILIGHT_KEY_STATS, PILIGHT_KEY_FORWARD];
    NSArray* optionsValues = @[(opt & PilightIdentificationReceiver) ? @1 : @0,
                               (opt & PilightIdentificationConfig) ? @1 : @0,
                               (opt & PilightIdentificationCore) ? @1 : @0,
                               (opt & PilightIdentificationStats) ? @1 : @0,
                               (opt & PilightIdentificationForward) ? @1 : @0];
    NSDictionary* optionsDict = [NSDictionary dictionaryWithObjects:optionsValues forKeys:optionsKeys];
    
    
    NSMutableArray* keys = [NSMutableArray arrayWithArray:@[PILIGHT_KEY_ACTION, PILIGHT_KEY_MEDIA, PILIGHT_KEY_OPTIONS]];
    NSMutableArray* values = [NSMutableArray arrayWithArray:@[PILIGHT_VALUE_IDENTIFY, mediaTypeValue, optionsDict]];
    
    if (uuid) {
        [keys addObject:PILIGHT_KEY_UUID];
        [values addObject:uuid];
    }

    NSDictionary *jsonDict = [NSDictionary dictionaryWithObjects:values forKeys:keys];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:0 error:&error];
    
    return jsonData;
}

+(NSData *)requestConfig {
    NSString *key = PILIGHT_KEY_ACTION;
    
    NSDictionary *jsonDict = [NSDictionary dictionaryWithObject:PILIGHT_VALUE_REQUEST_CONFIG forKey:key];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:0 error:&error];
    
    return jsonData;
}

+(NSData *)requestValues {
    NSString *key = PILIGHT_KEY_ACTION;
    
    NSDictionary *jsonDict = [NSDictionary dictionaryWithObject:PILIGHT_VALUE_REQUEST_VALUES forKey:key];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:0 error:&error];
    
    return jsonData;
}

+(NSData *)changeStateForSwitch:(PilightSwitch*)plSwitch toState:(PilightSwitchState)newState {
    
    NSMutableArray* codeKeys = [NSMutableArray arrayWithArray:@[PILIGHT_KEY_DEVICE, PILIGHT_KEY_STATE]];
    NSMutableArray* codeValues = [NSMutableArray arrayWithArray:@[plSwitch.key, newState == PilightSwitchOn ? PILIGHT_VALUE_ON : PILIGHT_VALUE_OFF]];
    
    if (plSwitch.all && [plSwitch.all boolValue]) {
        [codeKeys addObject:PILIGHT_KEY_VALUES];
        [codeValues addObject:@{PILIGHT_KEY_ALL : [NSNumber numberWithInt:1]}];
    }
    
    NSDictionary *codeDict = [NSDictionary dictionaryWithObjects:codeValues forKeys:codeKeys];
    
    
    NSArray* keys = @[PILIGHT_KEY_ACTION, PILIGHT_KEY_CODE];
    NSArray* values = @[PILIGHT_VALUE_CONTROL, codeDict];
    
    NSDictionary *jsonDict = [NSDictionary dictionaryWithObjects:values forKeys:keys];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:0 error:&error];
    
    return jsonData;
}

+(NSData *)changeDimLevelForDimmer:(PilightDimmer*)plDimmer toLevel:(NSNumber*)newLevel {
    
    NSArray* codeKeys = @[PILIGHT_KEY_DEVICE, PILIGHT_KEY_STATE, PILIGHT_KEY_VALUES];
    NSArray* codeValues = @[plDimmer.key, PILIGHT_VALUE_ON, @{PILIGHT_KEY_DIMLEVEL : newLevel}];
    
    NSDictionary *codeDict = [NSDictionary dictionaryWithObjects:codeValues forKeys:codeKeys];
    
    
    NSArray* keys = @[PILIGHT_KEY_ACTION, PILIGHT_KEY_CODE];
    NSArray* values = @[PILIGHT_VALUE_CONTROL, codeDict];
    
    NSDictionary *jsonDict = [NSDictionary dictionaryWithObjects:values forKeys:keys];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:0 error:&error];
    
    return jsonData;
}

+(NSData *)changeStateForScreen:(PilightScreen*)plScreen toState:(PilightScreenState)newState {

    NSMutableArray* codeKeys = [NSMutableArray arrayWithArray:@[PILIGHT_KEY_DEVICE, PILIGHT_KEY_STATE]];
    NSMutableArray* codeValues = [NSMutableArray arrayWithArray:@[plScreen.key, newState == PilightScreenUp ? PILIGHT_VALUE_ON : PILIGHT_VALUE_OFF]];
    
    if (plScreen.all && [plScreen.all boolValue]) {
        [codeKeys addObject:PILIGHT_KEY_VALUES];
        [codeValues addObject:@{PILIGHT_KEY_ALL : [NSNumber numberWithInt:1]}];
    }
    
    NSDictionary *codeDict = [NSDictionary dictionaryWithObjects:codeValues forKeys:codeKeys];
    
    
    NSArray* keys = @[PILIGHT_KEY_ACTION, PILIGHT_KEY_CODE];
    NSArray* values = @[PILIGHT_VALUE_CONTROL, codeDict];
    
    NSDictionary *jsonDict = [NSDictionary dictionaryWithObjects:values forKeys:keys];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:0 error:&error];
    
    return jsonData;
}

+(NSData *)updateWeatherDevice:(PilightWeather*)plWeather {
    NSArray* codeKeys = @[PILIGHT_KEY_DEVICE, PILIGHT_KEY_VALUES];
    NSArray* codeValues = @[plWeather.key, @{PILIGHT_VALUE_UPDATE : [NSNumber numberWithInt:1]}];
    
    NSDictionary *codeDict = [NSDictionary dictionaryWithObjects:codeValues forKeys:codeKeys];
    
    
    NSArray* keys = @[PILIGHT_KEY_ACTION, PILIGHT_KEY_CODE];
    NSArray* values = @[PILIGHT_VALUE_CONTROL, codeDict];
    
    NSDictionary *jsonDict = [NSDictionary dictionaryWithObjects:values forKeys:keys];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:0 error:&error];
    
    return jsonData;
}



@end
