//
//  MethodViewController.m
//  TestRuntime
//
//  Created by MarisLin on 2018/3/8.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import "MethodViewController.h"
#import "Student.h"
#import "UIButton+Extension.h"

@interface MethodViewController ()

@end

@implementation MethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 编译有警告是因为找不到方法声明
    Student *student = [[Student alloc] init];
    [student performSelector:@selector(run:) withObject:@100];
    
    [self.view addSubview:({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(100, 100, 100, 44);
        [btn setTitle:@"点我啊" forState:0];
        btn.extension = @"我又被点了";
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    })];
}

// 找不到实例方法会调用此方法
+(BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == NSSelectorFromString(@"btnClick:")) {
        class_addMethod(self, sel, (IMP)btnClick, "v@:*");
    }
    return YES;
}

void btnClick(id self, SEL _cmd, UIButton *btn) {
    LCLog(@"咋的啦:%@",btn.extension);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
