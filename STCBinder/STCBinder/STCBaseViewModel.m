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

- (STCBaseViewModel *)errorBlock:(void (^)(id arg))block
{
    [self reactBlock:block];
    return self;
}

- (STCBaseViewModel *)completedBlock:(void (^)(id arg))block
{
    [self reactBlock:block];
    return self;
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

- (void)bindProperty:(NSString *)propertyName withReactBlock:(ReactBlock)block
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
}


- (void)unbindProperty:(NSString *)propertyName withReactBlock:(ReactBlock)block
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
