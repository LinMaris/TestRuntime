//
//  GitHubModel.m
//  TestRuntime
//
//  Created by MarisLin on 2018/3/12.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import "GitHubModel.h"
#import "NSObject+Item.h"

@implementation GitHubModel

+(NSDictionary *)lc_replacedKeyFromPropertyName
{
    return @{@"userId" : @"id"};
}

@end
