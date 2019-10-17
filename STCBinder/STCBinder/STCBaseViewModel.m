//
//  STCBaseViewModel.m
//  STCBinder
//
//  Created by chenxiancai on 24/09/2017.
//  Copyright © 2017 stevchen. All rights reserved.
//

#import "STCBaseViewModel.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wvarargs"

typedef unsigned char u_char;
typedef unsigned short u_short;
typedef unsigned int u_int;
typedef unsigned long u_long;
typedef long long long_long;
typedef unsigned long long u_long_long;
typedef void * point;
typedef char * c_point;

#define GET_ARGS \
{\
    NSMethodSignature *signature = [self methodSignatureForSelector:_cmd];\
    NSUInteger numberOfArguments = signature.numberOfArguments;\
    va_list list;\
    va_start(list, _cmd);\
    for (int i = 2; i < numberOfArguments; i ++) {\
        char returnArgType[255];\
        strcpy(returnArgType, [signature getArgumentTypeAtIndex:i]);\
        switch (returnArgType[0]) {\
            case _C_ID: {\
                id value =  (id)va_arg(list, id);\
                value ? [params addObject:value] : [params addObject:[NSValue valueWithPointer:nil]];\
                break;\
            }\
            case _C_CLASS: {\
                Class value =  (Class)va_arg(list, Class);\
                value ? [params addObject:value] : [params addObject:[NSValue valueWithPointer:nil]];\
                break;\
            }\
            case _C_SEL: {\
                SEL value = va_arg(list, SEL);\
                value ? [params addObject:NSStringFromSelector(value)] : [params addObject:[NSValue valueWithPointer:nil]];\
                break;\
            }\
            case _C_PTR: {\
                void *value = va_arg(list, void *);\
                [params addObject:[NSValue valueWithPointer:value]];\
                break;\
            }\
            case _C_CHARPTR: {\
                char *value = va_arg(list, char *);\
                value ? [params addObject:@(value)] : [params addObject:[NSValue valueWithPointer:nil]];\
                break;\
            }\
            case _C_STRUCT_B: {\
                NSString *types = [NSString stringWithUTF8String:returnArgType];\
                if ([types hasPrefix:@"{CGSize"]) {\
                    CGSize value =  (CGSize)va_arg(list, CGSize);\
                    [params addObject:@(value)];\
                } else if ([types hasPrefix:@"{CGPoint"]) {\
                    CGPoint value =  (CGPoint)va_arg(list, CGPoint);\
                    [params addObject:@(value)];\
                } else if ([types hasPrefix:@"{CGVector"]) {\
                    CGVector value =  (CGVector)va_arg(list, CGVector);\
                    [params addObject:@(value)];\
                } else if ([types hasPrefix:@"{CGRect"]) {\
                    CGRect value =  (CGRect)va_arg(list, CGRect);\
                    [params addObject:@(value)];\
                } else if ([types hasPrefix:@"{UIEdgeInsets"]) {\
                    UIEdgeInsets value =  (UIEdgeInsets)va_arg(list, UIEdgeInsets);\
                    [params addObject:@(value)];\
                } else if ([types hasPrefix:@"{UIOffset"]) {\
                    UIOffset value =  (UIOffset)va_arg(list, UIOffset);\
                    [params addObject:@(value)];\
                } else if ([types hasPrefix:@"{NSDirectionalEdgeInsets"]) {\
                    if (@available(iOS 11.0, *)) {\
                        NSDirectionalEdgeInsets value =  (NSDirectionalEdgeInsets)va_arg(list, NSDirectionalEdgeInsets);\
                        [params addObject:@(value)];\
                    }\
                } else if ([types hasPrefix:@"{CGAffineTransform"]) {\
                    CGAffineTransform value =  (CGAffineTransform)va_arg(list, CGAffineTransform);\
                    [params addObject:[NSValue valueWithCGAffineTransform:value]];\
                } else if ([types hasPrefix:@"{_NSRange"]) {\
                    NSRange value =  (NSRange)va_arg(list, NSRange);\
                    [params addObject:[NSValue valueWithRange:value]];\
                } else if ([types hasPrefix:@"{CATransform3D"]) {\
                    CATransform3D value =  (CATransform3D)va_arg(list, CATransform3D);\
                    [params addObject:[NSValue valueWithCATransform3D:value]];\
                }\
                break;\
            }\
            case _C_CHR: {\
                char value =  (char)va_arg(list, char);\
                [params addObject:@(value)];\
                break;\
            }\
            case _C_UCHR: {\
                u_char value =  (u_char)va_arg(list, u_char);\
                [params addObject:@(value)];\
                break;\
            }\
            case _C_SHT: {\
                short value =  (short)va_arg(list, short);\
                [params addObject:@(value)];\
                break;\
            }\
            case _C_USHT: {\
                u_short value =  (u_short)va_arg(list, u_short);\
                [params addObject:@(value)];\
                break;\
            }\
            case _C_INT: {\
                int value =  (int)va_arg(list, int);\
                [params addObject:@(value)];\
                break;\
            }\
            case _C_UINT: {\
                u_int value =  (u_int)va_arg(list, u_int);\
                [params addObject:@(value)];\
                break;\
            }\
            case _C_LNG: {\
                long value =  (long)va_arg(list, long);\
                [params addObject:@(value)];\
                break;\
            }\
            case _C_ULNG: {\
                u_long value =  (u_long)va_arg(list, u_long);\
                [params addObject:@(value)];\
                break;\
            }\
            case _C_LNG_LNG: {\
                long_long value =  (long_long)va_arg(list, long_long);\
                [params addObject:@(value)];\
                break;\
            }\
            case _C_ULNG_LNG: {\
                u_long_long value =  (u_long_long)va_arg(list, u_long_long);\
                [params addObject:@(value)];\
                break;\
            }\
            case _C_FLT: {\
                float value =  (float)va_arg(list, float);\
                [params addObject:@(value)];\
                break;\
            }\
            case _C_DBL: {\
                double value =  (double)va_arg(list, double);\
                [params addObject:@(value)];\
                break;\
            }\
            case _C_BOOL: {\
                BOOL value =  (BOOL)va_arg(list, BOOL);\
                [params addObject:@(value)];\
                break;\
            }\
            default: {\
                break;\
            }\
        }\
    }\
    va_end(list);\
}

