//
//  Cat.m
//  TestRuntime
//
//  Created by MarisLin on 2018/3/8.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import "Cat.h"
#import "NSObject+LCCoding.h"

@implementation Cat

-(void)eatFish
{
    LCLog(@"吃鱼");
}

-(void)run:(int)meters
{
    NSLog(@"跑了%ld米",meters);
}

LCCodingImplementation

@end
