//
//  PilightDeviceFactory.h
//  PilightCommon
//
//  Created by Alexander Dittrich on 04.02.15.
//  Copyright (c) 2015 Alexander Dittrich. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PilightDevice.h"

@interface PilightDeviceFactory : NSObject

+(PilightDevice*)getDeviceInstance:(NSDictionary*)dict forControl:(PilightControl*)control;

@end