#define GetProtocolIMPWithoutArg(returnType) impWithNoArgAndReturnType_##returnType

#define ProtocolIMPWithoutArg(returnType, defautValue)   \
static returnType impWithNoArgAndReturnType_##returnType(id self, SEL _cmd) {\
    NSString *selName = NSStringFromSelector(_cmd);\
    NSNumber * (^block)(id arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);\
    if (block) {\
        NSNumber *value = block(nil,selName);\
        char returnValueType[255];\
        strcpy(returnValueType, @encode(returnType));\
        switch (returnValueType[0]) {\
               case _C_CHR: {\
                   return (returnType)[value charValue];\
                   break;\
               }\
               case _C_UCHR: {\
                   return (returnType)[value unsignedCharValue];\
                   break;\
               }\
               case _C_SHT: {\
                   return (returnType)[value shortValue];\
                   break;\
               }\
               case _C_USHT: {\
                   return (returnType)[value unsignedShortValue];\
                   break;\
               }\
               case _C_INT: {\
                   return (returnType)[value intValue];\
                   break;\
               }\
               case _C_UINT: {\
                   return (returnType)[value unsignedIntValue];\
                   break;\
               }\
               case _C_LNG: {\
                   return (returnType)[value longValue];\
                   break;\
               }\
               case _C_ULNG: {\
                   return (returnType)[value unsignedLongValue];\
                   break;\
               }\
               case _C_LNG_LNG: {\
                   return (returnType)[value longLongValue];\
                   break;\
               }\
               case _C_ULNG_LNG: {\
                   return (returnType)[value unsignedLongLongValue];\
                   break;\
               }\
               case _C_FLT: {\
                   return (returnType)[value floatValue];\
                   break;\
               }\
               case _C_DBL: {\
                   return (returnType)[value doubleValue];\
                   break;\
               }\
               case _C_BOOL: {\
                   return (returnType)[value boolValue];\
                   break;\
               }\
               default: {\
                   return defautValue;\
               }\
        }\
    } else {\
        return defautValue;\
    }\
}

ProtocolIMPWithoutArg(BOOL, NO)
ProtocolIMPWithoutArg(char, 0)
ProtocolIMPWithoutArg(u_char, 0)
ProtocolIMPWithoutArg(short, 0)
ProtocolIMPWithoutArg(u_short, 0)
ProtocolIMPWithoutArg(int, 0)
ProtocolIMPWithoutArg(u_int, 0)
ProtocolIMPWithoutArg(long, 0)
ProtocolIMPWithoutArg(u_long, 0)
ProtocolIMPWithoutArg(long_long, 0)
ProtocolIMPWithoutArg(u_long_long, 0)
ProtocolIMPWithoutArg(float, 0)
ProtocolIMPWithoutArg(double, 0)

