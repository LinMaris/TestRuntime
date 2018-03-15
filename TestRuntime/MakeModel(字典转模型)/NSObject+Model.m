//
//  NSObject+Model.m
//  TestRuntime
//
//  Created by MarisLin on 2018/3/12.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import "NSObject+Model.h"
#import <objc/runtime.h>

@implementation NSObject (Model)

+(instancetype)modelWithDict:(NSDictionary *)dict updateDict:(NSDictionary *)updateDict
{
    id model = [[self alloc] init];
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        // 属性名称
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        ivarName = [ivarName substringFromIndex:1];  // 默认会带"_",如_name, _age
        id value = dict[ivarName];
        // 模型中属性名对应字典中的key
        if (!value) {
            if (updateDict) {   // 为了应对 oc中属性不能为 id 等类似问题
                NSString *keyName = updateDict[ivarName];  // id
                value = dict[keyName];  // dict[id].  获取真实值
            }
        }
        
        [model setValue:value forKey:ivarName];
    }
    return model;
}

+(instancetype)modelWithDict:(NSDictionary *)dict
{
    return [self modelWithDict:dict updateDict:nil];
}

+(NSArray *)allIvarArray
{
    unsigned int count;
    Ivar *ivars = class_copyIvarList([self class], &count);
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        NSString *ivarName = [NSString stringWithUTF8String: ivar_getName(ivars[i])];
        [arr addObject:[ivarName substringFromIndex:1]];
    }
    return arr;
}

@end
