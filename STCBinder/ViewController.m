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

void testMethod(void)
{
    NSLog(@"testMethod");
}

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.textView =  [[UITextView alloc] initWithFrame:CGRectMake(100, 100, 100, 80)];
    self.textView.backgroundColor = [UIColor greenColor];

    self.textView.delegate =  (id <UITextViewDelegate>) [self.viewModel bindProtocol:STCGetProtocolName(UITextViewDelegate) withReactBlock:^id(id arg,NSString *selName) {
        NSLog(@"%@", arg);
        NSLog(@"%@", selName);
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
    self.aVC.delegate = (id <viewControllerProtocol>)[self.viewModel bindProtocol:STCGetProtocolName(viewControllerProtocol) withReactBlock:^id(NSArray *arg, NSString *selName) {

        if ([selName isEqualToString:STCGetSeletorName(voidMethod)]) {
            return nil;
        }
        
        if ([selName isEqualToString:STCGetSeletorName(voidMethodWithParam1:andParam2:andParam3:)]) {
            return nil;
        }
        
        if ([selName isEqualToString:STCGetSeletorName(idMethod)]) {
            return self;
        }
        
        if ([selName isEqualToString:STCGetSeletorName(nsstringMethod)]) {
            return @"NSString";
        }

        if ([selName isEqualToString:STCGetSeletorName(boolMethod)]) {
            return @YES;
        }

        if ([selName isEqualToString:STCGetSeletorName(classMethod)]) {
            return [self class];
        }

        if ([selName isEqualToString:STCGetSeletorName(selMethod)]) {
            return NSStringFromSelector(@selector(viewDidLoad));
        }
        
        if ([selName isEqualToString:STCGetSeletorName(charMethod)]) {
            char value = 0x90;
            return @(value);
        }
        
        if ([selName isEqualToString:STCGetSeletorName(unsignedCharMethod)]) {
            unsigned char value = 0x99;
            return @(value);
        }
        
        if ([selName isEqualToString:STCGetSeletorName(shortMethod)]) {
            short value = - 77;
            return @(value);
        }
        
        if ([selName isEqualToString:STCGetSeletorName(unsignedShortMethod)]) {
            unsigned short value = 88;
            return @(value);
        }
        
        if ([selName isEqualToString:STCGetSeletorName(intMethod)]) {
            int value = - 999;
            return @(value);
        }
        
        if ([selName isEqualToString:STCGetSeletorName(unsignedIntMethod)]) {
            unsigned int value = 666;
            return @(value);
        }
        
        if ([selName isEqualToString:STCGetSeletorName(longMethod)]) {
            long value = -88888;
            return @(value);
        }
        
        if ([selName isEqualToString:STCGetSeletorName(unsignedLongMethod)]) {
           unsigned long value = 777777;
           return @(value);
        }
        
        if ([selName isEqualToString:STCGetSeletorName(longlongMethod)]) {
            long long value = -10000000;
            return @(value);
        }
        
        if ([selName isEqualToString:STCGetSeletorName(unsignedlonglongMethod)]) {
            unsigned long long value = 99999999;
            return @(value);
        }
        
        if ([selName isEqualToString:STCGetSeletorName(floatMethod)]) {
            float value = - 99.9;
            return @(value);
        }
        
        if ([selName isEqualToString:STCGetSeletorName(doubleMethod)]) {
            double value =  - 999999.99999;
            return @(value);
        }
        
        if ([selName isEqualToString:STCGetSeletorName(charPointMethod)]) {
            char *a;
            a = "hello";
            return @(a);
        }
        
        if ([selName isEqualToString:STCGetSeletorName(pointMethod)]) {
            void *b;
            b = testMethod;
            NSLog(@"%i",*((int*)b));
            return (__bridge id)b;
        }
        
        if ([selName isEqualToString:STCGetSeletorName(CGSizetMethod)]) {
            return @(CGSizeMake(100.0, 100.0));
        }
        
        return nil;
    }];
    [self.aVC test];
}

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
