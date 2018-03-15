//
//  LCProperty.h
//  TestRuntime
//
//  Created by 林川 on 2018/3/12.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LCPropertyType;
@interface LCProperty : NSObject

/** 成员属性 */
@property (nonatomic, assign) objc_property_t property;
/** 成员属性的名字 */
@property (nonatomic, readonly) NSString *name;

/** 成员属性的类型 */
@property (nonatomic, readonly) LCPropertyType *type;

/** 成员属性来源于哪个类（可能是父类） */
@property (nonatomic, assign) Class srcClass;

/**
 *  初始化
 */
+ (instancetype)cachedPropertyWithProperty:(objc_property_t)property;

/**
 * 设置object的成员变量值
 */
- (void)setValue:(id)value forObject:(id)object;
/**
 * 得到object的成员属性值
 */
- (id)valueForObject:(id)object;

@end
