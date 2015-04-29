//
//  PilightScreen.m
//  PilightKit
//
//  Created by Alexander Dittrich on 07.04.15.
//  Copyright (c) 2015 Alexander Dittrich. All rights reserved.
//

#import "PilightScreen.h"

#import "PilightStringDefinitions.h"
#import "PilightControl.h"

@interface PilightScreen ()

@property (nonatomic) PilightScreenState state;
@property (nonatomic) NSNumber* all;

@end


@implementation PilightScreen

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
        self.state = [[dict objectForKey:PILIGHT_KEY_STATE] isEqualToString:PILIGHT_VALUE_UP] ? PilightScreenUp : PilightScreenDown;
    
    if ([dict objectForKey:PILIGHT_KEY_ALL])
        self.all = [dict objectForKey:PILIGHT_KEY_ALL];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@, state %@", [super description], self.state == PilightScreenUp ? PILIGHT_VALUE_UP : PILIGHT_VALUE_DOWN];
}

- (void)up {
    [self.control setState:PilightScreenUp forScreen:self];
}

- (void)down {
    [self.control setState:PilightScreenDown forScreen:self];
}

@end
