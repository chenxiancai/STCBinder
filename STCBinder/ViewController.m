//
//  ViewController.m
//  STCBinder
//
//  Created by chenxiancai on 2019/9/10.
//  Copyright © 2019 stevchen. All rights reserved.
//

#import "ViewController.h"
#import "ViewModel.h"
#import "NewViewController.h"

@interface ViewController ()

@property (nonatomic, strong) ViewModel *viewModel;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) NewViewController *aVC;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.textView =  [[UITextView alloc] initWithFrame:CGRectMake(100, 100, 100, 80)];
    self.textView.backgroundColor = [UIColor greenColor];

    self.textView.delegate =  (id <UITextViewDelegate>) [self.viewModel bindProtocol:STCGetProtocolName(UITextViewDelegate) withReactBlock:^id(id arg,NSString *selName) {
        NSLog(@"%@", arg);
        NSLog(@"%@", selName);

        [self.aVC test];

        return [NSNumber numberWithBool:YES];
    }];

    [self.view addSubview:self.textView];
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"return"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self.viewModel
                                                                      action:[self.viewModel reactBlock:^(id arg) {
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    self.aVC = [[NewViewController alloc] init];
    self.aVC.delegate = (id <viewControllerProtocol>)[self.viewModel bindProtocol:STCGetProtocolName(viewControllerProtocol) withReactBlock:^id(id arg, NSString *selName) {

        if ([selName isEqualToString:STCGetSeletorName(voidMethod)]) {
            return nil;
        }
        
        if ([selName isEqualToString:STCGetSeletorName(voidMethodWithParam1:andParam2:)]) {
            return nil;
        }
        
        if ([selName isEqualToString:STCGetSeletorName(idMethod)]) {
            return self;
        }
        
//        if ([selName isEqualToString:STCGetSeletorName(nsstringMethod)]) {
//            return @"NSString";
//        }
//
//        if ([selName isEqualToString:STCGetSeletorName(boolMethod)]) {
//            return [NSNumber numberWithBool:YES];
//        }
//
//        if ([selName isEqualToString:STCGetSeletorName(classMethod)]) {
//            return [self class];
//        }
//
//        if ([selName isEqualToString:STCGetSeletorName(selMethod)]) {
//            return NSStringFromSelector(@selector(viewDidLoad));
//        }
//        
//        if ([selName isEqualToString:STCGetSeletorName(charMethod)]) {
//            char value = 0x90;
//            return [NSNumber numberWithChar:value];
//        }
//
        return nil;
    }];
}

//
//- (char)charMethod;
//
//- (unsigned char)unsignedCharMethod;
//
//- (short)shortMethod;
//
//- (unsigned short)unsignedShortMethod;
//
//- (int)intMethod;
//
//- (unsigned int)unsignedIntMethod;
//
//- (long)longMethod;
//
//- (unsigned long)unsignedLongMethod;
//
//- (long long)longlongMethod;
//
//- (unsigned long long)unsignedlonglongMethod;
//
//- (float)floatMethod;
//
//- (double)doubleMethod;
//
//- (char *)charPointMethod;
//
//- (void *)pointMethod;
//
//- (CGSize)structMethod;

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (![self.navigationController.viewControllers containsObject:self]) {
        [self.viewModel disposeAllReactBlocks];
    }
}

- (ViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[ViewModel alloc] init];
    }
    return _viewModel;
}


@end
