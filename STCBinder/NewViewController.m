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
    NSLog(@"BOOLMethod %@",@([_delegate BOOLMethodWithParam1:NO andParam2:YES]));
    NSLog(@"charMethod %@",@([_delegate charMethodWithParam1:41 andParam2:-22]));
    NSLog(@"u_charMethod %@",@([_delegate u_charMethodWithParam1:21 andParam2:22]));
    NSLog(@"shortMethod %@",@([_delegate shortMethodWithParam1:66 andParam2:-77]));
    NSLog(@"u_shortMethod %@",@([_delegate u_shortMethodWithParam1:68 andParam2:111]));
    NSLog(@"intMethod %@",@([_delegate intMethodWithParam1:-1 andParam2:89]));
    NSLog(@"u_intMethod %@",@([_delegate u_intMethodWithParam1:1199 andParam2:111]));
    NSLog(@"longMethod %@",@([_delegate longMethodWithParam1:8888 andParam2:-333]));
    NSLog(@"u_longMethod %@",@([_delegate longMethodWithParam1:555 andParam2:222]));
    NSLog(@"longlongMethod %@",@([_delegate long_longMethodWithParam1:-999988 andParam2:555444]));
    NSLog(@"u_longlongMethod %@",@([_delegate u_long_longMethodWithParam1:777 andParam2:3333]));
    NSLog(@"floatMethod %@",@([_delegate floatMethodWithParam1:11.11 andParam2:-888.993]));
    NSLog(@"doubleMethod %@",@([_delegate doubleMethodWithParam1:999.88988 andParam2:-88844.9983]));


//    [_delegate voidMethod];
//    [_delegate voidMethodWithParam1:NO andParam2:@"Param2" andParam3:YES];
//    NSLog(@"idMethod %@",[_delegate idMethod]);
//    NSLog(@"nsstringMethod %@",[_delegate nsstringMethod]);
//    NSLog(@"boolMethod %d",[_delegate boolMethod]);
//    NSLog(@"classMethod %@",NSStringFromClass([_delegate classMethod]));
//    NSLog(@"selMethod %@",NSStringFromSelector([_delegate selMethod]));
//    NSLog(@"charMethod %c",[_delegate charMethod]);
//    NSLog(@"unsignedCharMethod %c",[_delegate unsignedCharMethod]);
//    NSLog(@"shortMethod %d",[_delegate shortMethod]);
//    NSLog(@"unsignedShortMethod %d",[_delegate unsignedShortMethod]);
//    NSLog(@"intMethod %d",[_delegate intMethod]);
//    NSLog(@"unsignedIntMethod %d",[_delegate unsignedIntMethod]);
//    NSLog(@"longMethod %ld",[_delegate longMethod]);
//    NSLog(@"unsignedLongMethod %ld",[_delegate unsignedLongMethod]);
//    NSLog(@"longlongMethod %lld",[_delegate longlongMethod]);
//    NSLog(@"unsignedlonglongMethod %lld",[_delegate unsignedlonglongMethod]);
//
//    NSLog(@"floatMethod %@",@([_delegate floatMethod]).stringValue);
//    NSLog(@"doubleMethod %@",@([_delegate doubleMethod]).stringValue);
//    NSLog(@"charPointMethod %s", [_delegate charPointMethod]);
//
//    void *b;
//    b = [_delegate pointMethod];
//    NSLog(@"pointMethod %i",*((int*)b));
//
//    NSLog(@"CGSizetMethod %@", NSStringFromCGSize([_delegate CGSizetMethod]));
//    NSLog(@"CGPointMethod %@", NSStringFromCGPoint([_delegate CGPointMethod]));
//    NSLog(@"CGRectMethod %@", NSStringFromCGRect([_delegate CGRectMethod]));
//    NSLog(@"CGVectorMethod %@", NSStringFromCGVector([_delegate CGVectorMethod]));
//    NSLog(@"CGVectorMethod %@", NSStringFromUIOffset([_delegate UIOffsetMethod]));

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
