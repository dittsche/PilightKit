//
//  PLAppDelegate.h
//  PilightKit
//
//  Created by CocoaPods on 04/29/2015.
//  Copyright (c) 2014 Alexander Dittrich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PilightKit/PilightKit.h>

@interface PLAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) PilightControl *control;

@end
