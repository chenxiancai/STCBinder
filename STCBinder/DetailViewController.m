//
//  DetailViewController.m
//  STCBinder
//
//  Created by chenxiancai on 19/09/2017.
//  Copyright © 2017 stevchen. All rights reserved.
//

#import "DetailViewController.h"
#import "ViewController.h"
#import "DetailViewModel.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)dealloc
{
    NSLog(@"DetailViewController dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIBarButtonItem *leftButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"back"
                                     style:UIBarButtonItemStylePlain
                                    target:self.viewModel
                                    action:[self.viewModel bindProperty:STCGetPropertyName(cellButtonTag) withActionBlock:^(id  _Nonnull value, id target, __kindof STCBaseViewModel * _Nonnull viewModel) {
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    UIBarButtonItem *rightButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"go"
                                     style:UIBarButtonItemStylePlain
                                    target:self.viewModel
                                    action:[self.viewModel bindProperty:STCGetPropertyName(cellButtonTag) withActionBlock:^(id  _Nonnull value, id target,__kindof STCBaseViewModel * _Nonnull viewModel) {
        ViewController *vc = [[ViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }]];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ViewModel


@end
