//
//  STCBaseViewModel.m
//  STCBinder
//
//  Created by chenxiancai on 24/09/2017.
//  Copyright © 2017 stevchen. All rights reserved.
//

#import "STCBaseViewModel.h"
#import <objc/runtime.h>

@interface STCBaseViewModel ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableArray<ReactBlock> *> *binderReactBlockDict;
@property (nonatomic, strong) NSMutableArray<NSString *> *observerKeyPaths;
@property (nonatomic, strong) NSMutableArray<NSString *> *selNames;

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

- (STCBaseViewModel *)bindProtocol:(nonnull NSString *)protocol
                    withReactBlock:(nonnull id (^)(id arg,NSString *selName))block;
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

typedef unsigned char u_char;
typedef unsigned short u_short;
typedef unsigned int u_int;
typedef unsigned long u_long;
typedef long long long_long;
typedef unsigned long long u_long_long;
typedef void * point;
typedef char * c_point;


#define GetProtocolIMP(returnType) impWithReturnType_##returnType

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

#define AddMethod(returnType)\
class_addMethod([self class], sel, (IMP)GetProtocolIMP(returnType), typs.UTF8String);\
objc_setAssociatedObject(self, sel, block, OBJC_ASSOCIATION_COPY_NONATOMIC);


ProtocolIMP(BOOL, NO)
ProtocolIMP(char, 0)
ProtocolIMP(u_char, 0)
ProtocolIMP(short, 0)
ProtocolIMP(u_short, 0)
ProtocolIMP(int, 0)
ProtocolIMP(u_int, 0)
ProtocolIMP(long, 0)
ProtocolIMP(u_long, 0)
ProtocolIMP(long_long, 0)
ProtocolIMP(u_long_long, 0)
ProtocolIMP(float, 0.0)
ProtocolIMP(double, 0.0)

static id impWithReturnType_id(id self, SEL _cmd, id arg) {
    NSString *selName = NSStringFromSelector(_cmd);
    id (^block)(id arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);
    if (block) {
        return  block(arg,selName);
    } else {
        return nil;
    }
}

static void impWithReturnType_void(id self, SEL _cmd, id arg) {
    NSLog(@"void : %@", NSStringFromSelector(_cmd));
    NSString *selName = NSStringFromSelector(_cmd);
    void (^block)(id arg,NSString *selName) = objc_getAssociatedObject(self, _cmd);
    if (block) block(arg,selName);
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

static Class impWithReturnType_Class(id self, SEL _cmd, id arg) {
    NSString *selName = NSStringFromSelector(_cmd);
    id (^block)(id arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);
    if (block) {
        NSString *value =  block(arg,selName);
        return NSClassFromString(value);
    } else {
        return NULL;
    }
}

static point impWithReturnType_point(id self, SEL _cmd, id arg) {
    NSString *selName = NSStringFromSelector(_cmd);
    point (^block)(id arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);
    if (block) {
        return  block(arg,selName);
    } else {
        return NULL;
    }
}

static c_point impWithReturnType_c_point(id self, SEL _cmd, id arg) {
    NSString *selName = NSStringFromSelector(_cmd);
    c_point (^block)(id arg, NSString *selName) = objc_getAssociatedObject(self, _cmd);
    if (block) {
        return  block(arg,selName);
    } else {
        return NULL;
    }
}


- (SEL)protocolBlock:(id (^)(id arg,NSString *selName))block withSelectorName:(NSString *)selName types:(NSString *)typs {
    [self.selNames addObject:selName];
    SEL sel = NSSelectorFromString(selName);
    
    const char *returnType = typs.UTF8String;
    switch (returnType[0]) {
            // void
        case _C_VOID: {
            AddMethod(void)
            break;
        }
            // Objective-C object
        case _C_ID: {
            AddMethod(id)
            break;
        }
        case _C_CLASS: {
            AddMethod(Class)
            break;
        }
        case _C_SEL: {
            AddMethod(SEL)
            break;
        }
        case _C_CHR: {
            AddMethod(char)
            break;
        }
        case _C_UCHR: {
            AddMethod(u_char)
            break;
        }
        case _C_SHT: {
            AddMethod(short)
            break;
        }
        case _C_USHT: {
            AddMethod(u_short)
            break;
        }
        case _C_INT: {
            AddMethod(int)
            break;
        }
        case _C_UINT: {
            AddMethod(u_int)
            break;
        }
        case _C_LNG: {
            AddMethod(long)
            break;
        }
        case _C_ULNG: {
            AddMethod(u_long)
            break;
        }
        case _C_LNG_LNG: {
            AddMethod(long_long)
            break;
        }
        case _C_ULNG_LNG: {
            AddMethod(u_long_long)
            break;
        }
        case _C_FLT: {
            AddMethod(float)
            break;
        }
        case _C_DBL: {
            AddMethod(double)
            break;
        }
        case _C_BOOL: {
            AddMethod(BOOL)
            break;
        }
        // C Pointer
        case _C_PTR:
        {
            AddMethod(point)
            break;
        }
        case _C_CHARPTR: {
            AddMethod(c_point)
            break;
        }
//        // Struct
//        case _C_STRUCT_B: {
//            break;
//        }
            
        default: {
            class_addMethod([self class], sel, (IMP)GetProtocolIMP(id), typs.UTF8String);
            objc_setAssociatedObject(self, sel, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
            break;
        }
    }
    
    return sel;
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
