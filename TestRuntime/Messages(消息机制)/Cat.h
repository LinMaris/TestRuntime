//
//  Cat.h
//  TestRuntime
//
//  Created by MarisLin on 2018/3/8.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cat : NSObject
{
    // 成员变量
    NSString *age;
}

//-(void)eatFish;

//-(void)run:(NSNumber *)num;

// 被@property修饰的属性 会默认生成setter, getter方法, 以及带下划线的成员变量, 如_name
@property(nonatomic,copy) NSString *name;

@end
