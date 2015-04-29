//
//  PilightWeather.m
//  PilightCommon
//
//  Created by Alexander Dittrich on 04.02.15.
//  Copyright (c) 2015 Alexander Dittrich. All rights reserved.
//

#import "PilightWeather.h"

#import "PilightStringDefinitions.h"
#import "PilightControl.h"

@interface PilightWeather ()

@property (nonatomic) NSNumber* temperature;
@property (nonatomic) NSNumber* humidity;
@property (nonatomic) NSDate* sunrise;
@property (nonatomic) NSDate* sunset;
@property (nonatomic) PilightWeatherSunState sun;
@property (nonatomic) NSNumber* windavg;
@property (nonatomic) NSNumber* winddir;
@property (nonatomic) NSNumber* windgust;
@property (nonatomic) NSNumber* pressure;
@property (nonatomic) PilightOversamplingOption oversampling;
@property (nonatomic) NSNumber* update;
@property (nonatomic) NSNumber* battery;

@property (nonatomic) NSNumber* temperatureOffset;
@property (nonatomic) NSNumber* humidityOffset;
@property (nonatomic) NSNumber* pollIntervall;

@property (nonatomic) double decimals;
@property (nonatomic) BOOL showHumidity;
@property (nonatomic) BOOL showTemperature;
@property (nonatomic) BOOL showSunriseSet;
@property (nonatomic) BOOL showWind;
@property (nonatomic) BOOL showPressure;
@property (nonatomic) BOOL showUpdate;
@property (nonatomic) BOOL showBattery;

@end

@implementation PilightWeather

-(instancetype)initWithControl:(PilightControl*)control andDictionary:(NSDictionary *)dict {
    self = [super initWithControl:control andDictionary:dict];
    
    if (self) {
        // Optional Settings
        
        if ([dict objectForKey:PILIGHT_KEY_DECIMALS])
            self.decimals = [[dict objectForKey:PILIGHT_KEY_DECIMALS] doubleValue];
        else
            self.decimals = 2;
        
        if ([dict objectForKey:PILIGHT_KEY_SHOW_HUMIDITY])
            self.showHumidity = [[dict objectForKey:PILIGHT_KEY_SHOW_HUMIDITY] boolValue];
        else
            self.showHumidity = YES;
        
        if ([dict objectForKey:PILIGHT_KEY_SHOW_TEMPERATURE])
            self.showTemperature = [[dict objectForKey:PILIGHT_KEY_SHOW_TEMPERATURE] boolValue];
        else
            self.showTemperature = YES;
        
        if ([dict objectForKey:PILIGHT_KEY_SHOW_SUNRISESET])
            self.showSunriseSet = [[dict objectForKey:PILIGHT_KEY_SHOW_SUNRISESET] boolValue];
        else
            self.showSunriseSet = YES;
        
        if ([dict objectForKey:PILIGHT_KEY_SHOW_WIND])
            self.showWind = [[dict objectForKey:PILIGHT_KEY_SHOW_WIND] boolValue];
        else
            self.showWind = YES;
        
        if ([dict objectForKey:PILIGHT_KEY_SHOW_PRESSURE])
            self.showPressure = [[dict objectForKey:PILIGHT_KEY_SHOW_PRESSURE] boolValue];
        else
            self.showPressure = YES;
        
        if ([dict objectForKey:PILIGHT_KEY_SHOW_UPDATE])
            self.showUpdate = [[dict objectForKey:PILIGHT_KEY_SHOW_UPDATE] boolValue];
        else
            self.showUpdate = YES;
        
        if ([dict objectForKey:PILIGHT_KEY_SHOW_BATTERY])
            self.showBattery = [[dict objectForKey:PILIGHT_KEY_SHOW_BATTERY] boolValue];
        else
            self.showBattery = NO;

        [self updateFromDictionary:dict];
    }
    return self;
}

