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
@property (nonatomic, strong) NSString *strStrong;
@property (nonatomic, copy) NSString *strCopy;

@end

@implementation StringTestController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self testMutableStringType];
    [self testCopyMutableCopy];
}

- (void)testObjectCopy
{
    
}
/**
 可变对象copy--->新的不可变对象(深copy)
 可变对象mutablecopy--->新的可变对象(深copy)
 不可变对象copy--->引用计数+1 (浅copy)
 不可变对象mutablecopy--新的可变对象(深copy)
 */
- (void)testCopyMutableCopy
{
    NSArray *array = @[@123,@321];//__NSArrayI
    NSArray *array1 = [array copy];//__NSArrayI
    NSMutableArray *array2 = [array mutableCopy];//__NSArrayM
    NSLog(@"array的地址：%p, array的类型：%@",array,[array class]);
    NSLog(@"array1的地址：%p, array1的类型：%@",array1,[array1 class]);
    NSLog(@"array2的地址：%p, array2的类型：%@",array2,[array2 class]);
    
    NSMutableArray *mArray1 = [NSMutableArray arrayWithArray:@[@123,@321]];//__NSArrayM
    NSMutableArray *mArray2 = [mArray1 copy];//__NSArrayI
    NSMutableArray *mArray3 = [mArray1 mutableCopy];//__NSArrayM
    NSLog(@"mArray1的地址：%p, mArray1的类型：%@",mArray1,[mArray1 class]);
    NSLog(@"mArray2的地址：%p, mArray2的类型：%@",mArray2,[mArray2 class]);
    NSLog(@"mArray3的地址：%p, mArray3的类型：%@",mArray3,[mArray3 class]);
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

/**
 NSString作为属性我们一般用copy来修饰,防止传进来可变对象时,在对象不知情的情况下对属性进行了修改
 1:直接使用实例变量进行赋值,strong/copy没有任何区别,只是增加强引用
 2:使用setter方法赋值
    2.1:传入参数为不可变对象(NSString),strong/copy没有任何区别,增加一个强引用
    2.2:传入参数为可变对象(NSMutableString),
 strong只是生成一个强指针指向对象;
 copy会对对象进行深copy,生成一个__NSCFString存放在堆区或者生成一个NSTaggedPointString对象
 */
- (void)testStrongCopy
{
    [self logTag];
    NSString *str = @"我";
    NSString *strFormat = [NSString stringWithFormat:@"我"];
    self.strCopy = strFormat;
    self.strStrong = strFormat;
    
    //str的地址：0x10e50d920, str指针的地址：0x7ffee16fc0b8
    NSLog(@"str的地址：%p, str指针的地址：%p",str,&str);
    
    //strFormat的地址：0x608000426b60, strFormat指针的地址：0x7ffee16fc0b0
    NSLog(@"strFormat的地址：%p, strFormat指针的地址：%p",strFormat,&strFormat);
    
    //_strCopy的地址：0x10e50d920, _strCopy指针的地址：0x7ff7eec1a6b0
    NSLog(@"_strCopy的地址：%p, _strCopy指针的地址：%p",_strCopy,&_strCopy);
    
    //_strStrong的地址：0x10e50d920, _strStrong指针的地址：0x7ff7eec1a6a8
    NSLog(@"_strStrong的地址：%p, _strStrong指针的地址：%p",_strStrong,&_strStrong);
    
    NSMutableString *mStr = [[NSMutableString alloc] initWithString:@"我"];
    _strStrong = mStr;
    _strCopy = mStr;
    
    //mStr的地址：0x60000024a980, mStr指针的地址：0x7ffee200a0a8
    NSLog(@"mStr的地址：%p, mStr指针的地址：%p",mStr,&mStr);
    
    //_strCopy的地址：0x60000024a980, _strCopy指针的地址：0x7fc9c66087b0
    NSLog(@"_strCopy的地址：%p, _strCopy指针的地址：%p",_strCopy,&_strCopy);
    
    //_strStrong的地址：0x60000024a980, _strStrong指针的地址：0x7fc9c66087a8
    NSLog(@"_strStrong的地址：%p, _strStrong指针的地址：%p",_strStrong,&_strStrong);
    
    self.strStrong = mStr;
    self.strCopy = mStr;
    
    //mStr的地址：0x60000024a980, mStr指针的地址：0x7ffee200a0a8
    NSLog(@"mStr的地址：%p, mStr指针的地址：%p",mStr,&mStr);
    
    //_strCopy的地址：0x60000024a980, _strCopy指针的地址：0x7fc9c66087b0
    NSLog(@"_strCopy的地址：%p, _strCopy指针的地址：%p",_strCopy,&_strCopy);
    
    //_strStrong的地址：0x60000024a980, _strStrong指针的地址：0x7fc9c66087a8
    NSLog(@"_strStrong的地址：%p, _strStrong指针的地址：%p",_strStrong,&_strStrong);
}

- (void)testMutableStringType
{
    NSMutableString *mStr1 = [[NSMutableString alloc] initWithString:@"123"];//0x60c00024d440,堆区,__NSCFString
    NSMutableString *mStr2 = [NSMutableString stringWithFormat:@"123"];//0x60c00024c420,堆区,__NSCFString
    NSMutableString *mStr3 = [[NSMutableString alloc] initWithString:@"123"];//0x60c0002529c0,堆区,__NSCFString
    NSMutableString *mStrCopy1 = [mStr1 copy];//指针在常量区,NSTaggedPointString,0xa000000003332313
    NSMutableString *mStrCopy2 = [mStr2 copy];//指针在常量区,NSTaggedPointString,0xa000000003332313
    NSMutableString *mStrCopy3 = [mStr3 copy];//指针在常量区,NSTaggedPointString,0xa000000003332313

    NSLog(@"mStr1的地址：%p, mStr1的类型：%@",mStr1,[mStr1 class]);
    NSLog(@"mStr2的地址：%p, mStr2的类型：%@",mStr2,[mStr2 class]);
    NSLog(@"mStr3的地址：%p, mStr3的类型：%@",mStr3,[mStr3 class]);
    NSLog(@"mStrCopy1的地址：%p, mStrCopy1的类型：%@",mStrCopy1,[mStrCopy1 class]);
    NSLog(@"mStrCopy2的地址：%p, mStrCopy2的类型：%@",mStrCopy2,[mStrCopy2 class]);
    NSLog(@"mStrCopy3的地址：%p, mStrCopy3的类型：%@",mStrCopy3,[mStrCopy3 class]);
    
    NSMutableString *mStrNA1 = [[NSMutableString alloc] initWithString:@"我"];//0x60c00024d440,堆区,__NSCFString
    NSMutableString *mStrNA2 = [NSMutableString stringWithFormat:@"我"];//0x60c00024c420,堆区,__NSCFString
    NSMutableString *mStrNA3 = [[NSMutableString alloc] initWithString:@"我"];//0x60c0002529c0,堆区,__NSCFString
    NSMutableString *mStrNACopy1 = [mStrNA1 copy];//堆区,__NSCFString,0x600000420e00
    NSMutableString *mStrNACopy2 = [mStrNA2 copy];//堆区,__NSCFString,0x600000221260
    NSMutableString *mStrNACopy3 = [mStrNA3 copy];//堆区,__NSCFString,0x600000221400
    
    NSLog(@"mStrNA1的地址：%p, mStrNA1的类型：%@",mStrNA1,[mStrNA1 class]);
    NSLog(@"mStrNA2的地址：%p, mStrNA2的类型：%@",mStrNA2,[mStrNA2 class]);
    NSLog(@"mStrNA3的地址：%p, mStrNA3的类型：%@",mStrNA3,[mStrNA3 class]);
    NSLog(@"mStrNACopy1的地址：%p, mStrNACopy1的类型：%@",mStrNACopy1,[mStrNACopy1 class]);
    NSLog(@"mStrNACopy2的地址：%p, mStrNACopy2的类型：%@",mStrNACopy2,[mStrNACopy2 class]);
    NSLog(@"mStrNACopy3的地址：%p, mStrNACopy3的类型：%@",mStrNACopy3,[mStrNACopy3 class]);
}

- (void)testStringType
{
    NSString *str1 = @"123";
    NSString *str2 = [NSString stringWithFormat:@"123"];
    NSString *str3 = [NSString stringWithFormat:@"我"];
    
    NSMutableString *mStr1 = [str1 mutableCopy];
    NSMutableString *mStr2 = [str2 mutableCopy];
    NSMutableString *mStr3 = [str3 mutableCopy];

    //str1的地址：0x1019aa5a0, str1类型：__NSCFConstantString, 常量区
    NSLog(@"str1的地址：%p, str1类型：%@",str1,[str1 class]);
    
    //str2的地址：0xa000000003332313, str1类型：NSTaggedPointerString,堆区
    NSLog(@"str2的地址：%p, str1类型：%@",str2,[str2 class]);

    //str3的地址：0x60000042a080, str3类型：__NSCFString,堆区
    NSLog(@"str3的地址：%p, str3类型：%@",str3,[str3 class]);

    //mStr1的地址：0x6080000491b0, mStr1类型：__NSCFString,堆区
    NSLog(@"mStr1的地址：%p, mStr1类型：%@",mStr1,[mStr1 class]);
    
    //mStr2的地址：0x608000048730, mStr2类型：__NSCFString,堆区
    NSLog(@"mStr2的地址：%p, mStr2类型：%@",mStr2,[mStr2 class]);
    
    //mStr3的地址：0x608000049240, mStr3类型：__NSCFString,堆区
    NSLog(@"mStr3的地址：%p, mStr3类型：%@",mStr3,[mStr3 class]);
}

- (void)testNumberTaggerPoint
{
    NSNumber *number1 = [NSNumber numberWithInteger:1];;
    NSNumber *number2 = [NSNumber numberWithInt:1];;
    NSNumber *number3 = [NSNumber numberWithShort:1];;
    NSNumber *number4 = [NSNumber numberWithLong:1];;
    NSNumber *number5 = [NSNumber numberWithLongLong:1];;
    NSNumber *number6 = [NSNumber numberWithFloat:1.0];
    NSNumber *number7 = [NSNumber numberWithDouble:1.0];;
    NSNumber *number8 = [NSNumber numberWithUnsignedInteger:1];;
    NSNumber *number9 = [NSNumber numberWithChar:'1'];;
    
    NSLog(@"Integer: %p",number1);//0xa000000003332313-->堆区(heap),TaggedPoint
    NSLog(@"UnsignedInteger: %p",number8);//0xa000000003332313-->堆区(heap),TaggedPoint
    NSLog(@"Int: %p",number2);//0xa000000003332313-->堆区(heap),TaggedPoint
    NSLog(@"Short: %p",number3);//0xa000000003332313-->堆区(heap),TaggedPoint
    NSLog(@"Long: %p",number4);//0xa000000003332313-->堆区(heap),TaggedPoint
    NSLog(@"LongLong: %p",number5);//0xa000000003332313-->堆区(heap),TaggedPoint
    NSLog(@"Float: %p",number6);//0xa000000003332313-->堆区(heap),TaggedPoint
    NSLog(@"Double: %p",number7);//0xa000000003332313-->堆区(heap),TaggedPoint
    NSLog(@"Char: %p",number9);//0xa000000003332313-->堆区(heap),TaggedPoint
}

- (void)testStringTaggedPoint
{
    NSString *str = @"1234";
    NSMutableString *mutableStr = [[NSMutableString alloc] initWithString:@"132"];

    NSLog(@"str: %p",str);//0x1000a4588-->常量区,地址在全局区/静态区之下
    NSLog(@"mutableStr: %p",mutableStr);//0x17407f080-->堆区(heap)
    NSLog(@"mutableStrCopy1: %p",[str mutableCopy]);
    NSLog(@"mutableStrCopy2: %p",[str mutableCopy]);
    NSLog(@"mutableStrCopy3: %p",[mutableStr copy]);
    NSLog(@"mutableStrCopy4: %p",[mutableStr copy]);
    NSLog(@"mutableStrCopy5: %p",[mutableStr copy]);
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

    NSNumber *bigNumber = @(0xEFFFFFFFFFFFFFFF);
    NSLog(@"bigNumber pointer is %p", bigNumber);
    
}


@end
