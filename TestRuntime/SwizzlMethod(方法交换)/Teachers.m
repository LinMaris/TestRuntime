//
//  Teachers.m
//  TestRuntime
//
//  Created by MarisLin on 2018/3/8.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import "Teachers.h"

@implementation Teachers

-(void)teachMath
{
    LCLog(@"%s教数学",__func__);
}

-(void)teachChinese
{
    LCLog(@"%s教语文",__func__);
}

@end

@implementation Boys

-(void)learnMath
{
    LCLog(@"%s学数学",__func__);
}

@end
