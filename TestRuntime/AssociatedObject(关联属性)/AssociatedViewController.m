//
//  AssociatedViewController.m
//  TestRuntime
//
//  Created by MarisLin on 2018/3/8.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import "AssociatedViewController.h"
#import "UIButton+Extension.h"

@interface AssociatedViewController ()

@end

@implementation AssociatedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(100, 100, 100, 44);
        [btn setTitle:@"点我啊" forState:0];
        btn.extension = @"我被点了";
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    })];
}

-(void)btnClick:(UIButton *)sender
{
    LCLog(@"%@==>%@",self.title,sender.extension);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
