//
//  ViewControllerProtocol.h
//  STCBinder
//
//  Created by chenxiancai on 2019/10/7.
//  Copyright © 2019 stevchen. All rights reserved.
//

#ifndef ViewControllerProtocol_h
#define ViewControllerProtocol_h
#import <objc/runtime.h>


@protocol viewControllerProtocol <NSObject>

- (void)voidMethod;

- (void)voidMethodWithParam1:(NSString *)param1 andParam2:(NSString *)param2;

- (id)idMethod;

//- (NSString *)nsstringMethod;
//
//- (BOOL)boolMethod;
//
//- (Class)classMethod;
//
//- (SEL)selMethod;

//- (char)charMethod;
//
//- (unsigned char)unsignedCharMethod;
//
//- (short)shortMethod;
//
//- (unsigned short)unsignedShortMethod;
//
//- (int)intMethod;
//
//- (unsigned int)unsignedIntMethod;
//
//- (long)longMethod;
//
//- (unsigned long)unsignedLongMethod;
//
//- (long long)longlongMethod;
//
//- (unsigned long long)unsignedlonglongMethod;
//
//- (float)floatMethod;
//
//- (double)doubleMethod;
//
//- (char *)charPointMethod;
//
//- (void *)pointMethod;
//
//- (CGSize)structMethod;


@end

#endif /* ViewControllerProtocol_h */
