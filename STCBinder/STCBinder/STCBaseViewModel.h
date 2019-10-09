//
//  STCBaseViewModel.h
//  STCBinder
//
//  Created by chenxiancai on 24/09/2017.
//  Copyright © 2017 stevchen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ReactBlock)(id value, id viewModel);
typedef void(^ProtocolBlock)(SEL selector, id viewModel);

#define STCGetSeletorName(value) STCGetPropertyName(value)
#define STCGetPropertyName(value) NSStringFromSelector(@selector(value))
#define STCGetProtocolName(value) NSStringFromProtocol(@protocol(value))

@interface STCBaseViewModel : NSObject

- (instancetype)init;

- (SEL)reactBlock:(nonnull void (^)(id arg))block;

/**
 bind viewModel property with block
 把viewModel属性和block对象绑定
 
 @param propertyName propertyName of viewModel
 @param block block
 */
- (STCBaseViewModel *)bindProperty:(nonnull NSString *)propertyName
      withReactBlock:(nonnull ReactBlock)block;

/**
 unbind viewModel property with block
 把属性和block解绑

 @param propertyName propertyName of viewModel
 @param block  block
 */
- (STCBaseViewModel *)unbindProperty:(nonnull NSString *)propertyName
        withReactBlock:(nonnull ReactBlock)block;

/**
 删除绑定的block
 */
- (void)disposeAllReactBlocks;

- (STCBaseViewModel *)bindProtocol:(nonnull NSString *)protocol
                    withReactBlock:(nonnull id (^)(id arg,NSString *selName))block;

- (STCBaseViewModel *)bindProtocolMethod:(nonnull NSString *)method
                          withReactBlock:(nonnull id (^)(id arg,NSString *selName))block;



@end
