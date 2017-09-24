//
//  MasterTableViewCell.h
//  STCBinder
//
//  Created by chenxiancai on 24/09/2017.
//  Copyright © 2017 stevchen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellModel.h"

@interface MasterTableViewCell : UITableViewCell

@property (nonatomic, strong) CellModel *model;
@property (nonatomic, strong) UIButton *button;

@end
