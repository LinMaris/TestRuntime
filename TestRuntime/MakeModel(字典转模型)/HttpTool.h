//
//  HttpTool.h
//  TestRuntime
//
//  Created by MarisLin on 2018/3/12.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpTool : NSObject

+(void)requestUrl:(NSString *)url completion:(void(^)(NSDictionary *))completion;

@end