#define ProtocolStructIMP_2Value(returnType)   \
static returnType impWithArgAndReturnType_##returnType(id self, SEL _cmd, ...) {\
    NSString *selName = NSStringFromSelector(_cmd);\
    NSMutableArray *params = [NSMutableArray array];\
    GET_ARGS\
    NSValue * (^block)(NSArray *arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);\
    if (block) {\
        NSValue *value = block(params,selName);\
        return [value returnType##Value];\
    } else {\
        return returnType##Make(0, 0);\
    }\
}

#define ProtocolStructIMP_4Value(returnType)   \
static returnType impWithArgAndReturnType_##returnType(id self, SEL _cmd, ...) {\
    NSString *selName = NSStringFromSelector(_cmd);\
    NSMutableArray *params = [NSMutableArray array];\
    GET_ARGS\
    NSValue * (^block)(NSArray *arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);\
    if (block) {\
        NSValue *value = block(params,selName);\
        return [value returnType##Value];\
    } else {\
        return returnType##Make(0, 0, 0, 0);\
    }\
}

#define ProtocolStructIMP_6Value(returnType)   \
static returnType impWithArgAndReturnType_##returnType(id self, SEL _cmd, ...) {\
    NSString *selName = NSStringFromSelector(_cmd);\
    NSMutableArray *params = [NSMutableArray array];\
    GET_ARGS\
    NSValue * (^block)(NSArray *arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);\
    if (block) {\
        NSValue *value = block(params,selName);\
        return [value returnType##Value];\
    } else {\
        return returnType##Make(0, 0, 0, 0, 0, 0);\
    }\
}

#define ProtocolStructIMPWithoutArg_2Value(returnType)   \
static returnType impWithNoArgAndReturnType_##returnType(id self, SEL _cmd) {\
    NSString *selName = NSStringFromSelector(_cmd);\
    NSValue * (^block)(id arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);\
    if (block) {\
        NSValue *value = block(nil,selName);\
        return [value returnType##Value];\
    } else {\
        return returnType##Make(0, 0);\
    }\
}

#define ProtocolStructIMPWithoutArg_4Value(returnType)   \
static returnType impWithNoArgAndReturnType_##returnType(id self, SEL _cmd) {\
    NSString *selName = NSStringFromSelector(_cmd);\
    NSValue * (^block)(id arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);\
    if (block) {\
        NSValue *value = block(nil,selName);\
        return [value returnType##Value];\
    } else {\
        return returnType##Make(0, 0, 0, 0);\
    }\
}

#define ProtocolStructIMPWithoutArg_6Value(returnType)   \
static returnType impWithNoArgAndReturnType_##returnType(id self, SEL _cmd) {\
    NSString *selName = NSStringFromSelector(_cmd);\
    NSValue * (^block)(id arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);\
    if (block) {\
        NSValue *value = block(nil,selName);\
        return [value returnType##Value];\
    } else {\
        return returnType##Make(0, 0, 0, 0, 0, 0);\
    }\
}

ProtocolStructIMP_2Value(CGSize)
ProtocolStructIMPWithoutArg_2Value(CGSize)
ProtocolStructIMP_2Value(CGPoint)
ProtocolStructIMPWithoutArg_2Value(CGPoint)
ProtocolStructIMP_2Value(CGVector)
ProtocolStructIMPWithoutArg_2Value(CGVector)
ProtocolStructIMP_4Value(CGRect)
ProtocolStructIMPWithoutArg_4Value(CGRect)
ProtocolStructIMP_6Value(CGAffineTransform)
ProtocolStructIMPWithoutArg_6Value(CGAffineTransform)
ProtocolStructIMP_4Value(UIEdgeInsets)
ProtocolStructIMPWithoutArg_4Value(UIEdgeInsets)
ProtocolStructIMP_2Value(UIOffset)
ProtocolStructIMPWithoutArg_2Value(UIOffset)

#ifndef FOUNDATION_HAS_DIRECTIONAL_GEOMETRY

