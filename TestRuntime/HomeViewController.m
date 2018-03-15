//
//  ViewController.m
//  TestRuntime
//
//  Created by MarisLin on 2018/2/26.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import "HomeViewController.h"
#import <objc/runtime.h>
#import "UIButton+Extension.h"


@interface  HomeViewController()<UITableViewDelegate,UITableViewDataSource>
// 声明一个方法
- (void)clickMe;

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSDictionary *dataDictionary;
@property(nonatomic,strong) NSArray *titleArrar;
@end

@implementation HomeViewController
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [[UIColor alloc] initWithWhite:0.8 alpha:1];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
        _tableView.bounces = NO;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
-(NSDictionary *)dataDictionary
{
    if (!_dataDictionary) {
        _dataDictionary = @{@"消息转发机制" : @"MsgSendViewController",
                            @"动态关联属性" : @"AssociatedViewController",
                            @"动态添加方法" : @"MethodViewController",
                            @"消息转发" : @"ForwardMessageViewController",
                            @"方法交换": @"SwizzlMethodViewController",
                            @"字典转模型" : @"MakeModelController",
                            @"对象归档、解档" : @"ArchiveViewController",
                            @"Invokecation使用" : @"InvokecationController",
                            };
    }
    return _dataDictionary;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Home";
    self.titleArrar = @[@"消息转发机制",@"动态关联属性",@"动态添加方法",@"消息转发",
                        @"方法交换",@"字典转模型",@"对象归档、解档",@"Invokecation使用",@"字典转模型"];
    [self tableView];
}

#pragma mark - UITableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataDictionary.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    
    cell.textLabel.text = self.titleArrar[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *key = cell.textLabel.text;
    NSString *title = self.dataDictionary[key];
    
    UIViewController *vc = [[NSClassFromString(title) alloc] init];
    vc.title = key;
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:true];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
