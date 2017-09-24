//
//  MasterViewModel.m
//  STCBinder
//
//  Created by chenxiancai on 24/09/2017.
//  Copyright © 2017 stevchen. All rights reserved.
//

#import "MasterViewModel.h"
#import "CellModel.h"

@interface MasterViewModel ()

@property (nonatomic, strong, readwrite) NSArray <CellModel *> *tableDataSources;
@property (nonatomic, strong, readwrite) NSString *headerName;
@property (nonatomic, strong, readwrite) CellModel *currentModel;
@property (nonatomic, assign, readwrite) BOOL uploading;

@property (nonatomic, assign, readwrite) SEL clickAction;
@property (nonatomic, assign, readwrite) SEL uploadAction;

@property (nonatomic, assign, readwrite) SEL updateDataSources;
@property (nonatomic, assign, readwrite) SEL updateTotalCount;
@property (nonatomic, assign, readwrite) SEL updateIndexs;

@end

@implementation MasterViewModel

- (instancetype)initWithDelegate:(id<STCViewModelProtocol>)delegate
{
    self = [super initWithDelegate:delegate];
    if (self) {
        self.clickAction = @selector(clickWithTarget:);
        self.uploadAction = @selector(uploadWithTarget:);
        self.updateDataSources = @selector(updateDataSourcesAction);
        self.updateTotalCount = @selector(updateTotalCountAction);
        self.updateIndexs = @selector(updateIndexsAction);
    }
    return self;
}

- (void)clickWithTarget:(id)target
{
    [self reactActionWithTarget:target];
}

- (void)uploadWithTarget:(id)target
{
    self.uploading = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.uploading = NO;
    });
}

- (void)updateDataSourcesAction
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

- (void)updateTotalCountAction
{
    self.headerName = [NSString stringWithFormat:@"total count :%@", @(self.tableDataSources.count)];
}

- (void)updateIndexsAction
{
    self.tableDataSources = [self updateIndexWithDataSource:[NSArray arrayWithArray:self.tableDataSources]];
}

@end
