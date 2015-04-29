//
//  PilightDevice.h
//  PilightCommon
//
//  Created by Alexander Dittrich on 04.02.15.
//  Copyright (c) 2015 Alexander Dittrich. All rights reserved.
//

#import "PilightDevice.h"


@interface PilightReadOnlyDevice : PilightDevice

@property (nonatomic, readonly) BOOL readOnly;

@end