static NSDirectionalEdgeInsets impWithArgAndReturnType_NSDirectionalEdgeInsets(id self, SEL _cmd,  ... )API_AVAILABLE(ios(11.0),tvos(11.0),watchos(4.0))
{
    NSString *selName = NSStringFromSelector(_cmd);
    NSMutableArray *params = [NSMutableArray array];
    GET_ARGS
    NSValue * (^block)(NSArray* params, NSString *selName) = objc_getAssociatedObject(self, _cmd);
    if (block) {
        NSValue *value = block(params,selName);
        return [value directionalEdgeInsetsValue];
    } else {
        return NSDirectionalEdgeInsetsMake(0, 0, 0, 0);
    }
}

static NSDirectionalEdgeInsets impWithNoArgAndReturnType_NSDirectionalEdgeInsets(id self, SEL _cmd)API_AVAILABLE(ios(11.0),tvos(11.0),watchos(4.0))
{
    NSString *selName = NSStringFromSelector(_cmd);
    NSValue * (^block)(id arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);
    if (block) {
        NSValue *value = block(nil,selName);
        return [value directionalEdgeInsetsValue];
    } else {
        return NSDirectionalEdgeInsetsMake(0, 0, 0, 0);
    }
}

#endif

static NSRange impWithArgAndReturnType_NSRange(id self, SEL _cmd, ...)
{
    NSString *selName = NSStringFromSelector(_cmd);
    NSMutableArray *params = [NSMutableArray array];
    GET_ARGS
    NSValue * (^block)(NSArray *arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);
    if (block) {
        NSValue *value = block(params,selName);
        return [value rangeValue];
    } else {
        return NSMakeRange(0, 0);
    }
}

static NSRange impWithNoArgAndReturnType_NSRange(id self, SEL _cmd)
{
    NSString *selName = NSStringFromSelector(_cmd);
    NSValue * (^block)(id arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);
    if (block) {
        NSValue *value = block(nil,selName);
        return [value rangeValue];
    } else {
        return NSMakeRange(0, 0);
    }
}

static CATransform3D impWithArgAndReturnType_CATransform3D(id self, SEL _cmd, ...)
{
    NSString *selName = NSStringFromSelector(_cmd);
    NSMutableArray *params = [NSMutableArray array];
    GET_ARGS
    NSValue * (^block)(NSArray *arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);
    if (block) {
        NSValue *value = block(params,selName);
        return [value CATransform3DValue];
    } else {
        return CATransform3DIdentity;
    }
}

static CATransform3D impWithNoArgAndReturnType_CATransform3D(id self, SEL _cmd)
{
    NSString *selName = NSStringFromSelector(_cmd);
    NSValue * (^block)(id arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);
    if (block) {
        NSValue *value = block(nil,selName);
        return [value CATransform3DValue];
    } else {
        return CATransform3DIdentity;
    }
}

static void impWithArgAndReturnType_void(id self, SEL _cmd, ...)
{
    NSString *selName = NSStringFromSelector(_cmd);
    NSMutableArray *params = [NSMutableArray array];
    GET_ARGS
    void (^block)(NSArray *arg,NSString *selName) = objc_getAssociatedObject(self, _cmd);
    if (block) block(params,selName);
}

static void impWithNoArgAndReturnType_void(id self, SEL _cmd) {
    NSString *selName = NSStringFromSelector(_cmd);
    void (^block)(id arg,NSString *selName) = objc_getAssociatedObject(self, _cmd);
    if (block) block(nil,selName);
}

static id impWithArgAndReturnType_id(id self, SEL _cmd, ...) {
    NSString *selName = NSStringFromSelector(_cmd);
    NSMutableArray *params = [NSMutableArray array];
    GET_ARGS
    id (^block)(NSArray *arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);
    if (block) {
        return  block(params,selName);
    } else {
        return nil;
    }
}

static id impWithNoArgAndReturnType_id(id self, SEL _cmd) {
    NSString *selName = NSStringFromSelector(_cmd);
    id (^block)(id arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);
    if (block) {
        return  block(nil,selName);
    } else {
        return nil;
    }
}

static Class impWithArgAndReturnType_Class(id self, SEL _cmd, ...) {
    NSString *selName = NSStringFromSelector(_cmd);
    NSMutableArray *params = [NSMutableArray array];
    GET_ARGS
    id (^block)(NSArray *arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);
    if (block) {
        return block(params,selName);
    } else {
        return NULL;
    }
}

static Class impWithNoArgAndReturnType_Class(id self, SEL _cmd) {
    NSString *selName = NSStringFromSelector(_cmd);
    id (^block)(id arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);
    if (block) {
        return block(nil,selName);
    } else {
        return NULL;
    }
}

