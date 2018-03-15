//
//  NSObject+LCClass.h
//  TestRuntime
//
//  Created by 林川 on 2018/3/12.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  遍历所有类的block（父类）
 */
typedef void (^LCClassesEnumeration)(Class c, BOOL stop);

@interface NSObject (LCClass)

/**
 *  遍历所有的类
 */
+ (void)lc_enumerateClasses:(LCClassesEnumeration)enumeration;
+ (void)lc_enumerateAllClasses:(LCClassesEnumeration)enumeration;

@end
