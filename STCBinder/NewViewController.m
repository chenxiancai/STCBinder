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

void pointMethod(){}

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
    NSLog(@"ClassMethod %@",NSStringFromClass([_delegate ClassMethodWithParam1:[self class] andParam2:nil]));
    NSLog(@"SELMethod %@",NSStringFromSelector([_delegate SELMethodWithParam1:@selector(test) andParam2:nil]));
    NSLog(@"c_pointMethod %s",[_delegate c_pointMethodWithParam1:(char *)[@"a" UTF8String] andParam2:NULL]);
    
    void *b;
    b = pointMethod;
    NSLog(@"%i",*((int*)b));
    NSLog(@"pointMethod %s",[_delegate pointMethodWithParam1:b andParam2:nil]);
    NSLog(@"CGSizeMethod %@",@([_delegate CGSizeMethodWithParam1:CGSizeMake(11, 12) andParam2:CGSizeZero]));
    NSLog(@"CGPointMethod %@",@([_delegate CGPointMethodWithParam1:CGPointMake(11.3, 12.5) andParam2:CGPointZero]));
    NSLog(@"CGVectorMethod %@",@([_delegate CGVectorMethodWithParam1:CGVectorMake(9, 9.4) andParam2:CGVectorMake(0, 0)]));
    NSLog(@"CGRectMethod %@",@([_delegate CGRectMethodWithParam1:CGRectMake(0, 0, 11, 88) andParam2:CGRectZero]));
    NSLog(@"CGAffineTransformMethod %@",[NSValue valueWithCGAffineTransform:[_delegate CGAffineTransformMethodWithParam1:CGAffineTransformMake(1, 2, 3, 4, 5, 6) andParam2:CGAffineTransformIdentity]]);
    NSLog(@"UIEdgeInsetsMethod %@",@([_delegate UIEdgeInsetsMethodWithParam1:UIEdgeInsetsMake(0, 0, 22, 44) andParam2:UIEdgeInsetsZero]));
    NSLog(@"UIOffsetMethod %@",@([_delegate UIOffsetMethodWithParam1:UIOffsetMake(99, 44) andParam2:UIOffsetZero]));
    NSLog(@"NSDirectionalEdgeInsetsMethod %@",@([_delegate NSDirectionalEdgeInsetsMethodWithParam1:NSDirectionalEdgeInsetsMake(0, 0, 5, 6) andParam2:NSDirectionalEdgeInsetsZero]));
    NSLog(@"NSRangeMethod %@",[NSValue valueWithRange:[_delegate NSRangeMethodWithParam1:NSMakeRange(0, 33) andParam2:NSMakeRange(99, 33)]]);
    NSLog(@"CATransform3DMethod %@",@([_delegate CATransform3DMethodWithParam1:CATransform3DIdentity andParam2:CATransform3DMakeRotation(0, 0, 0, 0)]));

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
