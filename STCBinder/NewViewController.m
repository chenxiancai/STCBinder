//
//  NewViewController.m
//  STCBinder
//
//  Created by chenxiancai on 2019/10/7.
//  Copyright © 2019 stevchen. All rights reserved.
//

#import "NewViewController.h"

@interface NewViewController ()

@end

@implementation NewViewController

- (instancetype)initWithDelegate:(id <viewControllerProtocol>) delegate
{
    self = [super init];
    if (self) {
        _delegate = delegate;
    }
    return self;
}

- (void)test
{
    [_delegate voidMethod];
    [_delegate voidMethodWithParam1:NO andParam2:@"Param2" andParam3:YES];
    NSLog(@"idMethod %@",[_delegate idMethod]);
    NSLog(@"nsstringMethod %@",[_delegate nsstringMethod]);
    NSLog(@"boolMethod %d",[_delegate boolMethod]);
    NSLog(@"classMethod %@",NSStringFromClass([_delegate classMethod]));
    NSLog(@"selMethod %@",NSStringFromSelector([_delegate selMethod]));
    NSLog(@"charMethod %c",[_delegate charMethod]);
    NSLog(@"unsignedCharMethod %c",[_delegate unsignedCharMethod]);
    NSLog(@"shortMethod %d",[_delegate shortMethod]);
    NSLog(@"unsignedShortMethod %d",[_delegate unsignedShortMethod]);
    NSLog(@"intMethod %d",[_delegate intMethod]);
    NSLog(@"unsignedIntMethod %d",[_delegate unsignedIntMethod]);
    NSLog(@"longMethod %ld",[_delegate longMethod]);
    NSLog(@"unsignedLongMethod %ld",[_delegate unsignedLongMethod]);
    NSLog(@"longlongMethod %lld",[_delegate longlongMethod]);
    NSLog(@"unsignedlonglongMethod %lld",[_delegate unsignedlonglongMethod]);
    
    NSLog(@"floatMethod %@",@([_delegate floatMethod]).stringValue);
    NSLog(@"doubleMethod %@",@([_delegate doubleMethod]).stringValue);
    NSLog(@"charPointMethod %s", [_delegate charPointMethod]);
    
    void *b;
    b = [_delegate pointMethod];
    NSLog(@"pointMethod %i",*((int*)b));

    NSLog(@"CGSizetMethod %@", NSStringFromCGSize([_delegate CGSizetMethod]));
    NSLog(@"CGPointMethod %@", NSStringFromCGPoint([_delegate CGPointMethod]));
    NSLog(@"CGRectMethod %@", NSStringFromCGRect([_delegate CGRectMethod]));
    NSLog(@"CGVectorMethod %@", NSStringFromCGVector([_delegate CGVectorMethod]));
    NSLog(@"CGVectorMethod %@", NSStringFromUIOffset([_delegate UIOffsetMethod]));

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
