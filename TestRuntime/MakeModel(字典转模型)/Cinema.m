//
//  MovieList.m
//  TestRuntime
//
//  Created by MarisLin on 2018/3/13.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import "Cinema.h"
#import "NSObject+Item.h"

@implementation Cinema

//-(NSDictionary *)arrayContainModelClass
//{
//    return @{@"movieList" : @"Movie"};
//}

+(NSDictionary *)lc_objectClassInArray
{
    return @{@"movieList" : @"Movie"};
}

@end
