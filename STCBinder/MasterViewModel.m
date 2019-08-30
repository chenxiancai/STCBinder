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

- (instancetype)initWithDelegate:(id<STCViewModelProtocol>)delegate
{
    self = [super initWithDelegate:delegate];
    if (self) {
    }
    return self;
}

- (void)fetchDataSources
{
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
    self.tableDataSources = [self updateIndexWithDataSource:[NSArray arrayWithArray:oldModels]];
    self.headerName = [NSString stringWithFormat:@"total count: %@", @(self.tableDataSources.count)];
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

@end
