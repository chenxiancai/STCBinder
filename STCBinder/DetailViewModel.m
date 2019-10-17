//
//  DetailViewModel.m
//  STCBinder
//
//  Created by chenxiancai on 2019/10/17.
//  Copyright © 2019 stevchen. All rights reserved.
//

#import "DetailViewModel.h"

@implementation DetailViewModel

- (void)actionBindedProperty:(NSString *)property withArg:(id)arg actionBlock:(ReactBlock)block
{
    NSLog(@"arg :%@", arg);
    if (arg) {
        [super actionBindedProperty:property withArg:arg actionBlock:block];
    }
}

@end
