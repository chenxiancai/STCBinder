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
    [_delegate voidMethodWithParam1:@"Param1" andParam2:@"Param2"];
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
    NSLog(@"floatMethod %f",[_delegate floatMethod]);
    NSLog(@"doubleMethod %lf",[_delegate doubleMethod]);
    NSLog(@"charPointMethod %s", [_delegate charPointMethod]);
    NSLog(@"pointMethod %s", [_delegate pointMethod]);
    NSLog(@"structMethod %@", NSStringFromCGSize([_delegate structMethod]));
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
