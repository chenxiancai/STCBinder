//
//  DetailViewController.m
//  STCBinder
//
//  Created by chenxiancai on 19/09/2017.
//  Copyright © 2017 stevchen. All rights reserved.
//

#import "DetailViewController.h"
#import "ViewController.h"

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
                                    action:[self.viewModel bindProperty:STCNoStateProperty
                                                        withActionBlock:^(id  _Nonnull value, id target, __kindof STCBaseViewModel * _Nonnull viewModel) {
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    UIBarButtonItem *rightButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"go"
                                     style:UIBarButtonItemStylePlain
                                    target:self.viewModel
                                    action:[self.viewModel bindProperty:STCNoStateProperty
                                                        withActionBlock:^(id  _Nonnull value, id target,__kindof STCBaseViewModel * _Nonnull viewModel) {
        ViewController *vc = [[ViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }]];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}


-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (![self.navigationController.viewControllers containsObject:self]) {
        [self.viewModel disposeAllReactBlocks];
    }
}

#pragma mark - viewModelInitialize

-(void)viewModelInitialize
{
    
}

#pragma mark - ViewModel

- (DetailViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[DetailViewModel alloc] init];
    }
    return _viewModel;
}

@end
