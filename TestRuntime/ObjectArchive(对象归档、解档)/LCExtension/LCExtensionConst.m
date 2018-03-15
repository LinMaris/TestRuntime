//
//  LCExtensionConst.m
//  TestRuntime
//
//  Created by MarisLin on 2018/3/13.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#ifndef __LCExtensionConst__M__
#define __LCExtensionConst__M__

#import <Foundation/Foundation.h>

/**
 *  成员变量类型（属性类型）
 */
NSString *const LCPropertyTypeInt = @"i";
NSString *const LCPropertyTypeShort = @"s";
NSString *const LCPropertyTypeFloat = @"f";
NSString *const LCPropertyTypeDouble = @"d";
NSString *const LCPropertyTypeLong = @"l";
NSString *const LCPropertyTypeLongLong = @"q";
NSString *const LCPropertyTypeChar = @"c";
NSString *const LCPropertyTypeBOOL1 = @"c";
NSString *const LCPropertyTypeBOOL2 = @"b";
NSString *const LCPropertyTypePointer = @"*";

NSString *const LCPropertyTypeIvar = @"^{objc_ivar=}";
NSString *const LCPropertyTypeMethod = @"^{objc_method=}";
NSString *const LCPropertyTypeBlock = @"@?";
NSString *const LCPropertyTypeClass = @"#";
NSString *const LCPropertyTypeSEL = @":";
NSString *const LCPropertyTypeId = @"@";

#endif

