//
//  PilightDateTime.h
//  PilightKit
//
//  Created by Alexander Dittrich on 09.04.15.
//  Copyright (c) 2015 Alexander Dittrich. All rights reserved.
//

#import "PilightDevice.h"
@interface PilightDateTime : PilightDevice

@property (nonatomic, readonly) NSDate* date;

@property (nonatomic, readonly) BOOL showDatetime;
@property (nonatomic, readonly) NSString* format;

@end
