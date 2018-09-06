//
//  StringTestController.m
//  BYDownload
//
//  Created by 崔宝印 on 2018/9/6.
//  Copyright © 2018年 Koolearn. All rights reserved.
//

#import "StringTestController.h"

@interface StringTestController ()
@property (nonatomic, copy) NSMutableString *mStr;
@end

@implementation StringTestController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)logTag
{
    int a = 5;
    NSLog(@"栈区地址: %p",&a);//栈区地址: 0x16fd6d05c
    
    NSObject *object = [[NSObject alloc] init];
    NSLog(@"堆区地址: %p",object);//堆区地址: 0x1700128b0
    
    int static b = 5;
    NSLog(@"全局区/静态区地址: %p",&b);//全局区/静态区地址: 0x1000a9168
}

- (IBAction)WhyIsEqualTo:(id)sender
{
    [self logTag];
    
    NSString *str = @"1234";
    NSMutableString *strMutableCopu = [str mutableCopy];
    
//    [strMutableCopu appendString:@"321"];
//
//    [NSMutableString stringWithString:]
    NSMutableString *mutableStr = [[NSMutableString alloc] initWithString:@"132"];
    self.mStr = mutableStr;
    
//    NSMutableString *temp = [mutableStr copy];
//
//    NSObject *cls = NSClassFromString(@"__NSCFString");
//
//     [temp appendString:@"123"];
    [self.mStr appendString:@"123"];
    
//    NSMutableString *mutableStrCopy = [mutableStr copy];
    
    NSLog(@"str: %p",str);//0x1000a4588-->常量区,地址在全局区/静态区之下
    NSLog(@"mutableStr: %p",mutableStr);//0x17407f080-->堆区(heap)
    NSLog(@"mutableStrCopy1: %p",[str mutableCopy]);
    NSLog(@"mutableStrCopy2: %p",[str mutableCopy]);
    NSLog(@"mutableStrCopy3: %p",[mutableStr copy]);
    NSLog(@"mutableStrCopy4: %p",[mutableStr copy]);
    NSLog(@"mutableStrCopy5: %p",[mutableStr copy]);

    NSNumber *number1 = [NSNumber numberWithInteger:1];;
    
    NSNumber *number2 = [NSNumber numberWithInt:1];;
    NSNumber *number3 = [NSNumber numberWithShort:1];;
    NSNumber *number4 = [NSNumber numberWithLong:1];;
    NSNumber *number5 = [NSNumber numberWithLongLong:1];;
    NSNumber *number6 = [NSNumber numberWithFloat:1.0];
    NSNumber *number7 = [NSNumber numberWithDouble:1.0];;
    NSNumber *number8 = [NSNumber numberWithUnsignedInteger:1];;
    NSNumber *number9 = [NSNumber numberWithChar:'1'];;

//    NSNumber *number8 = [NSNumber numberWithLongLong:2];;

    NSLog(@"Integer: %p",number1);//0xa000000003332313-->栈区(steak),TaggedPoint
    NSLog(@"UnsignedInteger: %p",number8);//0xa000000003332313-->栈区(steak),TaggedPoint
    NSLog(@"Int: %p",number2);//0xa000000003332313-->栈区(steak),TaggedPoint
    NSLog(@"Short: %p",number3);//0xa000000003332313-->栈区(steak),TaggedPoint
    NSLog(@"Long: %p",number4);//0xa000000003332313-->栈区(steak),TaggedPoint
    NSLog(@"LongLong: %p",number5);//0xa000000003332313-->栈区(steak),TaggedPoint
    NSLog(@"Float: %p",number6);//0xa000000003332313-->栈区(steak),TaggedPoint
    NSLog(@"Double: %p",number7);//0xa000000003332313-->栈区(steak),TaggedPoint
    NSLog(@"Char: %p",number9);//0xa000000003332313-->栈区(steak),TaggedPoint


    NSNumber *bigNumber = @(0xEFFFFFFFFFFFFFFF);
    NSLog(@"bigNumber pointer is %p", bigNumber);
    
}

- (IBAction)test2:(id)sender
{
    [self logTag];

    NSString *str = @"123";
    NSMutableString *mutableStr = [NSMutableString stringWithFormat:@"%@", str];
    NSMutableString *mutableStrCopy = [mutableStr copy];
    
    NSLog(@"str: %p",str);//0x1000a4588-->常量区,地址在全局区/静态区之下
    NSLog(@"mutableStr: %p",mutableStr);//0x170263dc0-->堆区(heap)
    NSLog(@"mutableStrCopy: %p",mutableStrCopy);//0xa000000003332313-->栈区(steak),TaggedPoint
}

- (IBAction)test3:(id)sender {
}
- (IBAction)test4:(id)sender {
}
@end
