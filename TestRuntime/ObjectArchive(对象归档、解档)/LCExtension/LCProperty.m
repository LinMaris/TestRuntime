//
//  LCProperty.m
//  TestRuntime
//
//  Created by 林川 on 2018/3/12.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import "LCProperty.h"
#import "LCPropertyType.h"

@implementation LCProperty

#pragma mark - 缓存
+(instancetype)cachedPropertyWithProperty:(objc_property_t)property
{
    LCProperty *propertyObj = objc_getAssociatedObject(self, property);
    if (propertyObj == nil) {
        propertyObj = [[self alloc] init];
        propertyObj.property = property;
        objc_setAssociatedObject(self, property, propertyObj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return propertyObj;
}

#pragma mark - 公共方法
-(void)setProperty:(objc_property_t)property
{
    _property = property;
    
    // 1. 属性名  C ==> OC
    // [NSString stringWithUTF8String:property_getName(property)] 同理
    _name = @(property_getName(property));
    
    // 2. 成员类型
    // T@"NSString", &, N, V_name  NSString类型, 就是获取NSString
    NSString *attrs = @(property_getAttributes(property));
    NSUInteger dotLoc = [attrs rangeOfString:@","].location;
    NSString *code = nil;
    NSUInteger loc = 1;
    
    if (dotLoc == NSNotFound) {  //  没有 ,
        code = [attrs substringFromIndex:loc];
    }else {
        code = [attrs substringWithRange:NSMakeRange(loc, dotLoc - loc)];
    }
    
    // 获取成员变量类型
    _type = [LCPropertyType cachedTypeWithCode:code];
}

/**
 *  获得成员变量的值
 */
- (id)valueForObject:(id)object
{
    if (self.type.KVCDisabled) return [NSNull null];
    return [object valueForKey:self.name];
}

/**
 *  设置成员变量的值
 */
-(void)setValue:(id)value forObject:(id)object
{
    if (self.type.KVCDisabled || value == nil) return;
    [object setValue:value forKey:self.name];
}



@end
