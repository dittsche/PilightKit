//
//  PilightRelay.m
//  PilightKit
//
//  Created by Alexander Dittrich on 08.04.15.
//  Copyright (c) 2015 Alexander Dittrich. All rights reserved.
//

#import "PilightRelay.h"

#import "PilightStringDefinitions.h"
#import "PilightControl.h"


@interface PilightRelay ()

@property (nonatomic) PilightSwitchState defaultState;

@end

@implementation PilightRelay

-(instancetype)initWithControl:(PilightControl*)control andDictionary:(NSDictionary*)dict {
    self = [super initWithControl:control andDictionary:dict];
    
    if (self) {
        if ([dict objectForKey:PILIGHT_KEY_DEFAULT_STATE])
            self.defaultState = [[dict objectForKey:PILIGHT_KEY_DEFAULT_STATE] isEqualToString:PILIGHT_VALUE_ON] ? PilightSwitchOn : PilightSwitchOff;
        else
            self.defaultState = PilightSwitchOff;
        
        [self updateFromDictionary:dict];
    }
    return self;
}

-(void)updateFromDictionary:(NSDictionary*)dict {
    [super updateFromDictionary:dict];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@", [super description]];
}
@end
