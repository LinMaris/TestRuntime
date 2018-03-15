//
//  MsgSendViewController.m
//  TestRuntime
//
//  Created by MarisLin on 2018/3/8.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import "MsgSendViewController.h"
#import "Cat.h"
#import <objc/message.h>
#import "Dog.h"

@interface MsgSendViewController ()

@property(nonatomic,strong) Cat *cat;

@end

@implementation MsgSendViewController

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
    
    // 测试消息发送
//    [self testSendMsg];
    
    // 输出类信息
    [self logInfo];
    
    // 通过runtime 设置属性值
//    [self testSet];
}

#pragma mark - 输出类信息
-(void)logInfo {
    unsigned int count;// 用于记录列表内的数量，进行循环输出
    
    // 获取属性列表
    objc_property_t *propertyList = class_copyPropertyList([Cat class], &count);
    for (unsigned int i = 0; i < count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
//                LCLog(@"propertyName%d==>%@\n ",i,[NSString stringWithUTF8String:propertyName]);
    }
    
    // 获取方法列表
    Method *methodList = class_copyMethodList([UITextField class], &count);
    for (unsigned int i = 0; i < count; i++){
        Method method = methodList[i];
        //        LCLog(@"method%d==>%@\n",i,
        //              NSStringFromSelector(method_getName(method)));
    }
    
    // 获取成员变量列表
    Ivar *ivarList = class_copyIvarList([Cat class], &count);
    for (unsigned int i = 0; i < count; i++){
        const char *ivarName = ivar_getName(ivarList[i]);
//        LCLog(@"ivarName%d:==>%@\n",i,[NSString stringWithUTF8String:ivarName]);
    }
    
    [self.view addSubview:({
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 100, 44)];
        tf.placeholder = @"hello world!";
        tf.backgroundColor = [UIColor lightGrayColor];
//        [tf setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
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

#pragma mark - 消息传递
-(void)testSendMsg
{
    // 创建对象
    //    Cat *cat = [[Cat alloc] init];
    
    // 使用runtime创建对象
    // 根据 名称 获取 类
    Class catClass = objc_getClass("Cat");
    
    //创建实例对象
    // 如果这里报错，请将 Build Setting -> Enable Strict Checking of objc_msgSend Calls 改为 NO ,  是否在 消息传递时 开启严密检查
    Cat *cat = objc_msgSend(catClass, @selector(alloc));
    
    // 初始化对象
    cat = objc_msgSend(cat, @selector(init));
    
    // 调用对象方法
    objc_msgSend(cat, @selector(eatFish));
    
    // 还可以这么做
    Cat *cat2 = objc_msgSend(objc_msgSend(objc_getClass("Cat"),sel_registerName("alloc")), sel_registerName("init"));
    objc_msgSend(cat2, @selector(run:), 100);
}

-(void)testSet
{
    self.cat = [Cat new];
    LCLog(@"self.cat.name1:%@",self.cat.name);
    
    unsigned int count;
    Ivar *ivarList = class_copyIvarList([Cat class], &count);
    
    for (unsigned int i = 0; i < count; i++){
        Ivar ivar = ivarList[i];
        const char *ivarName = ivar_getName(ivar);
        NSString *ivarStr = [NSString stringWithUTF8String:ivarName];
        LCLog(@"ivarName%d:==>%@\n",i,ivarStr);
        if ([ivarStr isEqualToString:@"_name"]) {
            object_setIvar(self.cat, ivar, @"Jack");
        }
    }
    LCLog(@"self.cat.name2:%@",self.cat.name);
    
    [self.cat setValue:@"Lili" forKey:@"_name"];
    LCLog(@"self.cat.name3:%@",self.cat.name);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
