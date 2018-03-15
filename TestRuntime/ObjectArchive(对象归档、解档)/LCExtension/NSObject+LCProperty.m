//
//  NSObject+LCProperty.m
//  TestRuntime
//
//  Created by 林川 on 2018/3/12.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import "NSObject+LCProperty.h"
#import "NSObject+LCClass.h"
#import "LCProperty.h"
#import "LCFoundation.h"

static const char LCCachedPropertiesKey = '\0';

static NSMutableDictionary *cachedPropertiesDict_;

@implementation NSObject (LCProperty)

+ (void)load
{
    cachedPropertiesDict_ = [NSMutableDictionary dictionary];
}

+ (NSMutableDictionary *)dictForKey:(const void *)key
{
    @synchronized (self) {
        if (key == &LCCachedPropertiesKey) return cachedPropertiesDict_;
        return nil;
    }
}

#pragma mark - 公共方法

+(void)lc_enumerateProperties:(LCPropertiesEnumeration)enumeration
{
    // 获得成员变量
    NSArray *cachedProperties = [self properties];
    
    // 遍历成员变量
    BOOL stop = NO;
    for (LCProperty *property in cachedProperties) {
        enumeration(property, stop);
        if (stop) {break;}
    }
}

+(NSMutableArray *)properties
{
    NSMutableArray *cachedProperties = [self dictForKey:&LCCachedPropertiesKey][NSStringFromClass([self class])];
    
    if (!cachedProperties) {
        cachedProperties = [NSMutableArray array];
        
        [self lc_enumerateClasses:^(__unsafe_unretained Class c, BOOL stop) {
            
            // 1. 获得成员变量
            unsigned int count = 0;
            objc_property_t *properties = class_copyPropertyList(c, &count);
            
            // 2. 遍历每一个成员变量
            for (unsigned int i = 0; i < count; i++) {
                
                LCProperty *property = [LCProperty cachedPropertyWithProperty:properties[i]];
                // 过滤掉Foundation框架类里面的属性
                if ([LCFoundation isClassFromFoundation:property.srcClass]) continue;
                
                property.srcClass = c;
                
                [cachedProperties addObject:property];
            }
            
            // 3. 释放内存
            free(properties);
        }];
        
        // 缓存属性数据
        [self dictForKey:&LCCachedPropertiesKey][NSStringFromClass(self)] = cachedProperties;
    }
    return cachedProperties;
}

@end
