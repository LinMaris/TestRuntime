//
//  NSObject+LCProperty.h
//  TestRuntime
//
//  Created by 林川 on 2018/3/12.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LCProperty;

/**
    遍历成员变量用的block
    @param property 成员的包装对象
    @param stop 是否停止遍历
 */
typedef void(^LCPropertiesEnumeration)(LCProperty *property, BOOL stop);

@interface NSObject (LCProperty)
/**
 *  遍历所有的成员
 */
+ (void)lc_enumerateProperties:(LCPropertiesEnumeration)enumeration;


@end
