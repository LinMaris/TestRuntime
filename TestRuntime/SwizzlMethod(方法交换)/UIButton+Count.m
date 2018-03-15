//
//  UIButton+Count.m
//  TestRuntime
//
//  Created by MarisLin on 2018/3/8.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import "UIButton+Count.h"
#import "AppDelegate.h"

@implementation UIButton (Count)

// 会在类第一次加载的时候被调用
+(void)load
{
    Class selfClass = [self class];
    SEL oriSel = @selector(sendAction:to:forEvent:);
    Method oriMethod = class_getInstanceMethod(selfClass, oriSel);
    
    SEL curSel = @selector(my_sendAction:to:forEvent:);
    Method curMethod = class_getInstanceMethod(selfClass, curSel);
    
    BOOL addSucc = class_addMethod(selfClass, oriSel, method_getImplementation(curMethod), method_getTypeEncoding(curMethod));
    if (addSucc) {
        class_replaceMethod(selfClass, curSel, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    }else {
        method_exchangeImplementations(oriMethod, curMethod);
    }
}

-(void)my_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    AppDelegate *appDele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDele.count += 1;
    [self my_sendAction:action to:target forEvent:event];
}

@end