static SEL impWithArgAndReturnType_SEL(id self, SEL _cmd, ...) {
    NSString *selName = NSStringFromSelector(_cmd);
    NSMutableArray *params = [NSMutableArray array];
    GET_ARGS
    id (^block)(NSArray *arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);
    if (block) {
        NSString *value =  block(params,selName);
        return NSSelectorFromString(value);
    } else {
        return NULL;
    }
}

static SEL impWithNoArgAndReturnType_SEL(id self, SEL _cmd) {
    NSString *selName = NSStringFromSelector(_cmd);
    id (^block)(id arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);
    if (block) {
        NSString *value =  block(nil,selName);
        return NSSelectorFromString(value);
    } else {
        return NULL;
    }
}

static point impWithArgAndReturnType_point(id self, SEL _cmd, ...) {
    NSString *selName = NSStringFromSelector(_cmd);
    NSMutableArray *params = [NSMutableArray array];
    GET_ARGS
    NSValue * (^block)(NSArray *arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);
    if (block) {
        NSValue *value = block(params,selName);
        return [value pointerValue];
    } else {
        return NULL;
    }
}

static point impWithNoArgAndReturnType_point(id self, SEL _cmd) {
    NSString *selName = NSStringFromSelector(_cmd);
    NSValue * (^block)(id arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);
    if (block) {
        NSValue *value = block(nil,selName);
        return [value pointerValue];
    } else {
        return NULL;
    }
}

static c_point impWithArgAndReturnType_c_point(id self, SEL _cmd, ...) {
    NSString *selName = NSStringFromSelector(_cmd);
    NSMutableArray *params = [NSMutableArray array];
    GET_ARGS
    NSValue * (^block)(NSArray *arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);
    if (block) {
        NSValue *value = block(params,selName);
        return [value pointerValue];
    } else {
        return NULL;
    }
}

static c_point impWithNoArgAndReturnType_c_point(id self, SEL _cmd) {
    NSString *selName = NSStringFromSelector(_cmd);
    NSValue * (^block)(id arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);
    if (block) {
        NSValue *value = block(nil,selName);
        return [value pointerValue];
    } else {
        return NULL;
    }
}

#define GetProtocolIMPWithArg(returnType) impWithArgAndReturnType_##returnType

#define AddMethod(selName, sel, types, returnType)\
if ([selName containsString:@":"]) {\
    class_addMethod([self class], sel, (IMP)GetProtocolIMPWithArg(returnType), types.UTF8String);\
} else {\
    class_addMethod([self class], sel, (IMP)GetProtocolIMPWithoutArg(returnType), types.UTF8String);\
}


#define ProtocolIMPWithArg(returnType, defautValue)   \
static returnType impWithArgAndReturnType_##returnType(id self, SEL _cmd, ...)\
{\
    NSString *selName = NSStringFromSelector(_cmd);\
    NSMutableArray *params = [NSMutableArray array];\
    GET_ARGS\
    NSNumber* (^block)(NSArray *args, NSString *selName) = objc_getAssociatedObject(self, _cmd);\
    if (block) {\
        NSNumber *value = block([NSArray arrayWithArray:params],selName);\
        char returnValueType[255];\
        strcpy(returnValueType, @encode(returnType));\
        switch (returnValueType[0]) {\
               case _C_CHR: {\
                   return (returnType)[value charValue];\
                   break;\
               }\
               case _C_UCHR: {\
                   return (returnType)[value unsignedCharValue];\
                   break;\
               }\
               case _C_SHT: {\
                   return (returnType)[value shortValue];\
                   break;\
               }\
               case _C_USHT: {\
                   return (returnType)[value unsignedShortValue];\
                   break;\
               }\
               case _C_INT: {\
                   return (returnType)[value intValue];\
                   break;\
               }\
               case _C_UINT: {\
                   return (returnType)[value unsignedIntValue];\
                   break;\
               }\
               case _C_LNG: {\
                   return (returnType)[value longValue];\
                   break;\
               }\
               case _C_ULNG: {\
                   return (returnType)[value unsignedLongValue];\
                   break;\
               }\
               case _C_LNG_LNG: {\
                   return (returnType)[value longLongValue];\
                   break;\
               }\
               case _C_ULNG_LNG: {\
                   return (returnType)[value unsignedLongLongValue];\
                   break;\
               }\
               case _C_FLT: {\
                   return (returnType)[value floatValue];\
                   break;\
               }\
               case _C_DBL: {\
                   return (returnType)[value doubleValue];\
                   break;\
               }\
               case _C_BOOL: {\
                   return (returnType)[value boolValue];\
                   break;\
               }\
               default: {\
                   return defautValue;\
               }\
        }\
    } else {\
        return defautValue;\
    }\
}

