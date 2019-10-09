//
//  NewViewController.h
//  STCBinder
//
//  Created by chenxiancai on 2019/10/7.
//  Copyright © 2019 stevchen. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewViewController : ViewController

@property (nonatomic, weak) id<viewControllerProtocol> delegate;

- (void)test;

@end

NS_ASSUME_NONNULL_END
