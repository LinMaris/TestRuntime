//
//  NSObject+LCCoding.m
//  TestRuntime
//
//  Created by 林川 on 2018/3/12.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import "NSObject+LCCoding.h"
#import <objc/runtime.h>

/**
    此版本未做缓存
 */

@implementation NSObject (LCCoding)

// 归档
-(void)lc_encode:(NSCoder *)encoder
{
    Class selfClass = self.class;
    while (selfClass &&selfClass != [NSObject class]) {
        
        unsigned int count;
        objc_property_t *propertyList = class_copyPropertyList([self class], &count);
        for (int i = 0; i < count; i++) {
            objc_property_t property = propertyList[i];
            NSString *key = [NSString stringWithUTF8String:property_getName(property)];
            
            // 如果有忽略该属性 就跳过
            if ([self.ignoredPropertyArray containsObject:key]) continue;
            
            id value = [self valueForKey:key];
            [encoder encodeObject:value forKey:key];

        }
        // 释放内存
        free(propertyList);
        selfClass = [selfClass superclass];
    }
}

// 解档
-(void)lc_decode:(NSCoder *)decoder
{
    // 不光归档自身的属性，还要循环把所有父类的属性也找出来
    Class selfClass = self.class;
    while (selfClass && selfClass != [NSObject class]) {
        
        unsigned int count;
        objc_property_t *propertyList = class_copyPropertyList([self class], &count);
        for (int i = 0; i < count; i++) {
            objc_property_t property = propertyList[i];
            NSString *key = [NSString stringWithUTF8String:property_getName(property)];
            
            // 如果有忽略该属性 就跳过
            if ([self.ignoredPropertyArray containsObject:key]) continue;
            
            id value = [decoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(propertyList);
        
        selfClass = [selfClass superclass];
    }
}

-(void)setIgnoredPropertyArray:(NSArray *)ignoredPropertyArray
{
    objc_setAssociatedObject(self, @selector(ignoredPropertyArray), ignoredPropertyArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSArray *)ignoredPropertyArray
{
    return objc_getAssociatedObject(self, _cmd);
}

@end



