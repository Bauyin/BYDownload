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
    self.stringA = [NSMutableString stringWithString:@"123"];
    self.stringB = [NSMutableString stringWithString:@"123"];
    NSString *appendA = [self.stringA stringByAppendingString:@"456"];
    NSString *appendB = [self.stringA stringByAppendingString:@"456"];
    NSLog(@"%@---%@",appendA,appendB);
    [[NSUserDefaults standardUserDefaults] setObject:[[NSObject alloc] init] forKey:@"123"];
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
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
