//
//  ViewController.m
//  TestRuntime
//
//  Created by MarisLin on 2018/2/26.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "UIButton+Extension.h"


@interface ViewController ()
// 声明一个方法
- (void)clickMe;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     struct objc_class {
     Class _Nonnull isa  // 指针, 示例isa指向类对象, 类对象的isa指向元类
     
     #if !__OBJC2__
         Class _Nullable super_class  // 指向父类
         const char * _Nonnull name   // 类名
         long version
         long info
         long instance_size
         struct objc_ivar_list * _Nullable ivars     // 成员变量列表
         struct objc_method_list * _Nullable * _Nullable methodLists  // 方法列表                    OBJC2_UNAVAILABLE;
         struct objc_cache * _Nonnull cache    // 缓存
         struct objc_protocol_list * _Nullable protocols   // 协议列表
         #endif
     
     } OBJC2_UNAVAILABLE;
     */
    
    [self testRuntime];
}

-(void)testRuntime {
    // 输出类信息
    [self logInfo];
    
    // 动态添加 与 拦截调用
    [self dynamicInvoke];
    
    // 在Category中设置属性
    // 见 [self dynamicInvoke];
}

#pragma mark - 动态添加 与 拦截调用
-(void)dynamicInvoke{
    
    [self.view addSubview:({
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 44)];
        btn.backgroundColor = [UIColor lightGrayColor];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(clickMe) forControlEvents:UIControlEventTouchUpInside];
        btn.extension = @"点我吧";
        [btn setTitle:btn.extension forState:0];
        btn;
    })];
    
    /**
     // 调用不存在的类方法时触发，默认返回NO，可以加上自己的处理后返回YES
     + (BOOL)resolveClassMethod:(SEL)sel;
     
     // 调用不存在的实例方法时触发，默认返回NO，可以加上自己的处理后返回YES
     + (BOOL)resolveInstanceMethod:(SEL)sel;
     
     // 将调用的不存在的方法重定向到一个其他声明了这个方法的类里去，返回那个类的target
     - (id)forwardingTargetForSelector:(SEL)aSelector;
     
     // 将调用的不存在的方法打包成 NSInvocation 给你，自己处理后调用 invokeWithTarget: 方法让某个类来触发
     - (void)forwardInvocation:(NSInvocation *)anInvocation;
     */
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    LCLog(@"%s",__func__);
    // 给本类动态添加一个方法
    if ([NSStringFromSelector(sel) isEqualToString:@"clickMe"]) {
        class_addMethod(self, sel, (IMP)runAddMethod, "v@:*");
    }
    return YES;
}
// 要动态添加的方法
void runAddMethod(id self, SEL _cmd, NSString *string) {
    LCLog(@"点我了");
}

#pragma mark - 输出类信息
-(void)logInfo {
    unsigned int count;// 用于记录列表内的数量，进行循环输出

    // 获取属性列表
    objc_property_t *propertyList = class_copyPropertyList([UITextField class], &count);
    for (unsigned int i = 0; i < count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
//        LCLog(@"propertyName%d==>%@\n ",i,[NSString stringWithUTF8String:propertyName]);
    }
    
    // 获取方法列表
    Method *methodList = class_copyMethodList([UITextField class], &count);
    for (unsigned int i = 0; i < count; i++){
        Method method = methodList[i];
//        LCLog(@"method%d==>%@\n",i,
//              NSStringFromSelector(method_getName(method)));
    }
    
    // 获取成员变量列表
    Ivar *ivarList = class_copyIvarList([UITextField class], &count);
    for (unsigned int i = 0; i < count; i++){
        const char *ivarName = ivar_getName(ivarList[i]);
        LCLog(@"ivarName%d:==>%@\n",i,[NSString stringWithUTF8String:ivarName]);
    }
    
    [self.view addSubview:({
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 100, 44)];
        tf.placeholder = @"hello world!";
        tf.backgroundColor = [UIColor lightGrayColor];
        [tf setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
        tf;
    })];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit)]];
    
    // 获取协议列表
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([UITextField class], &count);
    for (unsigned int i = 0; i < count; i++){
        const char *protocolName = protocol_getName(protocolList[i]);
//        LCLog(@"protocolName%d==>%@\n",i,[NSString stringWithUTF8String:protocolName]);
    }

}

-(void)endEdit{
    [self.view endEditing:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
