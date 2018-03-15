//
//  UIImage+Extension.m
//  TestRuntime
//
//  Created by MarisLin on 2018/3/8.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+(void)load
{
    //  此方法会在类第一次加载的时候被调用
    // 获取两个方法
    Method imgNamedMethod = class_getClassMethod(self, @selector(imageNamed:));
    Method lcImgNamedMethod = class_getClassMethod(self, @selector(lc_imageNamed:));
    
    // 交换方法
    method_exchangeImplementations(imgNamedMethod, lcImgNamedMethod);
}

+ (UIImage *)lc_imageNamed:(NSString *)name {
    // 因为来到这里的时候方法实际上已经被交换过了
    // 这里要调用 imageNamed: 就需要调用 被交换过的 tuc_imageNamed
    UIImage *img = [UIImage lc_imageNamed:name];
    LCLog(@"%s,%@",__func__,@"我被调用了");
    return img;
}

@end
