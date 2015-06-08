//
//  PilightControl.h
//  PilightCommon
//
//  Created by Alexander Dittrich on 01.01.15.
//  Copyright (c) 2015 Alexander Dittrich. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PilightControlDelegate.h"
#import "PilightSwitch.h"
#import "PilightScreen.h"
#import "PilightWeather.h"

typedef NS_OPTIONS(NSUInteger, PilightIdentificationOptions) {
    PilightIdentificationReceiver = (1UL << 0),
    PilightIdentificationConfig = (1UL << 1),
    PilightIdentificationCore = (1UL << 2),
    PilightIdentificationStats = (1UL << 3),
    PilightIdentificationForward = (1UL << 4)
};

typedef NS_ENUM(NSUInteger, PilightMediaType) {
    PilightMediaAll,
    PilightMediaWeb,
    PilightMediaMobile,
    PilightMediaDesktop
};

@class PilightDimmer, PilightScreen;

@interface PilightControl : NSObject

@property (nonatomic, readonly) NSString* _host;
@property (nonatomic, readonly) UInt16 _port;
@property (nonatomic, readwrite) PilightMediaType mediaType;
@property (nonatomic, readwrite) PilightIdentificationOptions identificationOptions;
@property (nonatomic, readwrite) NSString* uuid;

@property (nonatomic, readonly) NSNumber* cpu;
@property (nonatomic, readonly) NSNumber* ram;

@property (nonatomic, readwrite) id <PilightControlDelegate> delegate;

@property (nonatomic, readonly) NSDictionary* registry;
@property (nonatomic, readonly) NSDictionary* devices;
@property (nonatomic, readonly) NSDictionary* groups;

- (instancetype)initWithHost:(NSString*)host port:(UInt16)port;

- (void)connect;
- (void)disconnect;
- (void)setState:(PilightSwitchState)state forSwitch:(PilightSwitch*)plSwitch;
- (void)setDimLevel:(NSNumber*)dimLevel forDimmer:(PilightDimmer*)plDimmer;
- (void)setState:(PilightScreenState)state forScreen:(PilightScreen*)plScreen;
- (void)updateWeatherDevice:(PilightWeather*)plWeather;

@end
