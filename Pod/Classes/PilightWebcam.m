//
//  PilightWebcam.m
//  PilightKit
//
//  Created by Alexander Dittrich on 07.04.15.
//  Copyright (c) 2015 Alexander Dittrich. All rights reserved.
//

#import "PilightWebcam.h"

#import "PilightStringDefinitions.h"
#import "PilightControl.h"

@interface PilightWebcam ()

@property (nonatomic) NSString* url;
@property (nonatomic) NSNumber* pollIntervall;

@property (nonatomic) NSNumber* imageWidth;
@property (nonatomic) NSNumber* imageHeight;
@property (nonatomic) BOOL showWebcam;

@end

@implementation PilightWebcam

-(instancetype)initWithControl:(PilightControl*)control andDictionary:(NSDictionary*)dict {
    self = [super initWithControl:control andDictionary:dict];
    
    if (self) {
        if ([dict objectForKey:PILIGHT_KEY_IMAGE_WIDTH])
            self.imageWidth = [dict objectForKey:PILIGHT_KEY_IMAGE_WIDTH];
        else
            self.imageWidth = NULL;
        
        if ([dict objectForKey:PILIGHT_KEY_IMAGE_HEIGHT])
            self.imageHeight = [dict objectForKey:PILIGHT_KEY_IMAGE_HEIGHT];
        else
            self.imageHeight = NULL;
        
        if ([dict objectForKey:PILIGHT_KEY_SHOW_WEBCAM])
            self.showWebcam = [[dict objectForKey:PILIGHT_KEY_SHOW_WEBCAM] boolValue];
        else
            self.showWebcam = YES;
        
        [self updateFromDictionary:dict];
    }
    return self;
}

-(void)updateFromDictionary:(NSDictionary*)dict {
    [super updateFromDictionary:dict];
    
    if ([dict objectForKey:PILIGHT_KEY_URL])
        self.url = [dict objectForKey:PILIGHT_KEY_URL];
    
    if ([dict objectForKey:PILIGHT_KEY_POLL_INTERVAL])
        self.pollIntervall = [dict objectForKey:PILIGHT_KEY_POLL_INTERVAL];

}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@, url %@", [super description], self.url];
}

@end
