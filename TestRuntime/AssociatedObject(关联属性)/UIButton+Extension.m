//
//  UIButton+Extension.m
//  TestRuntime
//
//  Created by MarisLin on 2018/2/26.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import "UIButton+Extension.h"
#import <objc/runtime.h>

/**
     作用: 在一个Category中为分类添加属性
     key值: 一个对象级别的唯一常量
     声明 static char kAssociatedObjectKey;
     声明 static void *kAssociatedObjectKey = &kAssociatedObjectKey;
     用 selector ，使用 getter 方法的名称作为 key 值。
 */

static char *extensionKey = "extensionKey";
@implementation UIButton (Extension)

//-(void)setExtension:(NSString *)extension
//{
//    objc_setAssociatedObject(self, &extensionKey, extension, OBJC_ASSOCIATION_COPY_NONATOMIC);
//}
//
//-(NSString *)extension
//{
//    return objc_getAssociatedObject(self, &extensionKey);
//}

-(void)setExtension:(NSString *)extension
{
    objc_setAssociatedObject(self, @selector(extension), extension, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)extension
{
    return objc_getAssociatedObject(self, _cmd);
}

@end
