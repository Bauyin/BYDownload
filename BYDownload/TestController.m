//
//  TestController.m
//  BYDownload
//
//  Created by 崔宝印 on 2018/8/15.
//  Copyright © 2018年 Koolearn. All rights reserved.
//

#import "TestController.h"
#import "TestObject.h"

@interface TestController ()
@property (nonatomic, strong) TestBlock myBlock;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, copy) NSMutableString *stringA;
@property (nonatomic, strong) NSMutableString *stringB;
@end

@implementation TestController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.myBlock = ^{
//        NSLog(@"%@",self);
//    };
//    [self stringCopyTest];

}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

- (void)stringCopyTest
{
    NSString *string = @"123";
    self.stringA = [NSMutableString stringWithString:string];
    self.stringB = [NSMutableString stringWithString:string];
    NSString *appendA = [self.stringA stringByAppendingString:@"456"];
    NSString *appendB = [self.stringB stringByAppendingString:@"456"];
    NSLog(@"string:%p",string);
    NSLog(@"stringA:%p",_stringA);
    NSLog(@"stringB:%p",_stringB);
    NSLog(@"appendA:%p",appendA);
    NSLog(@"appendB:%p",appendB);
}

- (void)UserDefaultsTest
{
    //    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"123",@"345",nil];
    //    [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"123"];
    //    id object = [[NSUserDefaults standardUserDefaults] objectForKey:@"123"];
    [[NSUserDefaults standardUserDefaults] setObject:[[NSObject alloc]init] forKey:@"123"];
}
/**
 NSArray持有对象和Block捕获对象的区别
 */
- (void)selfArryAddSelf
{
    self.array = [NSMutableArray arrayWithCapacity:0];
    TestObject *object = [[TestObject alloc] init];
    object.controller = self;
    [self.array addObject:object];
}
@end
