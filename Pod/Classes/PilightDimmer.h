//
//  PilightDimmer.h
//  PilightCommon
//
//  Created by Alexander Dittrich on 04.02.15.
//  Copyright (c) 2015 Alexander Dittrich. All rights reserved.
//

#import "PilightSwitch.h"

@interface PilightDimmer : PilightSwitch

@property (nonatomic, readonly) NSNumber* dimlevel;
@property (nonatomic, readonly) NSNumber* dimlevelMin;
@property (nonatomic, readonly) NSNumber* dimlevelMax;

- (void)setLevel:(NSNumber*)dimLevel;

@end
