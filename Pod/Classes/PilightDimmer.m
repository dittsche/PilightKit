//
//  PilightDimmer.m
//  PilightCommon
//
//  Created by Alexander Dittrich on 04.02.15.
//  Copyright (c) 2015 Alexander Dittrich. All rights reserved.
//

#import "PilightDimmer.h"
#import "PilightStringDefinitions.h"
#import "PilightControl.h"

@interface PilightDimmer ()

@property (nonatomic) NSNumber* dimlevel;
@property (nonatomic) NSNumber* dimlevelMin;
@property (nonatomic) NSNumber* dimlevelMax;

@end

@implementation PilightDimmer

-(instancetype)initWithControl:(PilightControl*)control andDictionary:(NSDictionary*)dict {
    self = [super initWithControl:control andDictionary:dict];
    
    if (self) {
        if ([dict objectForKey:PILIGHT_KEY_DIMLEVEL_MIN])
            self.dimlevelMin = [dict objectForKey:PILIGHT_KEY_DIMLEVEL_MIN];
        else
            self.dimlevelMin = [NSNumber numberWithInt:0];
        
        if ([dict objectForKey:PILIGHT_KEY_DIMLEVEL_MAX])
            self.dimlevelMax = [dict objectForKey:PILIGHT_KEY_DIMLEVEL_MAX];
        else
            self.dimlevelMax = [NSNumber numberWithInt:15];
        
        [self updateFromDictionary:dict];
    }
    return self;
}

-(void)updateFromDictionary:(NSDictionary*)dict {
    [super updateFromDictionary:dict];
    
    if ([dict objectForKey:PILIGHT_KEY_DIMLEVEL])
        self.dimlevel = [dict objectForKey:PILIGHT_KEY_DIMLEVEL];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@, dimlevel %@", [super description], self.dimlevel];
}

- (void)setLevel:(NSNumber*)dimLevel {
    [self.control setDimLevel:dimLevel forDimmer:self];
}



@end
