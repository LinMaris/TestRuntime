//
//  UIButton+Extension.m
//  TestRuntime
//
//  Created by MarisLin on 2018/2/26.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import "UIButton+Extension.h"
#import <objc/runtime.h>

static char *extensionKey = "extensionKey";
@implementation UIButton (Extension)

-(void)setExtension:(NSString *)extension
{
    objc_setAssociatedObject(self, &extensionKey, extension, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)extension
{
    return objc_getAssociatedObject(self, &extensionKey);
}

@end
