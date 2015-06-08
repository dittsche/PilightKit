//
//  PilightDevice.m
//  PilightCommon
//
//  Created by Alexander Dittrich on 04.02.15.
//  Copyright (c) 2015 Alexander Dittrich. All rights reserved.
//

#import "PilightReadOnlyDevice.h"

#import "PilightStringDefinitions.h"
#import "PilightControl.h"

@interface PilightReadOnlyDevice ()

@property (nonatomic) BOOL readOnly;
@property (nonatomic) BOOL confirm;

@end

@implementation PilightReadOnlyDevice

- (instancetype)initWithControl:(PilightControl*)control andDictionary:(NSDictionary*)dict {
    self = [super initWithControl:control andDictionary:dict];
    if (self) {
        if ([dict objectForKey:PILIGHT_KEY_READONLY])
            self.readOnly = [[dict objectForKey:PILIGHT_KEY_READONLY] boolValue];
        else
            self.readOnly = YES;
        
        if ([dict objectForKey:PILIGHT_KEY_CONFIRM]) {
            self.confirm = [[dict objectForKey:PILIGHT_KEY_CONFIRM] boolValue];
        }   else {
            if ([self.control.registry[PILIGHT_KEY_PILIGHT][PILIGHT_KEY_VERSION][PILIGHT_KEY_CURRENT] doubleValue] < 7.0)
                self.confirm = NO;
            else
                self.confirm = YES;
        }
        
        [self updateFromDictionary:dict];
    }
    return self;
}

- (void)updateFromDictionary:(NSDictionary*)dict {
    [super updateFromDictionary:dict];
    
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@, readonly %ld", [super description], (long)(self.readOnly ? 1 : 0)];
}

@end
