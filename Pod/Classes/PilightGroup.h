//
//  PilightGroup.h
//  
//
//  Created by Alexander Dittrich on 04.04.15.
//
//

#import <Foundation/Foundation.h>

@class PilightDevice;

@interface PilightGroup : NSObject

@property (nonatomic, readonly) NSString* name;
@property (nonatomic, readonly) NSMutableDictionary* devices;

- (instancetype)initWithName:(NSString*)name;
- (void)addDevice:(PilightDevice*)device;

@end
