//
//  TestCopyObject.m
//  BYDownload
//
//  Created by 崔宝印 on 2018/9/7.
//  Copyright © 2018年 Koolearn. All rights reserved.
//

#import "TestCopyObject.h"

@implementation TestCopyObject

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}
- (id)mutableCopyWithZone:(NSZone *)zone
{
    return self;
}
@end
