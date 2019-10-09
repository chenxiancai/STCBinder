//
//  STCBaseViewModel.h
//  STCBinder
//
//  Created by chenxiancai on 24/09/2017.
//  Copyright © 2017 stevchen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ReactBlock)(id value, id viewModel);
typedef id (^ProtocolBlock)(id arg,NSString *selName);

#define STCGetSeletorName(value) STCGetPropertyName(value)
#define STCGetPropertyName(value) NSStringFromSelector(@selector(value))
#define STCGetProtocolName(value) NSStringFromProtocol(@protocol(value))

@interface STCBaseViewModel : NSObject

- (instancetype)init;

- (SEL)reactBlock:(void (^)(id arg))block;

/**
 bind viewModel property with block
 把viewModel属性和block对象绑定
 
 @param propertyName propertyName of viewModel
 @param block block
 */
- (STCBaseViewModel *)bindProperty:(NSString *)propertyName
      withReactBlock:(ReactBlock)block;

/**
 unbind viewModel property with block
 把属性和block解绑

 @param propertyName propertyName of viewModel
 @param block  block
 */
- (STCBaseViewModel *)unbindProperty:(NSString *)propertyName
        withReactBlock:(ReactBlock)block;

/**
 删除绑定的block
 */
- (void)disposeAllReactBlocks;

- (STCBaseViewModel *)bindProtocol:(NSString *)protocol
                    withReactBlock:(ProtocolBlock)block;

- (STCBaseViewModel *)updateCurrentProtocol:(NSString *)protocol;

- (STCBaseViewModel *)bindProtocolMethod:(NSString *)method
                          withReactBlock:(ProtocolBlock)block;


@end

NS_ASSUME_NONNULL_END
