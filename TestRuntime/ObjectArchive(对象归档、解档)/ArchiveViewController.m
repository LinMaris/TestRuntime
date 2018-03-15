//
//  ArchiveViewController.m
//  TestRuntime
//
//  Created by MarisLin on 2018/3/12.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import "ArchiveViewController.h"
#import "Dog.h"

@interface ArchiveViewController ()

@property(nonatomic,strong) UITextField *tf;
@property(nonatomic,strong) UILabel *showLabel;

@property (nonatomic, copy) NSString *path;

@property(nonatomic,strong) Dog *miniDog;

@end

@implementation ArchiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:@"保存" forState:0];
        btn.frame = CGRectMake(100, 200, 100, 44);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100;
        btn;
    })];
    
    [self.view addSubview:({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:@"读取" forState:0];
        btn.frame = CGRectMake(100 + 44 + 20, 200, 100, 44);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 101;
        btn;
    })];
    
    // 输入
    [self.view addSubview:({
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 100, 44)];
        tf.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        tf.placeholder = @"请输入";
        [tf setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        tf.textAlignment = NSTextAlignmentCenter;
        self.tf = tf;
        tf;
    })];
    
    // 输出
    [self.view addSubview:({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(200 + 20, 100, 100, 44)];
        label.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        label.textAlignment = NSTextAlignmentCenter;
        self.showLabel = label;
        label;
    })];
    
    self.path = [NSString stringWithFormat:@"%@/miniDog", NSHomeDirectory()];
    self.miniDog = [[Dog alloc] init];
    self.miniDog.cat = [Cat new];
}

-(void)btnClick:(UIButton *)sender
{
    if (sender.tag == 100) {  // 保存
        
        self.miniDog.name = self.tf.text;
        self.miniDog.cat.name = self.tf.text;
        [NSKeyedArchiver archiveRootObject:self.miniDog toFile:self.path];
    }else{   // 读取
        
        self.miniDog = [NSKeyedUnarchiver unarchiveObjectWithFile:self.path];
        self.showLabel.text = self.miniDog.name;  // 此时 name 无值,因为name被忽略了
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
