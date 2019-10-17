//
//  ViewModel.h
//  STCBinder
//
//  Created by chenxiancai on 2019/9/10.
//  Copyright © 2019 stevchen. All rights reserved.
//

#import "STCBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ViewModel : STCBaseViewModel

@property (nonatomic, strong) NSString *leftButtonItemName;
@property (nonatomic, strong) NSString *rightButtonItemName;

@end

NS_ASSUME_NONNULL_END
