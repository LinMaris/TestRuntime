//
//  Girls.m
//  TestRuntime
//
//  Created by MarisLin on 2018/3/9.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import "Girls.h"

@implementation Girls

- (void)eatFood1:(NSString *)food1 food2:(NSString *)food2
{
    LCLog(@"food:%@,%@",food1,food2);
}

-(NSUInteger)readBook:(NSString *)bookName
{
    LCLog(@"bookName:%@==>%ld",bookName,bookName.length);
    return bookName.length;
}

-(NSString *)teachBook:(NSString *)name
{
    return [NSString stringWithFormat:@"我教%@",name];
}

@end
