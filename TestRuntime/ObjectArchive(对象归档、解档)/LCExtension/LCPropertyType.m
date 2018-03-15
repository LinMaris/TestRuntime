//
//  LCPropertyType.m
//  TestRuntime
//
//  Created by MarisLin on 2018/3/13.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import "LCPropertyType.h"
#import "LCExtensionConst.h"
#import "LCFoundation.h"

@implementation LCPropertyType

static NSMutableDictionary *types_;
+ (void)initialize
{
    types_ = [NSMutableDictionary dictionary];
}

+ (instancetype)cachedTypeWithCode:(NSString *)code
{
    LCExtensionAssertParamNotNil2(code, nil);
    @synchronized (self) {
        LCPropertyType *type = types_[code];
        if (type == nil) {
            type = [[self alloc] init];
            type.code = code;
            types_[code] = type;
        }
        return type;
    }
}

#pragma mark - 公共方法
-(void)setCode:(NSString *)code
{
    _code = code;

    LCExtensionAssertParamNotNil(code);

    if ([code isEqualToString:LCPropertyTypeId]) {
        _idType = YES;
    } else if (code.length == 0){
        _KVCDisabled = YES;
    } else if (code.length > 3 && [code hasPrefix:@"@\""]) { // @"NSString",&,N,V_name
        _code = [code substringWithRange:NSMakeRange(2, code.length - 3)];
        _typeClass = NSClassFromString(_code);
        
        _fromFoundation = [LCFoundation isClassFromFoundation:_typeClass];
        _numberType = [_typeClass isSubclassOfClass:[NSNumber class]];
    }
    else if ([code isEqualToString:LCPropertyTypeSEL] ||
             [code isEqualToString:LCPropertyTypeIvar] ||
             [code isEqualToString:LCPropertyTypeMethod]) {
        _KVCDisabled = YES;
    }
    
    // 是否为数字类型
    NSString *lowerCode = _code.lowercaseString;
    NSArray *numberTypes = @[LCPropertyTypeInt, LCPropertyTypeShort, LCPropertyTypeBOOL1, LCPropertyTypeBOOL2, LCPropertyTypeFloat, LCPropertyTypeDouble, LCPropertyTypeLong, LCPropertyTypeLongLong, LCPropertyTypeChar];
    if ([numberTypes containsObject:lowerCode]) {
        _numberType = YES;
        
        if ([lowerCode isEqualToString:LCPropertyTypeBOOL1]
            || [lowerCode isEqualToString:LCPropertyTypeBOOL2]) {
            _boolType = YES;
        }
    }
}
@end

