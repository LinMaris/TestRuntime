//
//  Movie.h
//  TestRuntime
//
//  Created by MarisLin on 2018/3/13.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GitHubModel;
@interface Movie : NSObject

@property(nonatomic,copy) NSString *movieId;

@property(nonatomic,copy) NSString *movieName;

@property(nonatomic,copy) NSString *pic_url;

@property(nonatomic,strong) GitHubModel *gitHub;

@end
