//
//  NSObject+LCClass.m
//  TestRuntime
//
//  Created by 林川 on 2018/3/12.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import "NSObject+LCClass.h"
#import "LCFoundation.h"

static const char MJAllowedPropertyNamesKey = '\0';
static const char MJIgnoredPropertyNamesKey = '\0';
static const char MJAllowedCodingPropertyNamesKey = '\0';
static const char MJIgnoredCodingPropertyNamesKey = '\0';

static NSMutableDictionary *allowedPropertyNamesDict_;
static NSMutableDictionary *ignoredPropertyNamesDict_;
static NSMutableDictionary *allowedCodingPropertyNamesDict_;
static NSMutableDictionary *ignoredCodingPropertyNamesDict_;

@implementation NSObject (LCClass)

+ (void)load
{
    allowedPropertyNamesDict_ = [NSMutableDictionary dictionary];
    ignoredPropertyNamesDict_ = [NSMutableDictionary dictionary];
    allowedCodingPropertyNamesDict_ = [NSMutableDictionary dictionary];
    ignoredCodingPropertyNamesDict_ = [NSMutableDictionary dictionary];
}

+ (NSMutableDictionary *)dictForKey:(const void *)key
{
    @synchronized (self) {
        if (key == &MJAllowedPropertyNamesKey) return allowedPropertyNamesDict_;
        if (key == &MJIgnoredPropertyNamesKey) return ignoredPropertyNamesDict_;
        
        if (key == &MJAllowedCodingPropertyNamesKey)
            return allowedCodingPropertyNamesDict_;
        
        if (key == &MJIgnoredCodingPropertyNamesKey)
            return ignoredCodingPropertyNamesDict_;
        return nil;
    }
}

+ (void)mj_enumerateClasses:(LCClassesEnumeration)enumeration
{
    if (!enumeration) {return;}
    
    BOOL stop = NO;
    
    Class c = self;
    
    while (c && !stop) {
        enumeration(c, stop);
        
        // 获取父类
        c = class_getSuperclass(c);
        
        if ([LCFoundation isClassFromFoundation:c]) break;
    }
}

+ (void)mj_enumerateAllClasses:(LCClassesEnumeration)enumeration
{
    // 1.没有block就直接返回
    if (enumeration == nil) return;
    
    // 2.停止遍历的标记
    BOOL stop = NO;
    
    // 3.当前正在遍历的类
    Class c = self;
    
    // 4.开始遍历每一个类
    while (c && !stop) {
        // 4.1.执行操作
        enumeration(c, stop);
        
        // 4.2.获得父类
        c = class_getSuperclass(c);
    }
}

@end



