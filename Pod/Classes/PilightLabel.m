//
//  PilightLabel.m
//  Pods
//
//  Created by Alexander Dittrich on 28.05.15.
//
//

#import "PilightLabel.h"

#import "PilightStringDefinitions.h"

@interface PilightLabel ()

@property (nonatomic) NSString* label;
@property (nonatomic) NSString* color;

@end

@implementation PilightLabel

-(instancetype)initWithControl:(PilightControl*)control andDictionary:(NSDictionary*)dict {
    self = [super initWithControl:control andDictionary:dict];
    
    if (self) {
        
        if ([dict objectForKey:PILIGHT_KEY_LABEL])
            self.label = [dict objectForKey:PILIGHT_KEY_LABEL];
        
        if ([dict objectForKey:PILIGHT_KEY_COLOR])
            self.color = [dict objectForKey:PILIGHT_KEY_COLOR];
        
        [self updateFromDictionary:dict];
    }
    return self;
}

-(void)updateFromDictionary:(NSDictionary*)dict {
    [super updateFromDictionary:dict];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@, label %@, color %@", [super description], self.label, self.color];
}

@end
