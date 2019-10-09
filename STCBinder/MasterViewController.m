//
//  MasterViewController.m
//  STCBinder
//
//  Created by chenxiancai on 19/09/2017.
//  Copyright © 2017 stevchen. All rights reserved.
//

#import "MasterViewController.h"
#import "MasterTableViewCell.h"
#import "DetailViewController.h"

#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

@interface MasterViewController ()

@property (nonatomic, strong) UIAlertController *alert;

@end

@implementation MasterViewController

- (void)dealloc
{
    NSLog(@"MasterViewController dealloc");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[MasterTableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    self.tableView.tableHeaderView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"upload"
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:self.tableViewModel
                                                                       action:[self.tableViewModel reactBlock:^(id arg) {
        
        self.tableViewModel.uploading = !self.tableViewModel.uploading;
        if (self.tableViewModel.uploading) {
            [self.navigationItem.rightBarButtonItem setTitle:@"Push"];
            if ([self isKindOfClass:[DetailViewController class]]){
                [self.navigationItem.leftBarButtonItem setTitle:@"Pop"];
            }
        } else {
            [self.navigationItem.rightBarButtonItem setTitle:@"upload"];
            if ([self isKindOfClass:[DetailViewController class]]){
                [self.navigationItem.leftBarButtonItem setTitle:@"fetch"];
            }
        }
        
    }]];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"fetch"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self.tableViewModel
                                                                      action:[self.tableViewModel reactBlock:^(id arg) {
        
        if ([self isKindOfClass:[DetailViewController class]] && self.tableViewModel.uploading) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self.tableViewModel fetchDataSources];
            if (self.alert) {
                [self.alert dismissViewControllerAnimated:NO completion:nil];
            }
            self.alert = [UIAlertController alertControllerWithTitle:nil message:@"asynchronous fetching..." preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:self.alert animated:YES completion:^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.alert dismissViewControllerAnimated:YES completion:nil];
                });
            }];
        }
    }]];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    [self viewModelInitialize];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (![self.navigationController.viewControllers containsObject:self]) {
        [self.tableViewModel disposeAllReactBlocks];
    }
}

-(void)viewModelInitialize
{
    [self.tableViewModel bindProperty:STCGetPropertyName(headerName) withReactBlock:^(id value, id viewModel) {
        UILabel *label = (UILabel *)self.tableView.tableHeaderView;
        label.text = value;
        [self.tableView reloadData];
        NSLog(@"react block 1!");
    }];
    
    [self.tableViewModel bindProperty:STCGetPropertyName(headerName) withReactBlock:^(id value, id viewModel) {
        NSLog(@"react block 2!");
    }];
    
    [self.tableViewModel bindProperty:STCGetPropertyName(uploading) withReactBlock:^(id value, id viewModel) {
        if (self.tableViewModel.uploading) {
            if (self.alert) {
                [self.alert dismissViewControllerAnimated:NO completion:nil];
            }
            self.alert = [UIAlertController alertControllerWithTitle:nil message:@"asynchronous uploading..." preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:self.alert animated:YES completion:^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.alert dismissViewControllerAnimated:YES completion:nil];
                });
            }];
        } else {
            DetailViewController *vc = [[DetailViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }];
    
    [self.tableViewModel bindProperty:STCGetPropertyName(selectedRow) withReactBlock:^(id value, id viewModel) {
        if (self.alert) {
            [self.alert dismissViewControllerAnimated:NO completion:nil];
        }
        self.alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"click button, index: %@", value] preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:self.alert animated:YES completion:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.alert dismissViewControllerAnimated:YES completion:nil];
            });
        }];
    }];
    
    [self.tableViewModel bindProperty:STCGetPropertyName(tableDataSources) withReactBlock:^(id value, id viewModel) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableViewModel.tableDataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MasterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    if (!cell) {
        cell = [[MasterTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reuseIdentifier"];
    }
    cell.model = self.tableViewModel.tableDataSources[indexPath.row];
    [cell.button addTarget:self.tableViewModel action:[self.tableViewModel reactBlock:^(id arg) {
        NSLog(@"%@", arg);
        UIButton * button = (UIButton *)arg;
        self.tableViewModel.selectedRow = button.tag;
    }] forControlEvents:UIControlEventTouchUpInside];
    cell.button.tag = indexPath.row;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        [self.tableViewModel removeWithIndexPath:indexPath];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        if (self.alert) {
            [self.alert dismissViewControllerAnimated:NO completion:nil];
        }
        self.alert = [UIAlertController alertControllerWithTitle:nil message:@"finish delete cell"
                                     preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:self.alert animated:YES completion:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.alert dismissViewControllerAnimated:YES completion:^{
                    [self.tableViewModel updateIndexs];
                }];
            });
        }];

    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

#pragma mark - ViewModel

- (MasterViewModel *)tableViewModel
{
    if (!_tableViewModel) {
        _tableViewModel = [[MasterViewModel alloc] init];
    }
    return _tableViewModel;
}
@end
