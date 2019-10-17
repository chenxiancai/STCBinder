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
typedef id _Nullable (^ProtocolBlock)(id arg,NSString *selName);

#define STCGetSeletorName(value) STCGetPropertyName(value)
#define STCGetPropertyName(value) NSStringFromSelector(@selector(value))
#define STCGetProtocolName(value) NSStringFromProtocol(@protocol(value))

@interface STCBaseViewModel : NSObject

- (instancetype)init;

- (SEL)bindProperty:(NSString *)propertyName withActionBlock:(ReactBlock)block;

- (STCBaseViewModel *)bindProperty:(NSString *)propertyName
      withReactBlock:(ReactBlock)block;

- (STCBaseViewModel *)unbindProperty:(NSString *)propertyName
        withReactBlock:(ReactBlock)block;

- (void)disposeAllReactBlocks;

- (STCBaseViewModel *)bindProtocol:(NSString *)protocol
                    withReactBlock:(ProtocolBlock)block;

- (STCBaseViewModel *)updateCurrentProtocol:(NSString *)protocol;

- (STCBaseViewModel *)bindProtocolMethod:(NSString *)method
                          withReactBlock:(ProtocolBlock)block;

- (void)actionBindedProperty:(NSString *)propertyName withArg:(id)arg actionBlock:(ReactBlock)block;

@end

NS_ASSUME_NONNULL_END
