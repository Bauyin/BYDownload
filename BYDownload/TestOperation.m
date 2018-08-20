//
//  TestOperation.m
//  BYDownload
//
//  Created by 崔宝印 on 2018/8/20.
//  Copyright © 2018年 Koolearn. All rights reserved.
//

#import "TestOperation.h"

@implementation TestOperation

- (void)start
{
    NSLog(@"start--start--%@",[NSThread currentThread]);
    [super start];
    NSLog(@"start--end");
}

- (void)main
{
    NSLog(@"main--start--%@",[NSThread currentThread]);
    [super main];
    NSLog(@"main--end");
}
@end