ProtocolIMPWithArg(BOOL, NO)
ProtocolIMPWithArg(char, 0)
ProtocolIMPWithArg(u_char, 0)
ProtocolIMPWithArg(short, 0)
ProtocolIMPWithArg(u_short, 0)
ProtocolIMPWithArg(int, 0)
ProtocolIMPWithArg(u_int, 0)
ProtocolIMPWithArg(long, 0)
ProtocolIMPWithArg(u_long, 0)
ProtocolIMPWithArg(long_long, 0)
ProtocolIMPWithArg(u_long_long, 0)
ProtocolIMPWithArg(float, 0)
ProtocolIMPWithArg(double, 0)

@interface STCBaseViewModel ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableArray<ReactBlock> *> *binderReactBlockDict;
@property (nonatomic, strong) NSMutableArray<NSString *> *observerKeyPaths;
@property (nonatomic, strong) NSMutableArray<NSString *> *selNames;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSString *> *binderActionSelectorDict;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableArray <NSString *> *>*binderActionPropertyDict;

@property (nonatomic, strong) NSString *currentProtocol;

@end

@implementation STCBaseViewModel

- (void)dealloc
{
    for (NSString *keyPath in self.observerKeyPaths) {
        [self removeObserver:self forKeyPath:keyPath];
    }
    self.observerKeyPaths = nil;
    self.binderReactBlockDict = nil;
    self.selNames = nil;
    self.currentProtocol = nil;
    self.binderActionSelectorDict = nil;
    self.binderActionPropertyDict = nil;
    
    NSLog(@"STCBaseViewModel dealloc");
}

