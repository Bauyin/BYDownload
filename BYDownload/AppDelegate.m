//
//  AppDelegate.m
//  BYDownload
//
//  Created by 崔宝印 on 2018/8/15.
//  Copyright © 2018年 Koolearn. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (nonatomic, strong) NSString *strStrong;
@property (nonatomic, copy)   NSString *strCopy;
@property (nonatomic, strong) NSMutableString *mutableStrStrong;
@property (nonatomic, copy)   NSMutableString *mutableStrCopy;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self testString];
    return YES;
}

int c = 10;

- (void)testString
{
    static int b = 7;
    int a = 6;

    NSLog(@"##a     = %p",&a);//对象的地址,0x7ffee2ef3dec,栈(stack)内存
    NSLog(@"##b     = %p",&b);//对象的地址,0x104d53478,全局区/静态区(static)
    NSLog(@"##c     = %p",&c);//对象的地址,0x107ee5498,全局区/静态区(static)

    NSObject *object = [[NSObject alloc] init];
    NSLog(@"##object     = %p",&object);//对象的地址,0x7ffee2ef3de0,栈(stack)内存

    
    NSString *string = [NSString stringWithFormat:@"12343242341234123412341234213412341234123412341234123412341"];
//    NSString *string = @"123";
    
    //stringWithFormat在字符串比较短的时候会变成NSTaggedPointerString，输出地址非常高;
    //stringWithFormat在字符串比较长的时候会变成NSCFConstantString，输出地址在栈区
    
    self.strStrong = string;
    self.strCopy = string;
    NSLog(@"##string     = %p",string);//对象的地址,0xa000000003332313,常量区
    NSLog(@"##strongStr = %p",_strStrong);//对象的地址,0xa000000003332313,常量区
    NSLog(@"##copyStr   = %p",_strCopy);//对象的地址,0xa000000003332313,常量区
    
//    NSLog(@"##*string     = %p",&string);//指针的地址,0x16fdea198,堆(heap)内存
//    NSLog(@"##*strongStr = %p",&_strStrong);//指针的地址,0x1700988a8,堆(heap)内存
//    NSLog(@"##*copyStr   = %p",&_strCopy);//指针的地址,0x1700988b0,堆(heap)内存
    
    //NSMutableString在比较短的情况下copy，会变成NSTaggedPointerString
    //NSMutableString在比较长的情况下copy，会变成NSCFConstantString
    //NSMutableString在任何情况下copy，都会变成不可变对象
    //NSMutableString在任何情况下mutableCopy，都会生成一个新的NSMutableString

    NSMutableString *mutableString = [[NSMutableString alloc] initWithString:@"12342342342342342342342342342342342"];
    self.mutableStrStrong = mutableString;
    self.mutableStrCopy = mutableString;
    NSLog(@"##mutableString     = %p",mutableString);//0x600000059cb0,堆(heap)内存
    NSLog(@"##strongMutableStr = %p",_mutableStrStrong);//0x600000059cb0,堆(heap)内存
    NSLog(@"##copyMutableStr   = %p",_mutableStrCopy);//0xa000000003332313,常量区,copy成NSString
    
    
    //__NSCFConstantString
    //NSTaggedPointerString
    
//    NSLog(@"##*mutableString       = %p",&mutableString);//指针的地址,0x16fde6190,堆(heap)内存
//    NSLog(@"##*_mutableStrStrong = %p",&_mutableStrStrong);//指针的地址,0x1700847c8,堆(heap)内存
//    NSLog(@"##*_mutableStrCopy   = %p",&_mutableStrCopy);//指针的地址,0x1700847d0,堆(heap)内存
    
//    heap    0x7ffeeaeb4dec
//    statck  0x600000059cb0
//    static  0x104d53478
//    const   0xa000000003332313
    
    NSString *str1 = @"321";
    NSString *str2 = [str1 copy];
    NSMutableString *str3 = [str1 mutableCopy];
    
    NSLog(@"##str1 = %p",str1);//对象的地址,0x104a9d8f0,常量区
    NSLog(@"##str2 = %p",str2);//对象的地址,0x104a9d8f0,常量区
    NSLog(@"##str3 = %p",str3);//对象的地址,0x107ee5498,全局区/静态区(static)
    
    NSMutableString *mStr1 = [NSMutableString stringWithFormat:@"321"];
    NSMutableString *mStr2 = [mStr1 copy];
    NSMutableString *mStr3 = [mStr1 mutableCopy];
    
    NSLog(@"##mStr1 = %p",mStr1);//对象的地址,0x7ffeeaeb4dec,栈(stack)内存
    NSLog(@"##mStr2 = %p",mStr2);//对象的地址,0x104d53478,全局区/静态区(static)
    NSLog(@"##mStr3 = %p",mStr3);//对象的地址,0x107ee5498,全局区/静态区(static)

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
