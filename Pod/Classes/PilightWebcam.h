//
//  PilightWebcam.h
//  PilightKit
//
//  Created by Alexander Dittrich on 07.04.15.
//  Copyright (c) 2015 Alexander Dittrich. All rights reserved.
//

#import "PilightReadOnlyDevice.h"

@interface PilightWebcam : PilightReadOnlyDevice

@property (nonatomic, readonly) NSString* url;
@property (nonatomic, readonly) NSNumber* pollIntervall;

@property (nonatomic, readonly) NSNumber* imageWidth;
@property (nonatomic, readonly) NSNumber* imageHeight;
@property (nonatomic, readonly) BOOL showWebcam;

@end
