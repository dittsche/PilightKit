//
//  PilightControlDelegate.h
//  PilightKit
//
//  Created by Alexander Dittrich on 04.04.15.
//  Copyright (c) 2015 Alexander Dittrich. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PilightControl;

@protocol PilightControlDelegate <NSObject>

@required
- (void)control:(PilightControl*)control didConnectToHost:(NSString*)host;
- (void)control:(PilightControl*)control didDisconnectFromHost:(NSString*)host withError:(NSError*)error;
- (void)controlDidParseConfig:(PilightControl*)control;

@optional
- (void)control:(PilightControl *)control didReceiveMessage:(NSDictionary*)message;
- (void)control:(PilightControl *)control didReceiveSocketData:(NSDictionary*)data;

@end