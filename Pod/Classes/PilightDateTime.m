//
//  PilightDateTime.m
//  PilightKit
//
//  Created by Alexander Dittrich on 09.04.15.
//  Copyright (c) 2015 Alexander Dittrich. All rights reserved.
//

#import "PilightDateTime.h"

#import "PilightStringDefinitions.h"
#import "PilightControl.h"

@interface PilightDateTime ()

@property (nonatomic) NSDate* date;

@property (nonatomic) BOOL showDatetime;
@property (nonatomic) NSString* format;

@end


@implementation PilightDateTime

-(instancetype)initWithControl:(PilightControl*)control andDictionary:(NSDictionary*)dict {
    self = [super initWithControl:control andDictionary:dict];
    
    if (self) {
        
        if ([dict objectForKey:PILIGHT_KEY_SHOW_DATETIME])
            self.showDatetime = [[dict objectForKey:PILIGHT_KEY_SHOW_DATETIME] boolValue];
        else
            self.showDatetime = YES;
        
        if ([dict objectForKey:PILIGHT_KEY_FORMAT])
            self.format = [dict objectForKey:PILIGHT_KEY_FORMAT];
        else
            self.format = @"HH:mm:ss YYYY-MM-DD";
        
        [self updateFromDictionary:dict];
    }
    return self;
}

-(void)updateFromDictionary:(NSDictionary*)dict {
    [super updateFromDictionary:dict];
    
    NSCalendar* calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents* components = [NSDateComponents new];
    
    if ([dict objectForKey:PILIGHT_KEY_YEAR])
        components.year = [[dict objectForKey:PILIGHT_KEY_YEAR] integerValue];
    
    if ([dict objectForKey:PILIGHT_KEY_MONTH])
        components.month =  [[dict objectForKey:PILIGHT_KEY_MONTH] integerValue];
    
    if ([dict objectForKey:PILIGHT_KEY_DAY])
        components.day = [[dict objectForKey:PILIGHT_KEY_DAY] integerValue];
    
    if ([dict objectForKey:PILIGHT_KEY_HOUR])
        components.hour = [[dict objectForKey:PILIGHT_KEY_HOUR] integerValue];
    
    if ([dict objectForKey:PILIGHT_KEY_MINUTE])
        components.minute = [[dict objectForKey:PILIGHT_KEY_MINUTE] integerValue];
    
    if ([dict objectForKey:PILIGHT_KEY_SECOND])
        components.second = [[dict objectForKey:PILIGHT_KEY_SECOND] integerValue];
    
    if ([dict objectForKey:PILIGHT_KEY_WEEKDAY])
        components.weekday = [[dict objectForKey:PILIGHT_KEY_WEEKDAY] integerValue];
    
    self.date = [calendar dateFromComponents:components];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@, date %@", [super description], self.date];
}

@end
