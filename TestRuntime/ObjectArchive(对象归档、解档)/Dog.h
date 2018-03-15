//
//  Dog.h
//  TestRuntime
//
//  Created by MarisLin on 2018/3/12.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cat.h"

@interface Dog : NSObject

@property(nonatomic,copy) NSString *name;
@property(nonatomic,assign) int age;

@property(nonatomic,strong) Cat *cat;

@end
