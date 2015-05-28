//
//  PilightLabel.h
//  Pods
//
//  Created by Alexander Dittrich on 28.05.15.
//
//

#import "PilightDevice.h"

@interface PilightLabel : PilightDevice

@property (nonatomic, readonly) NSString* label;
@property (nonatomic, readonly) NSString* color;

@end