- (void)updateFromDictionary:(NSDictionary*)dict {
    [super updateFromDictionary:dict];
    
    if ([dict objectForKey:PILIGHT_KEY_HUMIDITY])
        self.humidity = [dict objectForKey:PILIGHT_KEY_HUMIDITY];
    
    if ([dict objectForKey:PILIGHT_KEY_TEMPERATURE])
        self.temperature = [dict objectForKey:PILIGHT_KEY_TEMPERATURE];
    
    if ([dict objectForKey:PILIGHT_KEY_SUNRISE]) {
        NSCalendar *calendar = [[NSCalendar alloc]
                                initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSNumber *time = [dict objectForKey:PILIGHT_KEY_SUNRISE];
        int hours = (int)time.intValue;
        int minutes = (int)round((time.doubleValue - (double)hours)* 100);
        
        NSDateComponents *components = [NSDateComponents new];
        [components setHour:hours];
        [components setMinute:minutes];
        
        self.sunrise = [calendar dateFromComponents:components];
    }
    
    if ([dict objectForKey:PILIGHT_KEY_SUNSET]) {
        NSCalendar *calendar = [[NSCalendar alloc]
                                initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSNumber *time = [dict objectForKey:PILIGHT_KEY_SUNSET];
        int hours = (int)time.intValue;
        int minutes = (int)round((time.doubleValue - (double)hours)* 100);
        
        NSDateComponents *components = [NSDateComponents new];
        [components setHour:hours];
        [components setMinute:minutes];
        
        self.sunset = [calendar dateFromComponents:components];
    }
    
    if ([dict objectForKey:PILIGHT_KEY_SUN])
        self.sun = [[dict objectForKey:PILIGHT_KEY_SUN] isEqualToString:PILIGHT_VALUE_SUN_RISE] ? PilightSunRise : PilightSunSet;
    else
        self.sun = PilightSunNoValue;
    
    if ([dict objectForKey:PILIGHT_KEY_WINDAVG])
        self.windavg = [dict objectForKey:PILIGHT_KEY_WINDAVG];
    
    if ([dict objectForKey:PILIGHT_KEY_WINDDIR])
        self.winddir = [dict objectForKey:PILIGHT_KEY_WINDDIR];
    
    if ([dict objectForKey:PILIGHT_KEY_WINDGUST])
        self.windgust = [dict objectForKey:PILIGHT_KEY_WINDGUST];
    
    if ([dict objectForKey:PILIGHT_KEY_PRESSURE])
        self.pressure = [dict objectForKey:PILIGHT_KEY_PRESSURE];
    
    if ([dict objectForKey:PILIGHT_KEY_OVERSAMPLING]) {
        self.oversampling = [[dict objectForKey:PILIGHT_KEY_OVERSAMPLING] unsignedIntegerValue];
    }  else {
        self.oversampling = PilightOversamplingNoOption;
    }
    
    if ([dict objectForKey:PILIGHT_KEY_UPDATE])
        self.update = [dict objectForKey:PILIGHT_KEY_UPDATE];
    
    if ([dict objectForKey:PILIGHT_KEY_BATTERY])
        self.battery = [dict objectForKey:PILIGHT_KEY_BATTERY];
    
    
    // Optional Settings
    
    if ([dict objectForKey:PILIGHT_KEY_HUMIDITY_OFFSET])
        self.humidityOffset = [dict objectForKey:PILIGHT_KEY_HUMIDITY_OFFSET];
    else
        self.humidityOffset = [NSNumber numberWithInt:0];
    
    if ([dict objectForKey:PILIGHT_KEY_TEMPERATURE_OFFSET])
        self.temperatureOffset = [dict objectForKey:PILIGHT_KEY_TEMPERATURE_OFFSET];
    else
        self.temperatureOffset = [NSNumber numberWithInt:0];
    
    if ([dict objectForKey:PILIGHT_KEY_POLL_INTERVAL])
        self.temperatureOffset = [dict objectForKey:PILIGHT_KEY_POLL_INTERVAL];
    else
        self.temperatureOffset = [NSNumber numberWithInt:900];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@, humidity %@", [super description], self.humidity];
}

-(void)updateDevice {
    [self.control updateWeatherDevice:self];
}

@end
