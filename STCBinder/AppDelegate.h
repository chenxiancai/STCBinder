//
//  AppDelegate.h
//  STCBinder
//
//  Created by chenxiancai on 19/09/2017.
//  Copyright © 2017 stevchen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STCViewModelProtocol.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, STCViewModelProtocol>

@property (strong, nonatomic) UIWindow *window;

@end

