//
//  HttpTool.m
//  TestRuntime
//
//  Created by MarisLin on 2018/3/12.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import "HttpTool.h"

@implementation HttpTool

+(void)requestUrl:(NSString *)url completion:(void(^)(NSDictionary *))completion
{
    // 从网络请求数据
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        completion ? completion(dict) : nil;
    }];
    [task resume];
}

@end
