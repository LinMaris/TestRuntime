//
//  NSObject+Model.h
//  TestRuntime
//
//  Created by MarisLin on 2018/3/12.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Model)

+(instancetype)modelWithDict:(NSDictionary *)dict;

+(instancetype)modelWithDict:(NSDictionary *)dict updateDict:(NSDictionary *)updateDict;

+(NSArray *)allIvarArray;

@end
