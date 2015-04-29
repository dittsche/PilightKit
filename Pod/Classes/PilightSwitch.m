//
//  PilightSwitch.m
//  PilightCommon
//
//  Created by Alexander Dittrich on 04.02.15.
//  Copyright (c) 2015 Alexander Dittrich. All rights reserved.
//

#import "PilightSwitch.h"

#import "PilightStringDefinitions.h"
#import "PilightControl.h"

@interface PilightSwitch ()

@property (nonatomic) PilightSwitchState state;
@property (nonatomic) NSNumber* all;

@end


@implementation PilightSwitch

-(instancetype)initWithControl:(PilightControl*)control andDictionary:(NSDictionary*)dict {
    self = [super initWithControl:control andDictionary:dict];
    
    if (self) {
        [self updateFromDictionary:dict];
    }
    return self;
}

-(void)updateFromDictionary:(NSDictionary*)dict {
    [super updateFromDictionary:dict];
    
    if ([dict objectForKey:PILIGHT_KEY_STATE])
        self.state = [[dict objectForKey:PILIGHT_KEY_STATE] isEqualToString:PILIGHT_VALUE_ON] ? PilightSwitchOn : PilightSwitchOff;
    
    if ([dict objectForKey:PILIGHT_KEY_ALL])
        self.all = [dict objectForKey:PILIGHT_KEY_ALL];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@, state %@", [super description], self.state == PilightSwitchOn ? PILIGHT_VALUE_ON : PILIGHT_VALUE_OFF];
}

- (void)turnOn {
    [self.control setState:PilightSwitchOff forSwitch:self];
}

- (void)turnOff {
    [self.control setState:PilightSwitchOn forSwitch:self];
}

- (void)toggleState {
    [self.control setState:!self.state forSwitch:self];
}

@end

