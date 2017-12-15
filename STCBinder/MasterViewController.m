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
#import "AppDelegate.h"

#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

@interface MasterViewController ()<STCViewModelProtocol, UIAlertViewDelegate>

@property (nonatomic, strong) MasterViewModel *tableViewModel;
@property (nonatomic, strong) UIAlertView *alert;

@end

@implementation MasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[MasterTableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    self.tableView.tableHeaderView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Upload" style:UIBarButtonItemStylePlain target:self.tableViewModel action:self.tableViewModel.uploadAction];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"AddNewCell" style:UIBarButtonItemStylePlain target:self.tableViewModel action:self.tableViewModel.updateDataSources];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    [self viewModelInitialize];
}

-(void)viewModelInitialize
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self.tableViewModel registerDelegate:delegate];
    [self.tableViewModel bindProperty:STCGetPropertyName(uploading) withTarget:delegate];
    
    [self.tableViewModel bindProperty:STCGetPropertyName(headerName) withTarget:self.tableView.tableHeaderView];
    STCBindPropertyWithSeletor(self.tableViewModel, tableDataSources, @selector(tableDataSourcesReactWithValue:viewModel:));
    
    __weak typeof(self) weakself = self;
    [self.tableViewModel bindProperty:STCGetPropertyName(uploading) withReactBlock:^(id value, id viewModel) {
        __strong typeof(weakself) strongself = weakself;
        if (strongself.tableViewModel.uploading) {
            [strongself.alert dismissWithClickedButtonIndex:0 animated:YES];
            strongself.alert = [[UIAlertView alloc] initWithTitle:nil message:@"asynchronous uploading..." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [strongself.alert show];
        } else {
            [strongself.alert dismissWithClickedButtonIndex:0 animated:YES];
            strongself.alert = [[UIAlertView alloc] initWithTitle:nil message:@"finish uploading" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [strongself.alert show];
        }
    }];
    
    [self.tableViewModel bindProperty:STCGetPropertyName(selectedCell) withReactBlock:^(id value, id viewModel) {
        __strong typeof(weakself) strongself = weakself;
        MasterTableViewCell *cell = (MasterTableViewCell *)value;
        CellModel *model = cell.model;
        [weakself.tableViewModel updateProperty:STCGetPropertyName(currentModel) withValue:model];
        weakself.alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"click button, name: %@, index: %@, image: %@", model.name, model.indexName, model.imageName] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [weakself.alert show];
    }];
}

- (void)tableDataSourcesReactWithValue:(id)value viewModel:(id)viewModel
{
    [self.tableView reloadData];
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
    [cell.button addTarget:self.tableViewModel action:self.tableViewModel.clickAction forControlEvents:UIControlEventTouchUpInside];
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
        
        [self.tableViewModel updateProperty:STCGetPropertyName(tableDataSources) withValue:[NSArray arrayWithArray:dataSources]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self.tableViewModel performSelector:self.tableViewModel.updateTotalCount];
        
        self.alert = [[UIAlertView alloc] initWithTitle:nil message:@"finish delete cell" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [self.alert show];
        
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

- (void)updateValue:(id)value withViewModel:(id)viewModel target:(id)target
{
    if (target == self.tableView.tableHeaderView) {
        UILabel *label = (UILabel *)self.tableView.tableHeaderView;
        label.text = self.tableViewModel.headerName;
    }
}

#pragma mark - Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.tableViewModel performSelector:self.tableViewModel.updateIndexs];
}

@end
