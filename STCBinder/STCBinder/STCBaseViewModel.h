//
//  STCBaseViewModel.h
//  STCBinder
//
//  Created by chenxiancai on 24/09/2017.
//  Copyright © 2017 stevchen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ReactBlock)(id value, id viewModel);

#define STCGetPropertyName(property) NSStringFromSelector(@selector(property))

@interface STCBaseViewModel : NSObject

- (instancetype)init;

- (SEL)selectorBlock:(void (^)(id arg))block;

/**
 bind viewModel property with block
 把viewModel属性和block对象绑定
 
 @param propertyName propertyName of viewModel
 @param block block
 */
- (void)bindProperty:(NSString *)propertyName withReactBlock:(ReactBlock)block;

/**
 unbind viewModel property with block
 把属性和block解绑

 @param propertyName propertyName of viewModel
 @param block  block
 */
- (void)unbindProperty:(NSString *)propertyName withReactBlock:(ReactBlock)block;

/**
 删除绑定的block
 */
- (void)removeAllBlocks;



@end
