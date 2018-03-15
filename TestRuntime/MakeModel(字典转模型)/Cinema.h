//
//  MovieList.h
//  TestRuntime
//
//  Created by MarisLin on 2018/3/13.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cinema : NSObject

// 电影院名称
@property(nonatomic,copy) NSString *name;
// 电影列表
@property(nonatomic,strong) NSArray *movieList;

@end
