//
//  InvokecationController.m
//  TestRuntime
//
//  Created by MarisLin on 2018/3/9.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import "InvokecationController.h"
#import "Girls.h"

@interface InvokecationController ()

@end

@implementation InvokecationController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    /**
        NSMethodSignature, 方法签名.
        苹果官方定义该类为 对方法的参数、返回类型进行封装.
        协同NSInvocation实现消息转发.
        通过消息转发实现类似C++中的多重继承.
     */
    
    Girls *girl = [[Girls alloc] init];

    // invoke 调用
//    [self lc_performAction:@"eatFood1:food2:" target:girl params1:@"sky" params2:@"apple"];
    
    // 系统调用
//    [girl performSelector:@selector(eatFood1:food2:) withObject:@"apple" withObject:@"sky"];
    
    // 复用 performSelector
     NSUInteger len = [self lc_performAction2:@"readBook:" target:girl params:@"apple"];
//    LCLog(@"你是谁?\n我是%ld",len);
    
    NSString *teachStr = [self lc_performAction2:@"teachBook:" target:girl params:@"math"];
    LCLog(@"%@",teachStr);
}

-(void)lc_performAction:(NSString *)actionStr target:(id)target params1:(NSString *)params1 params2:(NSString *)params2
{
    SEL myAction = NSSelectorFromString(actionStr);
    // 创建签名
    NSMethodSignature *sig = [target methodSignatureForSelector:myAction];
    // 初始化
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
    
    // 设置
//    [invocation setTarget:target];
//    [invocation setSelector:myAction];
    [invocation setArgument:&target atIndex:0];
    [invocation setArgument:&myAction atIndex:1];
    [invocation setArgument:&params1 atIndex:2];
    [invocation setArgument:&params2 atIndex:3];
    
    // 调用此方法
    [invocation invoke];
}

-(id)lc_performAction2:(NSString *)actionStr target:(id)target params:(NSString *)params
{
    SEL myAction = NSSelectorFromString(actionStr);
    // 创建签名
    NSMethodSignature *sig = [target methodSignatureForSelector:myAction];
    
    const char* retType = [sig methodReturnType];
    
    if (strcmp(retType, @encode(NSUInteger)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
        [invocation setTarget:target];
        [invocation setSelector:myAction];
        [invocation setArgument:&params atIndex:2];
        [invocation invoke];
        NSUInteger result = 1;
        [invocation getReturnValue:&result];
        return @(10);//[NSNumber numberWithUnsignedInteger:1];//@(result);
    }
    
    if (strcmp(retType, @encode(NSString *)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
        [invocation setTarget:target];
        [invocation setSelector:myAction];
        [invocation setArgument:&params atIndex:2];
        [invocation invoke];
        NSString *result = @"jack";
        [invocation getReturnValue:&result];
        return result;
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    //忽略selector警告,因为此时编译器不知道这个 selector 是什么
    return [target performSelector:myAction withObject:params];
#pragma clang diagnostic pop
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
