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

@end

@implementation PilightReadOnlyDevice

- (instancetype)initWithControl:(PilightControl*)control andDictionary:(NSDictionary*)dict {
    self = [super initWithControl:control andDictionary:dict];
    if (self) {
        if ([dict objectForKey:PILIGHT_KEY_READONLY])
            self.readOnly = [[dict objectForKey:PILIGHT_KEY_READONLY] boolValue];
        else
            self.readOnly = YES;
        
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

- (void)addGroup:(PilightGroup *)group {
    [self.groups addObject:group];
}

@end
