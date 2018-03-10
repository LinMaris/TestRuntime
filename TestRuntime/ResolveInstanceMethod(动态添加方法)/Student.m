//
//  Student.m
//  TestRuntime
//
//  Created by MarisLin on 2018/3/8.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import "Student.h"

@implementation Student

/**
 // 调用不存在的类方法时触发，默认返回NO，可以加上自己的处理后返回YES
 + (BOOL)resolveClassMethod:(SEL)sel;
 
 // 调用不存在的实例方法时触发，默认返回NO，可以加上自己的处理后返回YES
 + (BOOL)resolveInstanceMethod:(SEL)sel;
 
 // 将调用的不存在的方法重定向到一个其他声明了这个方法的类里去，返回那个类的target
 - (id)forwardingTargetForSelector:(SEL)aSelector;
 
 // 将调用的不存在的方法打包成 NSInvocation 给你，自己处理后调用 invokeWithTarget: 方法让某个类来触发
 - (void)forwardInvocation:(NSInvocation *)anInvocation;
 */

void run(id self, SEL _cmd, NSNumber *meters) {
    LCLog(@"MethodViewController跑了%@米",meters);
}

// 当调用了一个未实现的实例方法会首先来到这里,可动态添加方法
// 如果返回YES, 表示相应 selector 的实现已经被找到并添加到了类中, 否则返回NO
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    
    if (sel == NSSelectorFromString(@"run:")) {
        // 动态添加
        class_addMethod(self, @selector(run:), (IMP)run, "v@:@");
        return YES;
        /**
         (IMP)run 意思是run的地址指针;
         "v@:" 意思是v 代表无返回值void，如果是i则代表返回值是int；
                    @ 代表 id sel;
                    : 代表 SEL _cmd;
         “v@:@@” 意思是, 两个参数的没有返回值。
                        最后面两个@@代表方法传入的两个参数
          v@:*  通用参数
         */
    }
    return [super resolveInstanceMethod:sel];
}


@end
