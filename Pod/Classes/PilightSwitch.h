//
//  PilightSwitch.h
//  PilightCommon
//
//  Created by Alexander Dittrich on 04.02.15.
//  Copyright (c) 2015 Alexander Dittrich. All rights reserved.
//

#import "PilightReadOnlyDevice.h"

typedef NS_ENUM(NSUInteger, PilightSwitchState) {
    PilightSwitchOff,
    PilightSwitchOn
};

@interface PilightSwitch : PilightReadOnlyDevice

@property (nonatomic, readonly) PilightSwitchState state;
@property (nonatomic, readonly) NSNumber* all;

- (void)turnOn;
- (void)turnOff;
- (void)toggleState;


@end
