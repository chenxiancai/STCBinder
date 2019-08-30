//
//  STCBaseViewModel.m
//  STCBinder
//
//  Created by chenxiancai on 24/09/2017.
//  Copyright © 2017 stevchen. All rights reserved.
//

#import "STCBaseViewModel.h"
#import "STCProxy.h"
#import <objc/runtime.h>

@interface STCBaseViewModel ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableArray<STCProxy* > *> *binderDict;
@property (nonatomic, strong) NSMutableArray<STCProxy *> *delegates;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableArray<reactBlock> *> *binderReactBlockDict;
@property (nonatomic, strong) NSMutableArray<NSString *> *observerKeyPaths;

@end

@implementation STCBaseViewModel

- (void)dealloc
{
    self.delegates = nil;
    for (NSString *keyPath in self.observerKeyPaths) {
        [self removeObserver:self forKeyPath:keyPath];
    }
    self.observerKeyPaths = nil;
    self.binderDict = nil;
    self.binderReactBlockDict = nil;
    
    NSLog(@"STCBaseViewModel dealloc");
}

- (SEL)selectorBlock:(void (^)(id arg))block {
    NSString *selName = [NSString stringWithFormat:@"selector_%p:", block];
    SEL sel = NSSelectorFromString(selName);
    class_addMethod([self class], sel, (IMP)selectorImp, "v@:@");
    objc_setAssociatedObject(self, sel, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    return sel;
}

static void selectorImp(id self, SEL _cmd, id arg) {
    void (^block)(id arg) = objc_getAssociatedObject(self, _cmd);
    if (block) block(arg);
}

- (instancetype)initWithDelegate:(id<STCViewModelProtocol>)delegate
{
    self = [super init];
    if (self) {
        [self registerDelegate:delegate];
        self.binderDict = [NSMutableDictionary dictionary];
        self.binderReactBlockDict = [NSMutableDictionary dictionary];
        self.observerKeyPaths = [NSMutableArray array];
    }
    return self;
}

#pragma mark - binder methods

- (void)bindProperty:(NSString *)propertyName withTarget:(id)target
{
    if (target && propertyName) {
        STCProxy *weakObject = [STCProxy proxyWithTarget:target];
        if ([self.binderDict objectForKey:propertyName]) {
            NSMutableArray *weakObjects = [self.binderDict objectForKey:propertyName];
            [weakObjects addObject:weakObject];
        } else {
            NSMutableArray *weakObjects = [NSMutableArray arrayWithObject:weakObject];
            [self.binderDict addEntriesFromDictionary:@{propertyName: weakObjects}];
            if (![self.binderReactBlockDict objectForKey:propertyName]) {
                [self.observerKeyPaths addObject:propertyName];
                [self addObserver:self forKeyPath:propertyName options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
            }
        }
    }
}

- (void)bindProperty:(NSString *)propertyName withReactBlock:(reactBlock)block
{
    if (propertyName && block) {
        if ([self.binderReactBlockDict objectForKey:propertyName]) {
            NSMutableArray *weakObjects = [self.binderReactBlockDict objectForKey:propertyName];
            [weakObjects addObject:[block copy]];
        } else {
            NSMutableArray *weakObjects = [NSMutableArray arrayWithObject:[block copy]];
            [self.binderReactBlockDict addEntriesFromDictionary:@{propertyName: weakObjects}];
            if (![self.binderDict objectForKey:propertyName]) {
                [self.observerKeyPaths addObject:propertyName];
                [self addObserver:self forKeyPath:propertyName options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
            }
        }
    }
}

- (void)unbindProperty:(NSString *)propertyName withTarget:(id)target
{
    if (target && propertyName) {
        if ([self.binderDict objectForKey:propertyName]) {
            NSMutableArray *weakObjects = [self.binderDict objectForKey:propertyName];
            for (STCProxy *weakObject in weakObjects) {
                if (weakObject.target == target) {
                    [weakObjects removeObject:weakObject];
                    break;
                }
            }
            if (weakObjects.count == 0) {
                [self.binderDict removeObjectForKey:propertyName];
                if (![self.binderReactBlockDict objectForKey:propertyName]) {
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
}

- (void)unbindProperty:(NSString *)propertyName withReactBlock:(reactBlock)block
{
    if (propertyName && block) {
        if ([self.binderReactBlockDict objectForKey:propertyName]) {
            NSMutableArray *weakObjects = [self.binderReactBlockDict objectForKey:propertyName];
            for (reactBlock weakObject in weakObjects) {
                if (weakObject == block) {
                    [weakObjects removeObject:weakObject];
                    break;
                }
            }
            if (weakObjects.count == 0) {
                [self.binderReactBlockDict removeObjectForKey:propertyName];
                if (![self.binderDict objectForKey:propertyName]) {
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
}

- (void)updateProperty:(id)propertyName withValue:(id)value
{
    if (![self respondsToSelector:NSSelectorFromString(propertyName)]) {
        return;
    }
    if ([self.binderDict objectForKey:propertyName] || [self.binderReactBlockDict objectForKey:propertyName]) {
        [self removeObserver:self forKeyPath:propertyName];
        [self setValue:value forKey:propertyName];
        [self addObserver:self forKeyPath:propertyName options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    } else {
        [self setValue:value forKey:propertyName];
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
            NSArray *weakObjects = [[self.binderDict objectForKey:propertyName] copy];
            id value = [self valueForKey:propertyName];
            for (STCProxy *weakObject in weakObjects) {
                [self enumerateDelegatesUsingBlock:^(id<STCViewModelProtocol> delegate) {
                    if ([delegate respondsToSelector:@selector(updateValue:withViewModel:target:)]) {
                        [delegate updateValue:value withViewModel:self target:weakObject.target];
                    }
                }];
            }
            NSArray *weakReactBlocks = [[self.binderReactBlockDict objectForKey:propertyName] copy];
            for (reactBlock block in weakReactBlocks) {
                if (block) {
                    block(value, self);
                }
            }
        }
    }
}

#pragma mark - Delegates

- (void)registerDelegate:(id<STCViewModelProtocol>)delegate
{
    if (delegate) {
        STCProxy *weakProxy = [STCProxy proxyWithTarget:delegate];
        if (!_delegates) {
            _delegates = [NSMutableArray arrayWithObject:weakProxy];
        } else {
            [_delegates addObject:weakProxy];
        }
    }
}

- (void)unregisterDelegate:(id<STCViewModelProtocol>)delegate
{
    if (delegate) {
        NSMutableIndexSet *removedIndexSet = [NSMutableIndexSet indexSet];
        NSUInteger index = 0;
        for (STCProxy *weakProxy in _delegates) {
            id tempDelegate = weakProxy.target;
            if (tempDelegate == delegate) {
                [removedIndexSet addIndex:index];
            }
            index++;
        }
        [_delegates removeObjectsAtIndexes:removedIndexSet];
    }
}

- (void)enumerateDelegatesUsingBlock:(void (^)(id<STCViewModelProtocol> delegate))block
{
    NSArray *delegates = [_delegates copy];
    for (STCProxy *weakProxy in delegates) {
        id<STCViewModelProtocol> delegate = weakProxy.target;
        if (delegate) {
            block(delegate);
        }
    }
}

@end
