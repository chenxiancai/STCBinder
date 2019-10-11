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

typedef unsigned char u_char;
typedef unsigned short u_short;
typedef unsigned int u_int;
typedef unsigned long u_long;
typedef long long long_long;
typedef unsigned long long u_long_long;
typedef void * point;
typedef char * c_point;


#define GetProtocolIMP(returnType) impWithReturnType_##returnType
#define GetProtocolIMPWithoutArg(returnType) imp_noarg_withReturnType_##returnType

#define ProtocolIMP(returnType, defautValue)   \
static returnType impWithReturnType_##returnType(id self, SEL _cmd, id arg) {\
NSString *selName = NSStringFromSelector(_cmd);\
NSNumber * (^block)(id arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);\
if (block) {\
NSNumber *value =  block(arg,selName);\
if ([[NSString stringWithUTF8String:#returnType] isEqualToString:@"BOOL"]) {\
    return (returnType)[value boolValue];\
} else if ([[NSString stringWithUTF8String:#returnType] isEqualToString:@"char"]) {\
    return (returnType)[value charValue];\
} else if ([[NSString stringWithUTF8String:#returnType] isEqualToString:@"u_char"]) {\
    return (returnType)[value unsignedCharValue];\
} else if ([[NSString stringWithUTF8String:#returnType] isEqualToString:@"short"]) {\
    return (returnType)[value shortValue];\
} else if ([[NSString stringWithUTF8String:#returnType] isEqualToString:@"u_short"]) {\
    return (returnType)[value unsignedShortValue];\
} else if ([[NSString stringWithUTF8String:#returnType] isEqualToString:@"int"]) {\
    return (returnType)[value intValue];\
} else if ([[NSString stringWithUTF8String:#returnType] isEqualToString:@"u_int"]) {\
    return (returnType)[value unsignedIntValue];\
} else if ([[NSString stringWithUTF8String:#returnType] isEqualToString:@"long"]) {\
    return (returnType)[value longValue];\
} else if ([[NSString stringWithUTF8String:#returnType] isEqualToString:@"u_long"]) {\
    return (returnType)[value unsignedLongValue];\
} else if ([[NSString stringWithUTF8String:#returnType] isEqualToString:@"long_long"]) {\
    return (returnType)[value longLongValue];\
} else if ([[NSString stringWithUTF8String:#returnType] isEqualToString:@"u_long_long"]) {\
    return (returnType)[value unsignedLongLongValue];\
} else if ([[NSString stringWithUTF8String:#returnType] isEqualToString:@"float"]) {\
    return (returnType)[value floatValue];\
} else if ([[NSString stringWithUTF8String:#returnType] isEqualToString:@"double"]) {\
    return (returnType)[value doubleValue];\
} else {\
    return defautValue;\
}\
} else {\
return defautValue;\
}\
}

#define ProtocolIMPWithoutArg(returnType, defautValue)   \
static returnType imp_noarg_withReturnType_##returnType(id self, SEL _cmd) {\
NSString *selName = NSStringFromSelector(_cmd);\
NSNumber * (^block)(id arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);\
if (block) {\
NSNumber *value =  block(nil,selName);\
if ([[NSString stringWithUTF8String:#returnType] isEqualToString:@"BOOL"]) {\
    return (returnType)[value boolValue];\
} else if ([[NSString stringWithUTF8String:#returnType] isEqualToString:@"char"]) {\
    return (returnType)[value charValue];\
} else if ([[NSString stringWithUTF8String:#returnType] isEqualToString:@"u_char"]) {\
    return (returnType)[value unsignedCharValue];\
} else if ([[NSString stringWithUTF8String:#returnType] isEqualToString:@"short"]) {\
    return (returnType)[value shortValue];\
} else if ([[NSString stringWithUTF8String:#returnType] isEqualToString:@"u_short"]) {\
    return (returnType)[value unsignedShortValue];\
} else if ([[NSString stringWithUTF8String:#returnType] isEqualToString:@"int"]) {\
    return (returnType)[value intValue];\
} else if ([[NSString stringWithUTF8String:#returnType] isEqualToString:@"u_int"]) {\
    return (returnType)[value unsignedIntValue];\
} else if ([[NSString stringWithUTF8String:#returnType] isEqualToString:@"long"]) {\
    return (returnType)[value longValue];\
} else if ([[NSString stringWithUTF8String:#returnType] isEqualToString:@"u_long"]) {\
    return (returnType)[value unsignedLongValue];\
} else if ([[NSString stringWithUTF8String:#returnType] isEqualToString:@"long_long"]) {\
    return (returnType)[value longLongValue];\
} else if ([[NSString stringWithUTF8String:#returnType] isEqualToString:@"u_long_long"]) {\
    return (returnType)[value unsignedLongLongValue];\
} else if ([[NSString stringWithUTF8String:#returnType] isEqualToString:@"float"]) {\
    return [value floatValue];\
} else if ([[NSString stringWithUTF8String:#returnType] isEqualToString:@"double"]) {\
    return (returnType)[value doubleValue];\
} else {\
    return defautValue;\
}\
} else {\
return defautValue;\
}\
}

ProtocolIMP(BOOL, NO)
ProtocolIMPWithoutArg(BOOL, NO)
ProtocolIMP(char, 0)
ProtocolIMPWithoutArg(char, 0)
ProtocolIMP(u_char, 0)
ProtocolIMPWithoutArg(u_char, 0)
ProtocolIMP(short, 0)
ProtocolIMPWithoutArg(short, 0)
ProtocolIMP(u_short, 0)
ProtocolIMPWithoutArg(u_short, 0)
ProtocolIMP(int, 0)
ProtocolIMPWithoutArg(int, 0)
ProtocolIMP(u_int, 0)
ProtocolIMPWithoutArg(u_int, 0)
ProtocolIMP(long, 0)
ProtocolIMPWithoutArg(long, 0)
ProtocolIMP(u_long, 0)
ProtocolIMPWithoutArg(u_long, 0)
ProtocolIMP(long_long, 0)
ProtocolIMPWithoutArg(long_long, 0)
ProtocolIMP(u_long_long, 0)
ProtocolIMPWithoutArg(u_long_long, 0)
ProtocolIMP(float, 0.0)
ProtocolIMPWithoutArg(float, 0)
ProtocolIMP(double, 0.0)
ProtocolIMPWithoutArg(double, 0)

#define ProtocolStructIMP_2Value(returnType)   \
static returnType impWithReturnType_##returnType(id self, SEL _cmd, id arg) {\
    NSString *selName = NSStringFromSelector(_cmd);\
    NSValue * (^block)(id arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);\
    if (block) {\
        NSValue *value = block(arg,selName);\
        return [value returnType##Value];\
    } else {\
        return returnType##Make(0, 0);\
    }\
}

#define ProtocolStructIMP_4Value(returnType)   \
static returnType impWithReturnType_##returnType(id self, SEL _cmd, id arg) {\
    NSString *selName = NSStringFromSelector(_cmd);\
    NSValue * (^block)(id arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);\
    if (block) {\
        NSValue *value = block(arg,selName);\
        return [value returnType##Value];\
    } else {\
        return returnType##Make(0, 0, 0, 0);\
    }\
}

#define ProtocolStructIMP_6Value(returnType)   \
static returnType impWithReturnType_##returnType(id self, SEL _cmd, id arg) {\
    NSString *selName = NSStringFromSelector(_cmd);\
    NSValue * (^block)(id arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);\
    if (block) {\
        NSValue *value = block(arg,selName);\
        return [value returnType##Value];\
    } else {\
        return returnType##Make(0, 0, 0, 0, 0, 0);\
    }\
}

#define ProtocolStructIMPWithoutArg_2Value(returnType)   \
static returnType imp_noarg_withReturnType_##returnType(id self, SEL _cmd) {\
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
static returnType imp_noarg_withReturnType_##returnType(id self, SEL _cmd) {\
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
static returnType imp_noarg_withReturnType_##returnType(id self, SEL _cmd) {\
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

static NSDirectionalEdgeInsets impWithReturnType_NSDirectionalEdgeInsets(id self, SEL _cmd, id arg)API_AVAILABLE(ios(11.0),tvos(11.0),watchos(4.0))
{
    NSString *selName = NSStringFromSelector(_cmd);
    NSValue * (^block)(id arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);
    if (block) {
        NSValue *value = block(arg,selName);
        return [value directionalEdgeInsetsValue];
    } else {
        return NSDirectionalEdgeInsetsMake(0, 0, 0, 0);
    }
}

static NSDirectionalEdgeInsets imp_noarg_withReturnType_NSDirectionalEdgeInsets(id self, SEL _cmd)API_AVAILABLE(ios(11.0),tvos(11.0),watchos(4.0))
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


#define AddMethod(selName, sel, types, returnType)\
if ([selName containsString:@":"]) {\
    class_addMethod([self class], sel, (IMP)GetProtocolIMP(returnType), types.UTF8String);\
} else {\
    class_addMethod([self class], sel, (IMP)GetProtocolIMPWithoutArg(returnType), types.UTF8String);\
}

static id impWithReturnType_id(id self, SEL _cmd, id arg) {
    NSString *selName = NSStringFromSelector(_cmd);
    id (^block)(id arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);
    if (block) {
        return  block(arg,selName);
    } else {
        return nil;
    }
}

static id imp_noarg_withReturnType_id(id self, SEL _cmd) {
    NSString *selName = NSStringFromSelector(_cmd);
    id (^block)(id arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);
    if (block) {
        return  block(nil,selName);
    } else {
        return nil;
    }
}

static Class impWithReturnType_Class(id self, SEL _cmd, id arg) {
    NSString *selName = NSStringFromSelector(_cmd);
    id (^block)(id arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);
    if (block) {
        return block(arg,selName);
    } else {
        return NULL;
    }
}

static Class imp_noarg_withReturnType_Class(id self, SEL _cmd) {
    NSString *selName = NSStringFromSelector(_cmd);
    id (^block)(id arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);
    if (block) {
        return block(nil,selName);
    } else {
        return NULL;
    }
}

static void impWithReturnType_void(id self, SEL _cmd, id arg, ...) {
    
    NSString *selName = NSStringFromSelector(_cmd);
    
    NSMethodSignature *signature = [self methodSignatureForSelector:_cmd];
    NSUInteger numberOfArguments = signature.numberOfArguments;
    
    va_list list;
    va_start(list, arg);
    NSMutableArray *params = [NSMutableArray array];
  
    for (int i = 2; i < numberOfArguments; i ++) {
        char returnType[255];
        strcpy(returnType, [signature getArgumentTypeAtIndex:i]);
        NSLog(@"%s",returnType);
        switch (returnType[0]) {
               // Objective-C object
           case _C_ID: {
               id value;
               i == 2 ? (value = arg) : (value = va_arg(list, id)) ;
               value ? [params addObject:value] : [params addObject:[NSValue valueWithPointer:nil]];
               break;
           }
           case _C_CLASS: {
               Class value;
               i == 2 ? (value = arg) : (value = va_arg(list, Class)) ;
               value ? [params addObject:value] : [params addObject:[NSValue valueWithPointer:nil]];
               break;
           }
           case _C_SEL: {
//               SEL value;
//               i == 2 ? (value = arg) : (value = va_arg(list, SEL)) ;
//               value ? [params addObject:value] : [params addObject:[NSValue valueWithPointer:nil]];
               break;
           }
           case _C_CHR: {
               char value = va_arg(list, int);
               break;
           }
           case _C_UCHR: {
               u_char value = va_arg(list, int);
               break;
           }
           case _C_SHT: {
               short value = va_arg(list, int);
               break;
           }
           case _C_USHT: {
               u_short value = va_arg(list, u_int);
               break;
           }
           case _C_INT: {
               int value = va_arg(list, int);
               break;
           }
           case _C_UINT: {
               u_int value = va_arg(list, u_int);
               break;
           }
           case _C_LNG: {
               long value = va_arg(list, long);
               break;
           }
           case _C_ULNG: {
               u_long value = va_arg(list, u_long);
               break;
           }
           case _C_LNG_LNG: {
               long_long value = va_arg(list, long_long);
               break;
           }
           case _C_ULNG_LNG: {
               u_long_long value = va_arg(list, u_long_long);
               break;
           }
           case _C_FLT: {
               float value = va_arg(list, double);
               break;
           }
           case _C_DBL: {
               double value = va_arg(list, double);
               break;
           }
           case _C_BOOL: {
               BOOL value = va_arg(list, int);
               break;
           }
           // C Pointer
           case _C_PTR: {
               void *value = va_arg(list, void *);
               break;
           }
           case _C_CHARPTR: {
               char *value = va_arg(list, char *);
               break;
           }
           // Struct
           case _C_STRUCT_B: {
//                   if ([types containsString:@"CGSize"]) {
//                       AddMethod(selName, sel, types, CGSize)
//                   } else if ([types containsString:@"CGPoint"]) {
//                       AddMethod(selName, sel, types, CGPoint)
//                   } else if ([types containsString:@"CGVector"]) {
//                       AddMethod(selName, sel, types, CGVector)
//                   } else if ([types containsString:@"CGRect"]) {
//                       AddMethod(selName, sel, types, CGRect)
//                   } else if ([types containsString:@"CGAffineTransform"]) {
//                       AddMethod(selName, sel, types, CGAffineTransform)
//                   } else if ([types containsString:@"UIEdgeInsets"]) {
//                       AddMethod(selName, sel, types, UIEdgeInsets)
//                   } else if ([types containsString:@"UIOffset"]) {
//                       AddMethod(selName, sel, types, UIOffset)
//                   } else if ([types containsString:@"NSDirectionalEdgeInsets"]) {
//                       if (@available(iOS 11.0, *)) {
//                           AddMethod(selName, sel, types, NSDirectionalEdgeInsets)
//                       }
//                   }
//                   break;
           }
           default: {
               break;
           }
        }
        
//        [params addObject:value];
    }
    va_end(list);
    
    void (^block)(id arg,NSString *selName) = objc_getAssociatedObject(self, _cmd);
    if (block) block(arg,selName);
}

static void imp_noarg_withReturnType_void(id self, SEL _cmd) {
    NSString *selName = NSStringFromSelector(_cmd);
    void (^block)(id arg,NSString *selName) = objc_getAssociatedObject(self, _cmd);
    if (block) block(nil,selName);
}

static SEL impWithReturnType_SEL(id self, SEL _cmd, id arg) {
    NSString *selName = NSStringFromSelector(_cmd);
    id (^block)(id arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);
    if (block) {
        NSString *value =  block(arg,selName);
        return NSSelectorFromString(value);
    } else {
        return NULL;
    }
}

static SEL imp_noarg_withReturnType_SEL(id self, SEL _cmd) {
    NSString *selName = NSStringFromSelector(_cmd);
    id (^block)(id arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);
    if (block) {
        NSString *value =  block(nil,selName);
        return NSSelectorFromString(value);
    } else {
        return NULL;
    }
}

static point impWithReturnType_point(id self, SEL _cmd, id arg) {
    NSString *selName = NSStringFromSelector(_cmd);
    NSValue * (^block)(id arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);
    if (block) {
        NSValue *value = block(arg,selName);
        return [value pointerValue];
    } else {
        return NULL;
    }
}

static point imp_noarg_withReturnType_point(id self, SEL _cmd) {
    NSString *selName = NSStringFromSelector(_cmd);
    NSValue * (^block)(id arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);
    if (block) {
        NSValue *value = block(nil,selName);
        return [value pointerValue];
    } else {
        return NULL;
    }
}

static c_point impWithReturnType_c_point(id self, SEL _cmd, id arg) {
    NSString *selName = NSStringFromSelector(_cmd);
    NSValue * (^block)(id arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);
    if (block) {
        NSValue *value = block(arg,selName);
        return [value pointerValue];
    } else {
        return NULL;
    }
}

static c_point imp_noarg_withReturnType_c_point(id self, SEL _cmd) {
    NSString *selName = NSStringFromSelector(_cmd);
    NSValue * (^block)(id arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);
    if (block) {
        NSValue *value = block(nil,selName);
        return [value pointerValue];
    } else {
        return NULL;
    }
}


@interface STCBaseViewModel ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableArray<ReactBlock> *> *binderReactBlockDict;
@property (nonatomic, strong) NSMutableArray<NSString *> *observerKeyPaths;
@property (nonatomic, strong) NSMutableArray<NSString *> *selNames;
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

- (SEL)reactBlock:(void (^)(id arg))block {
    NSString *selName = [NSString stringWithFormat:@"selector_%p:", block];
    [self.selNames addObject:selName];
    SEL sel = NSSelectorFromString(selName);
    class_addMethod([self class], sel, (IMP)selectorImp, "v@:@");
    objc_setAssociatedObject(self, sel, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    return sel;
}

static void selectorImp(id self, SEL _cmd, id arg) {
    void (^block)(id arg) = objc_getAssociatedObject(self, _cmd);
    if (block) block(arg);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.binderReactBlockDict = [NSMutableDictionary dictionary];
        self.observerKeyPaths = [NSMutableArray array];
        self.selNames = [NSMutableArray array];
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
            [self.observerKeyPaths addObject:propertyName];
            [self addObserver:self forKeyPath:propertyName options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
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
            if ([types containsString:@"CGSize"]) {
                AddMethod(selName, sel, types, CGSize)
            } else if ([types containsString:@"CGPoint"]) {
                AddMethod(selName, sel, types, CGPoint)
            } else if ([types containsString:@"CGVector"]) {
                AddMethod(selName, sel, types, CGVector)
            } else if ([types containsString:@"CGRect"]) {
                AddMethod(selName, sel, types, CGRect)
            } else if ([types containsString:@"CGAffineTransform"]) {
                AddMethod(selName, sel, types, CGAffineTransform)
            } else if ([types containsString:@"UIEdgeInsets"]) {
                AddMethod(selName, sel, types, UIEdgeInsets)
            } else if ([types containsString:@"UIOffset"]) {
                AddMethod(selName, sel, types, UIOffset)
            } else if ([types containsString:@"NSDirectionalEdgeInsets"]) {
                if (@available(iOS 11.0, *)) {
                    AddMethod(selName, sel, types, NSDirectionalEdgeInsets)
                }
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

- (STCBaseViewModel *)bindProtocol:(NSString *)protocol voidBlock:(VoidBlock)block
{
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
                    block(value, self);
                }
            }
        }
    }
}

@end