- (void)disposeAllReactBlocks
{
    for (NSString *selName in _selNames) {
        SEL sel = NSSelectorFromString(selName);
        objc_setAssociatedObject(self, sel, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    
    self.binderReactBlockDict = nil;
}

- (SEL)bindProperty:(NSString *)propertyName withActionBlock:(ReactBlock)block {
    NSString *selName = [NSString stringWithFormat:@"selector_%p:", block];
    [self.selNames addObject:selName];
    SEL sel = NSSelectorFromString(selName);
    class_addMethod([self class], sel, (IMP)selectorImp, "v@:@");
    objc_setAssociatedObject(self, sel, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self.binderActionSelectorDict addEntriesFromDictionary:@{selName: propertyName}];
    
    if ([self.binderActionPropertyDict objectForKey:propertyName]) {
        NSMutableArray *sels = [self.binderActionPropertyDict objectForKey:propertyName];
        [sels addObject:[selName copy]];
    } else {
        NSMutableArray *sels = [NSMutableArray arrayWithObject:[selName copy]];
        [self.binderActionPropertyDict addEntriesFromDictionary:@{propertyName: sels}];
        BOOL exist = NO;
        for (NSString *name in self.observerKeyPaths) {
            if ([name isEqualToString:propertyName]) {
                exist = YES;
                break;
            }
        }
        if (!exist) {
            [self.observerKeyPaths addObject:propertyName];
            [self addObserver:self forKeyPath:propertyName options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        }
    }
    return sel;
}

static void selectorImp(id self, SEL _cmd, id arg) {
    ReactBlock block = objc_getAssociatedObject(self, _cmd);
    if (block) {
        NSString *propertyName = [[(STCBaseViewModel *)self binderActionSelectorDict] objectForKey:NSStringFromSelector(_cmd)];
        [self actionBindedProperty:propertyName withArg:arg actionBlock:block];
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.binderReactBlockDict = [NSMutableDictionary dictionary];
        self.observerKeyPaths = [NSMutableArray array];
        self.selNames = [NSMutableArray array];
        self.binderActionSelectorDict = [NSMutableDictionary dictionary];
        self.binderActionPropertyDict = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark - binder methods

- (STCBaseViewModel *)bindProperty:(NSString *)propertyName withReactBlock:(ReactBlock)block
{
    if (propertyName && block) {
        if ([self.binderReactBlockDict objectForKey:propertyName]) {
            NSMutableArray *blockObjects = [self.binderReactBlockDict objectForKey:propertyName];
            [blockObjects addObject:[block copy]];
        } else {
            NSMutableArray *blockObjects = [NSMutableArray arrayWithObject:[block copy]];
            [self.binderReactBlockDict addEntriesFromDictionary:@{propertyName: blockObjects}];
            BOOL exist = NO;
            for (NSString *name in self.observerKeyPaths) {
                if ([name isEqualToString:propertyName]) {
                    exist = YES;
                    break;
                }
            }
            if (!exist) {
                [self.observerKeyPaths addObject:propertyName];
                [self addObserver:self forKeyPath:propertyName options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
            }
        }
    }
    return self;
}

- (STCBaseViewModel *)unbindProperty:(NSString *)propertyName withReactBlock:(ReactBlock)block
{
    if (propertyName && block) {
        if ([self.binderReactBlockDict objectForKey:propertyName]) {
            NSMutableArray *blockObjects = [self.binderReactBlockDict objectForKey:propertyName];
            for (ReactBlock reactBlock in blockObjects) {
                if (reactBlock == block) {
                    [blockObjects removeObject:reactBlock];
                    break;
                }
            }
            if (blockObjects.count == 0) {
                [self.binderReactBlockDict removeObjectForKey:propertyName];
                [self removeObserver:self forKeyPath:propertyName];
                for (NSString *keyPath in self.observerKeyPaths) {
                    if ([keyPath isEqualToString:propertyName]) {
                        [self.observerKeyPaths removeObject:keyPath];
                        break;
                    }
                }
                
            }
        }
    }
    
    return self;
}

- (STCBaseViewModel *)bindProtocol:(NSString *)protocol
                    withReactBlock:(ProtocolBlock)block;
{
    Protocol *pro = NSProtocolFromString(protocol);
    __block unsigned int methodCount = 0;
    void (^blk)(BOOL isRequiredMethod, BOOL isInstanceMethod) = ^(BOOL isRequiredMethod, BOOL isInstanceMethod){
        struct objc_method_description *method_description_list = protocol_copyMethodDescriptionList(pro, isRequiredMethod, isInstanceMethod, &methodCount);
        for (int i = 0; i < methodCount ; i ++){
            struct objc_method_description description = method_description_list[i];
            NSLog(@"name:%@ type:%@",NSStringFromSelector(description.name),[NSString stringWithUTF8String:description.types]);
            
            [self protocolBlock:block withSelectorName:NSStringFromSelector(description.name) types:[NSString stringWithUTF8String:description.types]];
        }
        free(method_description_list);
    };
    
    blk(YES, YES);
    blk(YES, NO);
    blk(NO, YES);
    blk(NO, NO);
    return self;
}

- (SEL)protocolBlock:(ProtocolBlock)block
    withSelectorName:(NSString *)selName
               types:(NSString *)types {
    
    [self.selNames addObject:selName];
    SEL sel = NSSelectorFromString(selName);
    const char *returnType = types.UTF8String;
    
    switch (returnType[0]) {
            // void
        case _C_VOID: {
            AddMethod(selName, sel, types, void)
            break;
        }
            // Objective-C object
        case _C_ID: {
            AddMethod(selName, sel, types, id)
            break;
        }
        case _C_CLASS: {
            AddMethod(selName, sel, types, Class)
            break;
        }
        case _C_SEL: {
            AddMethod(selName, sel, types, SEL)
            break;
        }
        case _C_CHR: {
            AddMethod(selName, sel, types, char)
            break;
        }
        case _C_UCHR: {
            AddMethod(selName, sel, types, u_char)
            break;
        }
        case _C_SHT: {
            AddMethod(selName, sel, types, short)
            break;
        }
        case _C_USHT: {
            AddMethod(selName, sel, types, u_short)
            break;
        }
        case _C_INT: {
            AddMethod(selName, sel, types, int)
            break;
        }
        case _C_UINT: {
            AddMethod(selName, sel, types, u_int)
            break;
        }
        case _C_LNG: {
            AddMethod(selName, sel, types, long)
            break;
        }
        case _C_ULNG: {
            AddMethod(selName, sel, types, u_long)
            break;
        }
        case _C_LNG_LNG: {
            AddMethod(selName, sel, types, long_long)
            break;
        }
        case _C_ULNG_LNG: {
            AddMethod(selName, sel, types, u_long_long)
            break;
        }
        case _C_FLT: {
            AddMethod(selName, sel, types, float)
            break;
        }
        case _C_DBL: {
            AddMethod(selName, sel, types, double)
            break;
        }
        case _C_BOOL: {
            AddMethod(selName, sel, types, BOOL)
            break;
        }
        // C Pointer
        case _C_PTR: {
            AddMethod(selName, sel, types, point)
            break;
        }
        case _C_CHARPTR: {
            AddMethod(selName, sel, types, c_point)
            break;
        }
        // Struct
        case _C_STRUCT_B: {
            if ([types hasPrefix:@"{CGSize"]) {
                AddMethod(selName, sel, types, CGSize)
            } else if ([types hasPrefix:@"{CGPoint"]) {
                AddMethod(selName, sel, types, CGPoint)
            } else if ([types hasPrefix:@"{CGVector"]) {
                AddMethod(selName, sel, types, CGVector)
            } else if ([types hasPrefix:@"{CGRect"]) {
                AddMethod(selName, sel, types, CGRect)
            } else if ([types hasPrefix:@"{CGAffineTransform"]) {
                AddMethod(selName, sel, types, CGAffineTransform)
            } else if ([types hasPrefix:@"{UIEdgeInsets"]) {
                AddMethod(selName, sel, types, UIEdgeInsets)
            } else if ([types hasPrefix:@"{UIOffset"]) {
                AddMethod(selName, sel, types, UIOffset)
            } else if ([types hasPrefix:@"{NSDirectionalEdgeInsets"]) {
                if (@available(iOS 11.0, *)) {
                    AddMethod(selName, sel, types, NSDirectionalEdgeInsets)
                }
            } else if ([types hasPrefix:@"{_NSRange"]) {
                AddMethod(selName, sel, types, NSRange)
            } else if ([types hasPrefix:@"{CATransform3D"]) {
                AddMethod(selName, sel, types, CATransform3D)
            }
            break;
        }
        default: {
            AddMethod(selName, sel, types, id)
            break;
        }
    }
    objc_setAssociatedObject(self, sel, block, OBJC_ASSOCIATION_COPY_NONATOMIC);

    return sel;
}

- (STCBaseViewModel *)updateCurrentProtocol:(NSString *)protocol
{
    self.currentProtocol = protocol;
    return self;
}

- (STCBaseViewModel *)bindProtocolMethod:(NSString *)method
                          withReactBlock:(ProtocolBlock)block
{
    if (!self.currentProtocol) {
        return self;
    }

    Protocol *pro = NSProtocolFromString(self.currentProtocol);
    __block unsigned int methodCount = 0;
    BOOL (^blk)(BOOL isRequiredMethod, BOOL isInstanceMethod) = ^ BOOL(BOOL isRequiredMethod, BOOL isInstanceMethod){
        struct objc_method_description *method_description_list = protocol_copyMethodDescriptionList(pro, isRequiredMethod, isInstanceMethod, &methodCount);
        BOOL isExits = NO;
        for (int i = 0; i < methodCount ; i ++){
            struct objc_method_description description = method_description_list[i];
            NSLog(@"name:%@ type:%@",NSStringFromSelector(description.name),[NSString stringWithUTF8String:description.types]);
            if ([NSStringFromSelector(description.name) isEqualToString:method]) {
                isExits = YES;
                [self protocolBlock:block withSelectorName:NSStringFromSelector(description.name) types:[NSString stringWithUTF8String:description.types]];
                break;
            }
        }
        free(method_description_list);
        return isExits;
    };

    BOOL isInstanceMethodExits = NO;
    BOOL isClassMethodExits = NO;
    
    isInstanceMethodExits = blk(YES, YES);
    isClassMethodExits = blk(YES, NO);

    if (!(isInstanceMethodExits || isClassMethodExits)) {
        blk(NO, YES);
        blk(NO, NO);
    }
    
    return self;
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context
{
    for (NSString *propertyName in self.observerKeyPaths) {
        if ([keyPath isEqualToString:propertyName]) {
            id value = [self valueForKey:propertyName];
            NSArray *reactBlocks = [[self.binderReactBlockDict objectForKey:propertyName] copy];
            for (ReactBlock block in reactBlocks) {
                if (block) {
                    block(value, nil, self);
                }
            }
            NSArray *sels = [[self.binderActionPropertyDict objectForKey:propertyName] copy];
            for (NSString *sel in sels) {
                ReactBlock block = objc_getAssociatedObject(self, NSSelectorFromString(sel));
                if (block) {
                    block(value, nil, self);
                }
            }
        }
    }
}

- (void)actionBindedProperty:(NSString *)propertyName withArg:(id)arg actionBlock:(ReactBlock)block
{
    if (block) {
        id value = [self valueForKey:propertyName];
        block(value, arg, self);
    }
}

@end

#pragma clang diagnostic pop
