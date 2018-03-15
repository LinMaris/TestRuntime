//
//  NSObject+Item.h
//  TestRuntime
//
//  Created by MarisLin on 2018/3/13.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LCKeyValue <NSObject>
@optional

/**
 * 数组中需要转换的模型类
 *
 * @return 字典中的key 是数组属性名, value 是对应Model的StringFromClass
 */
+(NSDictionary *)lc_objectClassInArray;

/**
 * 将属性名换为其他key, 去字典中取值
 *
 * @return 字典中的key 为属性名, value 是从字典中取值用的key
 */
+ (NSDictionary *)lc_replacedKeyFromPropertyName;

@end

@interface NSObject (Item) <LCKeyValue>

/**
    字典转模型
 */
+(instancetype)modelWithDict:(NSDictionary *)dict;


@end
