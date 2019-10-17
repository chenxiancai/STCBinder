//
//  MasterViewModel.m
//  STCBinder
//
//  Created by chenxiancai on 24/09/2017.
//  Copyright © 2017 stevchen. All rights reserved.
//

#import "MasterViewModel.h"
#import "CellModel.h"
#import <UIKit/UIKit.h>

@interface MasterViewModel ()

@end

@implementation MasterViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tableDataSources = [NSArray array];
        self.headerName = nil;
        self.uploading = NO;
        self.selectedRow = 0;
        self.cellButtonTag = 1000;
    }
    return self;
}

/**
 模拟网络异步请求
 */
- (void)fetchDataSources
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:2];
        NSArray *imagePaths = @[@"icon_worrng",
                                @"icon_sucess",
                                @"icon_myshare",
                                @"icon_sucess",
                                @"icon_myshare"];
        
        for (NSInteger i = self.tableDataSources.count ; i < 2 + self.tableDataSources.count ; i ++) {
            CellModel *model = [[CellModel alloc] init];
            model.name = @(i).stringValue;
            model.imageName = imagePaths[i%5];
            [array addObject:model];
        }
        
        NSMutableArray *oldModels = [NSMutableArray arrayWithArray:self.tableDataSources];
        [oldModels addObjectsFromArray:array];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.tableDataSources = [self updateIndexWithDataSource:[NSArray arrayWithArray:oldModels]];
            self.headerName = [NSString stringWithFormat:@"total count: %@", @(self.tableDataSources.count)];
        });
    });
}

- (NSArray *)updateIndexWithDataSource:(NSArray *)dataSource
{
    for (NSInteger i = 0 ; i < dataSource.count ; i ++) {
        CellModel *model = dataSource[i];
        model.indexName = @(i).stringValue;
    }
    return [NSArray arrayWithArray:dataSource];
}

- (void)updateIndexs
{
    self.tableDataSources = [self updateIndexWithDataSource:[NSArray arrayWithArray:self.tableDataSources]];
}

- (void)removeWithIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *dataSources = [NSMutableArray arrayWithArray:self.tableDataSources];
    [dataSources removeObjectAtIndex:indexPath.row];
    self.tableDataSources = [NSArray arrayWithArray:dataSources];
    self.headerName = [NSString stringWithFormat:@"total count :%@", @(self.tableDataSources.count)];
}

- (void)actionBindedProperty:(NSString *)property withArg:(id)arg actionBlock:(ReactBlock)block
{
    NSLog(@"arg :%@", arg);
    if (arg) {
        [super actionBindedProperty:property withArg:arg actionBlock:block];
    }
}

@end
