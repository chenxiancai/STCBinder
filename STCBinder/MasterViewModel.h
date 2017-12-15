//
//  MasterViewModel.h
//  STCBinder
//
//  Created by chenxiancai on 24/09/2017.
//  Copyright © 2017 stevchen. All rights reserved.
//

#import "STCBaseViewModel.h"
#import "CellModel.h"

@interface MasterViewModel : STCBaseViewModel

@property (nonatomic, strong, readonly) NSArray <CellModel *> *tableDataSources;
@property (nonatomic, strong, readonly) NSString *headerName;
@property (nonatomic, strong, readonly) CellModel *currentModel;
@property (nonatomic, assign, readonly) BOOL uploading;
@property (nonatomic, assign, readonly) id selectedCell;

@property (nonatomic, assign, readonly) SEL clickAction;
@property (nonatomic, assign, readonly) SEL uploadAction;

@property (nonatomic, assign, readonly) SEL updateDataSources;
@property (nonatomic, assign, readonly) SEL updateTotalCount;
@property (nonatomic, assign, readonly) SEL updateIndexs;

@end
