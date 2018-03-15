//
//  LCExtensionConst.h
//  TestRuntime
//
//  Created by MarisLin on 2018/3/13.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#ifndef __LCExtensionConst__H__
#define __LCExtensionConst__H__

#import <Foundation/Foundation.h>


#define LCExtensionAssert2(condition, returnValue) \
if ((condition) == NO) return returnValue;

/**
 * 断言
 * @param condition   条件
 */
#define LCExtensionAssert(condition) LCExtensionAssert2(condition, )

/**
 * 断言
 * @param param         参数
 * @param returnValue   返回值
 */
#define LCExtensionAssertParamNotNil2(param, returnValue) \
LCExtensionAssert2((param) != nil, returnValue)

/**
 * 断言
 * @param param   参数
 */
#define LCExtensionAssertParamNotNil(param) LCExtensionAssertParamNotNil2(param, )

/**
 *  类型 (属性)
 */
extern NSString *const LCPropertyTypeInt;
extern NSString *const LCPropertyTypeShort;
extern NSString *const LCPropertyTypeFloat;
extern NSString *const LCPropertyTypeDouble;
extern NSString *const LCPropertyTypeLong;
extern NSString *const LCPropertyTypeLongLong;
extern NSString *const LCPropertyTypeChar;
extern NSString *const LCPropertyTypeBOOL1;
extern NSString *const LCPropertyTypeBOOL2;
extern NSString *const LCPropertyTypePointer;

extern NSString *const LCPropertyTypeIvar;
extern NSString *const LCPropertyTypeMethod;
extern NSString *const LCPropertyTypeBlock;
extern NSString *const LCPropertyTypeClass;
extern NSString *const LCPropertyTypeSEL;
extern NSString *const LCPropertyTypeId;

#endif

