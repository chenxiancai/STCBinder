//
//  STCBaseViewModel.h
//  STCBinder
//
//  Created by chenxiancai on 24/09/2017.
//  Copyright © 2017 stevchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class STCBaseViewModel;
NS_ASSUME_NONNULL_BEGIN

typedef void(^ReactBlock)(id value, _Nullable id target,__kindof STCBaseViewModel *viewModel);
typedef id _Nullable (^EventBlock)(NSArray *arg,NSString *selName);

#define STCGetSeletorName(value) STCGetPropertyName(value)
#define STCGetPropertyName(value) NSStringFromSelector(@selector(value))
#define STCGetProtocolName(value) NSStringFromProtocol(@protocol(value))
#define STCNoStateProperty STCGetPropertyName(noStateProperty)

@interface STCBaseViewModel : NSObject

/// 无状态属性，用于事件透传使用
@property (nonatomic, strong, readonly) NSString *noStateProperty;

- (instancetype)init;

/// 绑定事件
/// @param propertyName 属性
/// @param block action事件回调
- (SEL)bindProperty:(NSString *)propertyName
    withActionBlock:(ReactBlock)block;

/// 绑定属性
/// @param propertyName 属性
/// @param block 属性变化回调
- (STCBaseViewModel *)bindProperty:(NSString *)propertyName
                    withReactBlock:(ReactBlock)block;

/// 解除属性绑定
/// @param propertyName 属性
/// @param block 属性变化回调
- (STCBaseViewModel *)unbindProperty:(NSString *)propertyName
                      withReactBlock:(ReactBlock)block;

/// 解除所有事件绑定
- (void)disposeAllReactBlocks;

/// 绑定代理协议所有方法
/// @param protocol 代理协议
/// @param block 代理事件回调
- (STCBaseViewModel *)bindProtocol:(NSString *)protocol
                    withEventBlock:(EventBlock)block;

/// 更新当前需要绑定的协议
/// @param protocol 代理协议名称，和代理协议方法绑定使用，实现链式编程
- (STCBaseViewModel *)updateCurrentProtocol:(NSString *)protocol;

/// 绑定代理协议方法
/// @param method 方法名称
/// @param block 代理事件回调
- (STCBaseViewModel *)bindProtocolEvent:(NSString *)method
                         withEventBlock:(EventBlock)block;

/// 绑定的事件传递AOP方法，该方法由子类继承，需要调用super方法
/// @param propertyName 属性名称
/// @param target 事件对象
/// @param block 事件回调
- (void)actionBindedProperty:(NSString *)propertyName
                  withTarget:(id)target
                 actionBlock:(ReactBlock)block;

@end

NS_ASSUME_NONNULL_END
