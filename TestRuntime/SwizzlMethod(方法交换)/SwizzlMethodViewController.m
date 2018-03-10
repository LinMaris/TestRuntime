//
//  SwizzlMethodViewController.m
//  TestRuntime
//
//  Created by MarisLin on 2018/3/8.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import "SwizzlMethodViewController.h"
#import "UIImage+Extension.h"
#import "Teachers.h"
//#import "UIButton+Count.h"
#import "AppDelegate.h"

@interface SwizzlMethodViewController ()

@end

@implementation SwizzlMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self testImg];
    
//    [self testMethod1];
    [self testMethod2];
    
    [self testButton];
}

-(void)testImg
{
    UIImage *img = [UIImage imageNamed:@"about_company"];
    
    [self.view addSubview:({
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        imgView.image = img;
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView;
    })];
}

-(void)testMethod1
{
    Teachers *tec = [Teachers new];
    
    Method method1 = class_getInstanceMethod([tec class], @selector(teachMath));
    Method method2 = class_getInstanceMethod([tec class], @selector(teachChinese));
    method_exchangeImplementations(method1, method2);
    
    [tec teachMath];
    [tec teachChinese];
}

-(void)testMethod2
{
    Teachers *tec = [Teachers new];
    Boys *boys = [Boys new];
    
    Method method1 = class_getInstanceMethod([Teachers class], @selector(teachMath));
    Method method2 = class_getInstanceMethod([Boys class], @selector(learnMath));
    method_exchangeImplementations(method1, method2);
    
    [tec teachMath];
    [boys learnMath];
}

-(void)testButton
{
    [self.view addSubview:({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:@"点我啊" forState:0];
        [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(100, 200, 100, 40);
        btn;
    })];
}

-(void)btnClick
{
    AppDelegate *appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    LCLog(@"我被点击了%ld次",appDel.count);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
