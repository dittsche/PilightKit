//
//  PilightWeather.h
//  PilightCommon
//
//  Created by Alexander Dittrich on 04.02.15.
//  Copyright (c) 2015 Alexander Dittrich. All rights reserved.
//

#import "PilightDevice.h"

typedef NS_ENUM(NSUInteger, PilightWeatherSunState) {
    PilightSunNoValue,
    PilightSunRise,
    PilightSunSet
};

typedef NS_ENUM(NSUInteger, PilightOversamplingOption) {
    PilightOversamplingUltraLowPower = 0,
    PilightOversamplingStandard = 1,
    PilightOversamplingHighResolution = 2,
    PilightOversamplingUltraHighResolution = 3,
    PilightOversamplingNoOption = 10
};

@interface PilightWeather : PilightDevice

@property (nonatomic, readonly) NSNumber* temperature;
@property (nonatomic, readonly) NSNumber* humidity;
@property (nonatomic, readonly) NSDate* sunrise;
@property (nonatomic, readonly) NSDate* sunset;
@property (nonatomic, readonly) PilightWeatherSunState sun;
@property (nonatomic, readonly) NSNumber* windavg;
@property (nonatomic, readonly) NSNumber* winddir;
@property (nonatomic, readonly) NSNumber* windgust;
@property (nonatomic, readonly) NSNumber* pressure;
@property (nonatomic, readonly) PilightOversamplingOption oversampling;
@property (nonatomic, readonly) NSNumber* update;
@property (nonatomic, readonly) NSNumber* battery;

@property (nonatomic, readonly) NSNumber* temperatureOffset;
@property (nonatomic, readonly) NSNumber* humidityOffset;
@property (nonatomic, readonly) NSNumber* pollIntervall;

// optional settings

@property (nonatomic, readonly) double decimals;
@property (nonatomic, readonly) BOOL showHumidity;
@property (nonatomic, readonly) BOOL showTemperature;
@property (nonatomic, readonly) BOOL showSunriseSet;
@property (nonatomic, readonly) BOOL showWind;
@property (nonatomic, readonly) BOOL showPressure;
@property (nonatomic, readonly) BOOL showUpdate;
@property (nonatomic, readonly) BOOL showBattery;

- (void)updateDevice;

@end
