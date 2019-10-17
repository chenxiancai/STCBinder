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
    
    self.textView =  [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    self.textView.backgroundColor = [UIColor greenColor];

//    self.textView.delegate =  (id <UITextViewDelegate>) [self.viewModel bindProtocol:STCGetProtocolName(UITextViewDelegate) withReactBlock:^id(id arg,NSString *selName) {
//        NSLog(@"%@", arg);
//        NSLog(@"%@", selName);
//        return @YES;
//    }];
    
    [self.viewModel updateCurrentProtocol:STCGetProtocolName(UITextViewDelegate)];
    self.textView.delegate = (id <UITextViewDelegate>)
    [[self.viewModel bindProtocolMethod:STCGetSeletorName(textViewShouldBeginEditing:) withReactBlock:^id _Nullable(id  _Nonnull arg, NSString * _Nonnull selName) {
        return @YES;
    }] bindProtocolMethod:STCGetSeletorName(textViewDidChange:) withReactBlock:^id _Nullable(id  _Nonnull arg, NSString * _Nonnull selName) {
        NSLog(@"%@", arg);
        NSLog(@"%@", selName);
        return nil;
    }];
    
    [self.view addSubview:self.textView];
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"return"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self.viewModel
                                                                      action:[self.viewModel bindProperty:STCGetPropertyName(leftButtonItemName) withActionBlock:^(id  _Nonnull value, id  _Nullable target, __kindof STCBaseViewModel * _Nonnull viewModel) {

        [self.navigationController popViewControllerAnimated:YES];
    }]];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    self.aVC = [[NewViewController alloc] init];
    self.aVC.delegate = (id <viewControllerProtocol>)[self.viewModel bindProtocol:STCGetProtocolName(viewControllerProtocol) withReactBlock:^id(NSArray *arg, NSString *selName) {
        
        NSLog(@"%@", arg);
        
        if ([selName isEqualToString:STCGetSeletorName(BOOLMethodWithParam1:andParam2:)])
        {
            return @NO;
        }

        if ([selName isEqualToString:STCGetSeletorName(charMethodWithParam1:andParam2:)])
        {
            return @(-64);
        }

        if ([selName isEqualToString:STCGetSeletorName(u_charMethodWithParam1:andParam2:)])
        {
            return @(64);
        }

        if ([selName isEqualToString:STCGetSeletorName(shortMethodWithParam1:andParam2:)])
        {
            return @(-98);
        }

        if ([selName isEqualToString:STCGetSeletorName(u_shortMethodWithParam1:andParam2:)])
        {
            return @(77);
        }

        if ([selName isEqualToString:STCGetSeletorName(intMethodWithParam1:andParam2:)])
        {
            return @(-34);
        }

        if ([selName isEqualToString:STCGetSeletorName(u_intMethodWithParam1:andParam2:)])
        {
            return @(14);
        }
        
        if ([selName isEqualToString:STCGetSeletorName(longMethodWithParam1:andParam2:)])
        {
            return @(-9999999);
        }
        
        if ([selName isEqualToString:STCGetSeletorName(u_longMethodWithParam1:andParam2:)])
        {
            return @(1999999809);
        }
        
        if ([selName isEqualToString:STCGetSeletorName(long_longMethodWithParam1:andParam2:)])
        {
            return @(-19999099998878781);
        }
        
        if ([selName isEqualToString:STCGetSeletorName(u_long_longMethodWithParam1:andParam2:)])
        {
            return @(933199999998878781);
        }

        if ([selName isEqualToString:STCGetSeletorName(floatMethodWithParam1:andParam2:)])
        {
            return @(-888.555);
        }
        
        if ([selName isEqualToString:STCGetSeletorName(doubleMethodWithParam1:andParam2:)])
        {
            return @(844488.999555);
        }
        
        if ([selName isEqualToString:STCGetSeletorName(ClassMethodWithParam1:andParam2:)])
        {
            return [self class];
        }
        
        if ([selName isEqualToString:STCGetSeletorName(SELMethodWithParam1:andParam2:)])
        {
            return NSStringFromSelector(@selector(viewDidLoad));
        }
        
        if ([selName isEqualToString:STCGetSeletorName(c_pointMethodWithParam1:andParam2:)])
        {
            return [NSValue valueWithPointer:[@"a" UTF8String]];
        }
        
        if ([selName isEqualToString:STCGetSeletorName(pointMethodWithParam1:andParam2:)])
        {
            void *b;
            b = testMethod;
            NSLog(@"%i",*((int*)b));
            return [NSValue valueWithPointer:b];
        }
        
        if ([selName isEqualToString:STCGetSeletorName(CGSizeMethodWithParam1:andParam2:)])
        {
            return @(CGSizeMake(12, 0));
        }
        
        if ([selName isEqualToString:STCGetSeletorName(CGPointMethodWithParam1:andParam2:)])
        {
            return @(CGPointMake(11, 11));
        }
        
        if ([selName isEqualToString:STCGetSeletorName(CGVectorMethodWithParam1:andParam2:)])
        {
            return @(CGVectorMake(99, 99));
        }
        
        if ([selName isEqualToString:STCGetSeletorName(CGRectMethodWithParam1:andParam2:)])
        {
            return @(CGRectMake(9, 11, 33, 77));
        }
        
        if ([selName isEqualToString:STCGetSeletorName(CGAffineTransformMethodWithParam1:andParam2:)])
        {
            return [NSValue valueWithCGAffineTransform:CGAffineTransformMake(9, 0, 8, 9, 9, 9)];
        }
        
        if ([selName isEqualToString:STCGetSeletorName(UIEdgeInsetsMethodWithParam1:andParam2:)])
        {
            return @(UIEdgeInsetsMake(9, 8, 4, 3));
        }
        
        if ([selName isEqualToString:STCGetSeletorName(UIEdgeInsetsMethodWithParam1:andParam2:)])
        {
            return @(UIOffsetZero);
        }
        
        if ([selName isEqualToString:STCGetSeletorName(NSDirectionalEdgeInsetsMethodWithParam1:andParam2:)])
        {
            return @(NSDirectionalEdgeInsetsMake(0, 9, 8, 4));
        }
        
        if ([selName isEqualToString:STCGetSeletorName(NSRangeMethodWithParam1:andParam2:)])
        {
            return  [NSValue valueWithRange:NSMakeRange(9, 4)];
        }
        
        if ([selName isEqualToString:STCGetSeletorName(CATransform3DMethodWithParam1:andParam2:)])
        {
            return [NSValue valueWithCATransform3D:CATransform3DIdentity];
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
