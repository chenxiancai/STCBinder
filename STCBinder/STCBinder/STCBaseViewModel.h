//
//  STCBaseViewModel.h
//  STCBinder
//
//  Created by chenxiancai on 24/09/2017.
//  Copyright © 2017 stevchen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STCViewModelProtocol.h"

typedef void(^reactBlock)(id value, id viewModel);

#define STCGetPropertyName(property) NSStringFromSelector(@selector(property))

#define STCBindPropertyWithSeletor(vm, property, selector)\
{\
    __weak typeof(self) welf = self;\
    [vm bindProperty:STCGetPropertyName(property) withReactBlock:^(id value, id viewModel){\
            __strong typeof(welf) strongSelf = welf;\
            if ([strongSelf respondsToSelector:selector]){\
                [strongSelf performSelector:selector withObject:value withObject:viewModel];\
            }\
    }];\
}

@interface STCBaseViewModel : NSObject

/**
 viewModel initialization
 viewModel 初始化
 
 @param delegate STCViewModelProtocol delegate
 @return new viewModel
 */
- (instancetype)initWithDelegate:(id<STCViewModelProtocol>)delegate;

- (instancetype)init NS_UNAVAILABLE;

/**
 register ViewModel delegate
 注册viewModel代理
 
 @param delegate delegate
 */
- (void)registerDelegate:(id<STCViewModelProtocol>)delegate;

/**
 unRegister ViewModel delegate
 解除viewModel的代理注册
 
 @param delegate delegate
 */
- (void)unregisterDelegate:(id<STCViewModelProtocol>)delegate;

/**
 bind viewModel property with target
 把viewModel属性和目标对象绑定
 
 @param propertyName propertyName of viewModel
 @param target target
 */
- (void)bindProperty:(NSString *)propertyName withTarget:(id)target;

/**
 bind viewModel property with block
 把viewModel属性和block对象绑定
 
 @param propertyName propertyName of viewModel
 @param block block
 */
- (void)bindProperty:(NSString *)propertyName withReactBlock:(reactBlock)block;

/**
 unbind viewModel property with target
 把属性和目标对象解绑
 
 @param propertyName propertyName of viewModel
 @param target 目标对象
 */
- (void)unbindProperty:(NSString *)propertyName withTarget:(id)target;

/**
 unbind viewModel property with block
 把属性和block解绑

 @param propertyName propertyName of viewModel
 @param block  block
 */
- (void)unbindProperty:(NSString *)propertyName withReactBlock:(reactBlock)block;

/**
 update viewModel property without react action
 更新viewModel属性，但不进行响应操作
 
 @param propertyName propertyName of viewModel
 @param value new value
 */
- (void)updateProperty:(NSString *)propertyName withValue:(id)value;

@end
