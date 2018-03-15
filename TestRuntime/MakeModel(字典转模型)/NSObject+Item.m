//
//  NSObject+Item.m
//  TestRuntime
//
//  Created by MarisLin on 2018/3/13.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import "NSObject+Item.h"
#import <objc/runtime.h>


@implementation NSObject (Item)

+(instancetype)modelWithDict:(NSDictionary *)dict
{
    id model = [[self alloc] init];
    
    unsigned int count;
    
    // 获取属性数组
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        
        // 获取属性
        objc_property_t property = properties[i];
        // 获取属性名称 C -> OC字符串
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        
        // 去字典中取出对应的值
        id value = dict[propertyName];
        
        if (!value) {  // 未找到值, 比如userId, 实际key为id
            NSString *realKey = [self lc_replacedKeyFromPropertyName][propertyName];
            if (realKey) {
                value = dict[realKey];
            }
        }
        
        // 获取属性类型
        /**
            T@"NSString", &, N, V_name  NSString类型
            Ti, N, "V_age"    int类型
            T@"GitHubModel",&,N,V_gitHub  自定义类型
         */
        NSString *propertyAttributes = [NSString stringWithUTF8String:property_getAttributes(property)];
        NSString *propertyType = [[[propertyAttributes componentsSeparatedByString:@","] firstObject] substringFromIndex:1];  // 默认去掉 T
        
        LCLog(@"propertyType:==>%@",propertyAttributes);
        
        // 二级转换,字典中还有字典,也需要把对应字典转换成模型
        // 判断value 是否是字典.
        if ([value isKindOfClass:[NSDictionary class]] && ![propertyType  hasPrefix:@"NS"]){  //是字典对象, 并且属性名对应类型 为自定义类型.
            
            NSArray *charaArr = @[@"@",@"\""];
            for (NSString *chara in charaArr) {
               propertyType = [propertyType stringByReplacingOccurrencesOfString:chara withString:@""];
            }
            
            // 获取模型类对象 GitHubModel
            Class modelClass = NSClassFromString(propertyType);
            if (modelClass) {
                value = [modelClass modelWithDict:value];
            }
        }
        
        // 三级转换: NSArray中也是字典, 将数组中的字典转换成模型.
        if ([value isKindOfClass:[NSArray class]]) {
            
            NSDictionary *param = [self lc_objectClassInArray];
            if (param[propertyType]) {
                
                // 生成模型
                Class classModel = NSClassFromString(param[propertyType]);
                
                NSMutableArray *arrM = [NSMutableArray array];
                // 遍历字典数组, 生成模型数组.
                for (NSDictionary *dic in value) {
                    // 字典转模型
                    id model = [classModel modelWithDict:dic];
                    [arrM addObject:model];
                }
                
                // 把模型数组赋值给value
                value = arrM;
            }
        }
        
        // kvc 字典 赋值
        if (value) {
            [model setValue:value forKey:propertyName];
        }
    }
    return model;
}
@end
