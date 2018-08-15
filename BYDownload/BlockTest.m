//
//  BlockTest.m
//  BYDownload
//
//  Created by 崔宝印 on 2018/8/15.
//  Copyright © 2018年 Koolearn. All rights reserved.
//

#import "BlockTest.h"
@implementation BlockTest

- (void)blockTestAuto
{
    int temp = 5;
    void(^MyBlock)(void) = ^{
        NSLog(@"%d",temp);
    };
    NSLog(@"%d",temp);
    MyBlock();
}

static int staic = 5;

- (void)blockTestStatic
{
    void(^MyBlock)(void) = ^{
        NSLog(@"%d",staic);
    };
    NSLog(@"%d",staic);
    MyBlock();
}

int gloable = 5;

- (void)blockTestGloable
{
    void(^MyBlock)(void) = ^{
        NSLog(@"%d",gloable);
    };
    NSLog(@"%d",gloable);
    MyBlock();
}

- (void)blockTestGloabl1
{
    NSMutableArray *array = [NSMutableArray arrayWithObject:@"123"];
    
    void(^MyBlock)(void) = ^{
        [array addObject:@"345"];
        NSLog(@"%d",gloable);
    };
    NSLog(@"%d",gloable);
    MyBlock();
}


- (void)blockTest__Block
{
    __block int temp = 5;
    void(^MyBlock)(void) = ^{
        NSLog(@"%d",temp);
    };
    NSLog(@"%d",temp);
    MyBlock();
}
@end
