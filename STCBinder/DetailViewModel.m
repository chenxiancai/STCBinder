//
//  DetailViewModel.m
//  STCBinder
//
//  Created by chenxiancai on 2019/10/17.
//  Copyright © 2019 stevchen. All rights reserved.
//

#import "DetailViewModel.h"

@implementation DetailViewModel

- (void)actionBindedProperty:(NSString *)property withTarget:(id)target actionBlock:(ReactBlock)block
{
    [super actionBindedProperty:property withTarget:target actionBlock:block];
}

@end
