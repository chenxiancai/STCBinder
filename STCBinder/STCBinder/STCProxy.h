//
//  STCProxy.h
//  STCBinder
//
//  Created by chenxiancai on 24/09/2017.
//  Copyright © 2017 stevchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STCProxy : NSProxy

/**
 weak target
 */
@property (nonatomic, weak, readonly) id target;

/**
 create a weak target
 
 @param target object to be weak target
 @return new proxy
 */
+ (instancetype)proxyWithTarget:(id)target;


- (SEL)selectorBlock:(void (^)(id arg))block;


@end
