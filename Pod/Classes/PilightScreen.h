//
//  PilightScreen.h
//  PilightKit
//
//  Created by Alexander Dittrich on 07.04.15.
//  Copyright (c) 2015 Alexander Dittrich. All rights reserved.
//

#import "PilightReadOnlyDevice.h"

typedef NS_ENUM(NSUInteger, PilightScreenState) {
    PilightScreenDown,
    PilightScreenUp
};

@interface PilightScreen : PilightReadOnlyDevice

@property (nonatomic, readonly) PilightScreenState state;
@property (nonatomic, readonly) NSNumber* all;

- (void)up;
- (void)down;

@end
