//
//  NSObject+LCCoding.h
//  TestRuntime
//
//  Created by 林川 on 2018/3/12.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LCCoding)

/**
    解档 从文件中解析对象
 */
- (void)lc_decode:(NSCoder *)decoder;
/**
    归档 将对象写入到文件中
 */
- (void)lc_encode:(NSCoder *)encoder;

@property(nonatomic,strong) NSArray *ignoredPropertyArray;

/**
 归档的实现
 */
#define LCCodingImplementation \
-(instancetype)initWithCoder:(NSCoder *)aDecoder\
{\
    if (self = [super init]) {\
        [self lc_decode:aDecoder];\
    }\
    return self;\
}\
-(void)encodeWithCoder:(NSCoder *)aCoder\
{\
    [self lc_encode:aCoder];\
}


@end
