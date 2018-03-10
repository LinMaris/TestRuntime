//
//  ForwardMessageViewController.m
//  TestRuntime
//
//  Created by MarisLin on 2018/3/8.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import "ForwardMessageViewController.h"
#import "Person.h"
#import "Teachers.h"

@interface ForwardMessageViewController ()

@end

@implementation ForwardMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Person *person = [Person new];
    // 实例方法
//    [person readBook];
    
    // 类方法
    [Person readBook];
}

-(void)eatFood
{
    LCLog(@"吃东西");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
