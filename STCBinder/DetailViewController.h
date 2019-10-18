//
//  DetailViewController.h
//  STCBinder
//
//  Created by chenxiancai on 19/09/2017.
//  Copyright © 2017 stevchen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewModel.h"

@interface DetailViewController : UITableViewController

@property (nonatomic, strong) DetailViewModel *viewModel;

@end

