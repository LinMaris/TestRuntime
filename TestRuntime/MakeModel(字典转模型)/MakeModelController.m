//
//  MakeModelController.m
//  TestRuntime
//
//  Created by MarisLin on 2018/3/12.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import "MakeModelController.h"
#import "HttpTool.h"
#import "NSObject+Model.h"
#import "GitHubModel.h"
#import "Movie.h"

#import "NSObject+Item.h"
#import "Cinema.h"

@interface MakeModelController ()

@property(nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation MakeModelController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testData];
    
}

#pragma mark - 简单版
-(void)testGitHub
{
    NSString *url = @"https://api.github.com/users/LinMaris";
    [HttpTool requestUrl:url completion:^(NSDictionary *result) {

        GitHubModel *model = [GitHubModel modelWithDict:result updateDict:@{@"userId" : @"id"}];

        for (NSString *name in [GitHubModel allIvarArray]) {
            LCLog(@"%@==%@",name,[model valueForKey:name]);
        }
    }];
}

#pragma mark - 不带缓存 完整版
-(void)testData
{
    // 主演
    NSDictionary *userDic = @{ @"name":@"zhangsan",
                            @"age": @(12),
                            @"sex": @"man",
                            @"id" : @"1111"
                            };
    
    // 电影组成
    NSDictionary *movieDict = @{ @"movieId":@"28678",
                                 @"movieName": @"539fU8276",
                                 @"pic_url": @"fsdfds",
                                 @"gitHub" : userDic
                                 };
    
    // 电影列表
    NSArray *movieArr = @[movieDict ,movieDict, movieDict];
    
    // 电影院
    NSDictionary *cinemaDic = @{@"name" : @"wanda",
                             @"movieList" : movieArr
                             };
    
    // 测试 只有一个字典
    GitHubModel *model = [GitHubModel modelWithDict:userDic];
    
    // 测试字典嵌套字典
//    Movie *movie = [Movie modelWithDict:movieDict];
//    LCLog(@"movie.gitHub.sex:%@",movie.gitHub.sex);
    
    // 测试 字典嵌套数组, 数组嵌套字典
//    Cinema *cinema = [Cinema modelWithDict:cinemaDic];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
