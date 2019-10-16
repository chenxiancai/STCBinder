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

typedef unsigned char u_char;
typedef unsigned short u_short;
typedef unsigned int u_int;
typedef unsigned long u_long;
typedef long long long_long;
typedef unsigned long long u_long_long;
typedef void * point;
typedef char * c_point;

#define TEST_METHOD_WITH_TYPE_AND_ARG(type)\
- (type)type##MethodWithParam1:(type)param1 andParam2:(type)param2;

#define TEST_METHOD_WITH_TYPE_WITHOUT_ARG(type)\
- (type)type##Method;


@protocol viewControllerProtocol <NSObject>

TEST_METHOD_WITH_TYPE_WITHOUT_ARG(BOOL)
TEST_METHOD_WITH_TYPE_WITHOUT_ARG(char)
TEST_METHOD_WITH_TYPE_WITHOUT_ARG(u_char)
TEST_METHOD_WITH_TYPE_WITHOUT_ARG(short)
TEST_METHOD_WITH_TYPE_WITHOUT_ARG(u_short)
TEST_METHOD_WITH_TYPE_WITHOUT_ARG(int)
TEST_METHOD_WITH_TYPE_WITHOUT_ARG(u_int)
TEST_METHOD_WITH_TYPE_WITHOUT_ARG(long)
TEST_METHOD_WITH_TYPE_WITHOUT_ARG(u_long)
TEST_METHOD_WITH_TYPE_WITHOUT_ARG(long_long)
TEST_METHOD_WITH_TYPE_WITHOUT_ARG(u_long_long)
TEST_METHOD_WITH_TYPE_WITHOUT_ARG(float)
TEST_METHOD_WITH_TYPE_WITHOUT_ARG(double)

TEST_METHOD_WITH_TYPE_AND_ARG(BOOL)
TEST_METHOD_WITH_TYPE_AND_ARG(char)
TEST_METHOD_WITH_TYPE_AND_ARG(u_char)
TEST_METHOD_WITH_TYPE_AND_ARG(short)
TEST_METHOD_WITH_TYPE_AND_ARG(u_short)
TEST_METHOD_WITH_TYPE_AND_ARG(int)
TEST_METHOD_WITH_TYPE_AND_ARG(u_int)
TEST_METHOD_WITH_TYPE_AND_ARG(long)
TEST_METHOD_WITH_TYPE_AND_ARG(u_long)
TEST_METHOD_WITH_TYPE_AND_ARG(long_long)
TEST_METHOD_WITH_TYPE_AND_ARG(u_long_long)
TEST_METHOD_WITH_TYPE_AND_ARG(float)
TEST_METHOD_WITH_TYPE_AND_ARG(double)



- (Class)classMethod;

- (SEL)selMethod;

- (char)charMethod;

- (unsigned char)unsignedCharMethod;

- (short)shortMethod;

- (unsigned short)unsignedShortMethod;

- (int)intMethod;

- (unsigned int)unsignedIntMethod;

- (long)longMethod;

- (unsigned long)unsignedLongMethod;

- (long long)longlongMethod;

- (unsigned long long)unsignedlonglongMethod;

- (float)floatMethod;

- (double)doubleMethod;

- (char *)charPointMethod;

- (void *)pointMethod;

- (CGSize)CGSizetMethod;

- (CGPoint)CGPointMethod;

- (CGVector)CGVectorMethod;

- (CGRect)CGRectMethod;

- (CGAffineTransform)CGAffineTransformMethod;

- (UIEdgeInsets)UIEdgeInsetsMethod;

- (UIOffset)UIOffsetMethod;

- (NSDirectionalEdgeInsets)NSDirectionalEdgeInsetsMethod;


@end

#endif /* ViewControllerProtocol_h */

