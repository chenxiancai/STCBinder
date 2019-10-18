//
//  ViewModel.m
//  STCBinder
//
//  Created by chenxiancai on 2019/9/10.
//  Copyright © 2019 stevchen. All rights reserved.
//

#import "ViewModel.h"

@implementation ViewModel 

- (void)actionBindedProperty:(NSString *)property withTarget:(id)target actionBlock:(ReactBlock)block
{
    [super actionBindedProperty:property withTarget:target actionBlock:block];
}

@end
