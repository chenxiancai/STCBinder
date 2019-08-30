//
//  MasterViewController.m
//  STCBinder
//
//  Created by chenxiancai on 19/09/2017.
//  Copyright © 2017 stevchen. All rights reserved.
//

#import "MasterViewController.h"
#import "MasterViewModel.h"
#import "MasterTableViewCell.h"
#import "DetailViewController.h"

#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

@interface MasterViewController ()<STCViewModelProtocol, UIAlertViewDelegate>

@property (nonatomic, strong) MasterViewModel *tableViewModel;
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
    
    __weak typeof(self) weakself = self;
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"upload&new"
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:self.tableViewModel
                                                                       action:[self.tableViewModel selectorBlock:^(id arg) {
        
        NSLog(@"%@", arg);
        __strong typeof(weakself) strongself = weakself;
        strongself.tableViewModel.uploading = !strongself.tableViewModel.uploading;
        
    }]];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Addcell&back"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self.tableViewModel
                                                                      action:[self.tableViewModel selectorBlock:^(id arg) {
        
        __strong typeof(weakself) strongself = weakself;
        if ([strongself isKindOfClass:[DetailViewController class]]) {
            [strongself.navigationController popViewControllerAnimated:YES];
        } else {
            [strongself.tableViewModel fetchDataSources];
        }
    }]];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    [self viewModelInitialize];
}

-(void)viewModelInitialize
{
    
    __weak typeof(self) weakself = self;
    [self.tableViewModel bindProperty:STCGetPropertyName(headerName) withReactBlock:^(id value, id viewModel) {
        __strong typeof(weakself) strongself = weakself;
        UILabel *label = (UILabel *)strongself.tableView.tableHeaderView;
        label.text = value;
        [strongself.tableView reloadData];
    }];
    
    [self.tableViewModel bindProperty:STCGetPropertyName(uploading) withReactBlock:^(id value, id viewModel) {
        __strong typeof(weakself) strongself = weakself;
        if (strongself.tableViewModel.uploading) {
            if (strongself.alert) {
                [strongself.alert dismissViewControllerAnimated:YES completion:nil];
            }
            strongself.alert = [UIAlertController alertControllerWithTitle:nil message:@"asynchronous uploading..." preferredStyle:UIAlertControllerStyleAlert];
            [strongself presentViewController:strongself.alert animated:YES completion:nil];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (strongself.alert) {
                    [strongself.alert dismissViewControllerAnimated:YES completion:nil];
                }
            });
        } else {
            DetailViewController *vc = [[DetailViewController alloc] init];
            [strongself.navigationController pushViewController:vc animated:YES];
        }
        
    }];
    
    [self.tableViewModel bindProperty:STCGetPropertyName(selectedCell) withReactBlock:^(id value, id viewModel) {
        __strong typeof(weakself) strongself = weakself;
        MasterTableViewCell *cell = (MasterTableViewCell *)value;
        CellModel *model = cell.model;
        strongself.alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"click button, name: %@, index: %@, image: %@", model.name, model.indexName, model.imageName] preferredStyle:UIAlertControllerStyleAlert];
        [strongself presentViewController:strongself.alert animated:YES completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (strongself.alert) {
                [strongself.alert dismissViewControllerAnimated:YES completion:nil];
            }
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
    __weak typeof(self) weakself = self;
    
    [cell.button addTarget:self.tableViewModel action:[self.tableViewModel selectorBlock:^(id arg) {
        __strong typeof(weakself) strongself = weakself;
        NSLog(@"%@", arg);
        id view = [(UIButton *)arg superview];
        while (![view isKindOfClass:[UITableViewCell class]] && view != nil) {
            view = [view superview];
        }
        if (view) {
            strongself.tableViewModel.selectedCell = view;
        }

    }] forControlEvents:UIControlEventTouchUpInside];
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
        
        NSMutableArray *dataSources = [NSMutableArray arrayWithArray:self.tableViewModel.tableDataSources];
        [dataSources removeObjectAtIndex:indexPath.row];
        self.tableViewModel.tableDataSources = [NSArray arrayWithArray:dataSources];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        self.tableViewModel.headerName = [NSString stringWithFormat:@"total count :%@", @(self.tableViewModel.tableDataSources.count)];
        
        [UIAlertController alertControllerWithTitle:nil message:@"finish delete cell"
                                     preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:self.alert animated:YES completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.alert) {
                [self.alert dismissViewControllerAnimated:YES completion:^{
                    
                    [self.tableViewModel updateIndexs];
                }];
            }
        });

    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

#pragma mark - ViewModel

- (MasterViewModel *)tableViewModel
{
    if (!_tableViewModel) {
        _tableViewModel = [[MasterViewModel alloc] initWithDelegate:self];
    }
    return _tableViewModel;
}
@end
