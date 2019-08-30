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

@property (nonatomic, strong) NSArray <CellModel *> *tableDataSources;
@property (nonatomic, strong) NSString *headerName;
@property (nonatomic, assign) BOOL uploading;
@property (nonatomic, assign) id selectedCell;

- (void)fetchDataSources;
- (void)updateIndexs;

@end
