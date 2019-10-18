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
    [self.tableView registerClass:[MasterTableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    self.tableView.tableHeaderView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    
    UIBarButtonItem *rightButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"upload"
                                     style:UIBarButtonItemStylePlain
                                    target:self.viewModel
                                    action:[self.viewModel bindProperty:STCGetPropertyName(actionName)
                                                        withActionBlock:^(id _Nonnull value, id arg, __kindof STCBaseViewModel * _Nonnull viewModel) {
        [self.navigationItem.rightBarButtonItem setTitle:value];
    }]];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    UIBarButtonItem *leftButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"fetch"
                                     style:UIBarButtonItemStylePlain
                                    target:self.viewModel
                                    action:[self.viewModel bindProperty:STCGetPropertyName(alertMessage)
                                                        withActionBlock:^(id  _Nonnull value,id arg , __kindof STCBaseViewModel * _Nonnull viewModel) {
        if (self.alert) {
            [self.alert dismissViewControllerAnimated:NO completion:nil];
        }
        self.alert = [UIAlertController alertControllerWithTitle:nil
                                                         message:value
                                                  preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:self.alert animated:YES
                         completion:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.alert dismissViewControllerAnimated:YES completion:nil];
            });
        }];
    }]];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    [self viewModelInitialize];
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
    [self.viewModel bindProperty:STCGetPropertyName(headerName)
                  withReactBlock:^(id value, id arg, id viewModel) {
        
        UILabel *label = (UILabel *)self.tableView.tableHeaderView;
        label.text = value;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        NSLog(@"headerName react block 1!");
    }];
    
    [self.viewModel bindProperty:STCGetPropertyName(headerName)
                  withReactBlock:^(id value, id arg, id viewModel) {
        NSLog(@"headerName react block 2!");
    }];
    
    [self.viewModel bindProperty:STCGetPropertyName(uploading)
                  withReactBlock:^(id value, id arg,id viewModel) {
        
        if (self.viewModel.uploading) {
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
    
    [self.viewModel bindProperty:STCGetPropertyName(selectedRow)
                  withReactBlock:^(id value, id target, id viewModel) {
        if (self.alert) {
            [self.alert dismissViewControllerAnimated:NO completion:nil];
        }
        self.alert = [UIAlertController alertControllerWithTitle:nil
                                                         message:[NSString stringWithFormat:@"click button, index: %@", value] preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:self.alert animated:YES completion:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.alert dismissViewControllerAnimated:YES completion:nil];
            });
        }];
    }];
    
    [self.viewModel bindProperty:STCGetPropertyName(tableDataSources)
                  withReactBlock:^(id value, id target,id viewModel) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
    
    self.tableView.dataSource = (id <UITableViewDataSource>)
    [[[[[self.viewModel updateCurrentProtocol:STCGetProtocolName(UITableViewDataSource)]    bindProtocolEvent:STCGetSeletorName(tableView:numberOfRowsInSection:)
           withEventBlock:^id _Nullable(NSArray *  _Nonnull arg, NSString * _Nonnull selName) {
        
        return @(self.viewModel.tableDataSources.count);
        
    }] bindProtocolEvent:STCGetSeletorName(tableView:cellForRowAtIndexPath:)
          withEventBlock:^id _Nullable(NSArray * _Nonnull arg, NSString * _Nonnull selName) {
        
        UITableView *tableView = arg[0];
        NSIndexPath *indexPath = arg[1];
        MasterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
        if (!cell) {
            cell = [[MasterTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reuseIdentifier"];
        }
        cell.model = self.viewModel.tableDataSources[indexPath.row];
        [cell.button addTarget:self.viewModel
                        action:[self.viewModel bindProperty:STCNoStateProperty
                                            withActionBlock:^(id  _Nonnull value, id target,__kindof STCBaseViewModel * _Nonnull viewModel) {
            NSLog(@"%@", value);
            UIButton * button = (UIButton *)target;
            self.viewModel.selectedRow = button.tag;
        }] forControlEvents:UIControlEventTouchUpInside];
        cell.button.tag = indexPath.row;
        return cell;
        
    }] bindProtocolEvent:STCGetSeletorName(tableView:commitEditingStyle:forRowAtIndexPath:)
          withEventBlock:^id _Nullable(NSArray * _Nonnull arg, NSString * _Nonnull selName) {
        
        UITableView *tableView = arg[0];
        UITableViewCellEditingStyle editingStyle = [arg[1] integerValue];
        NSIndexPath *indexPath = arg[2];
        
        if (editingStyle == UITableViewCellEditingStyleDelete) {
             // Delete the row from the data source
             [self.viewModel removeDataWithIndexPath:indexPath];
             [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
             
             if (self.alert) {
                 [self.alert dismissViewControllerAnimated:NO completion:nil];
             }
             self.alert = [UIAlertController alertControllerWithTitle:nil message:@"finish delete cell"
                                          preferredStyle:UIAlertControllerStyleAlert];
             [self presentViewController:self.alert animated:YES completion:^{
                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     [self.alert dismissViewControllerAnimated:YES completion:^{
                         [self.viewModel updateIndexs];
                     }];
                 });
             }];
         } else if (editingStyle == UITableViewCellEditingStyleInsert) {
             // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
         }
        return nil;
    }] bindProtocolEvent:STCGetSeletorName(tableView:canEditRowAtIndexPath:)
          withEventBlock:^id _Nullable(NSArray * _Nonnull arg, NSString * _Nonnull selName) {
         return @YES;
    }];
    
    self.tableView.delegate = (id <UITableViewDelegate>)
    [[[self.viewModel updateCurrentProtocol:STCGetProtocolName(UITableViewDelegate)] bindProtocolEvent:STCGetSeletorName(tableView:didSelectRowAtIndexPath:)
           withEventBlock:^id _Nullable(NSArray * _Nonnull arg, NSString * _Nonnull selName) {
        
        NSIndexPath *indexPath = arg[1];
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        return nil;
        
    }] bindProtocolEvent:STCGetSeletorName(tableView:heightForRowAtIndexPath:)
          withEventBlock:^id _Nullable(NSArray * _Nonnull arg, NSString * _Nonnull selName) {
        
        return @80;
        
    }];
}

#pragma mark - ViewModel

- (MasterViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[MasterViewModel alloc] init];
    }
    return _viewModel;
}
@end
