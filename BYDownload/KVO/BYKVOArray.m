//
//  BYKVOArray.m
//  BYDownload
//
//  Created by 崔宝印 on 2018/8/28.
//  Copyright © 2018年 Koolearn. All rights reserved.
//

#import "BYKVOArray.h"

@implementation BYKVOArray

- (instancetype)init
{
    if (self = [super init])
    {
        _kvoArray = [NSArray array];
        _kvoMutableArray = [NSMutableArray array];
        _kvoDictionary = [NSDictionary dictionary];
        _kvoMutableDictionary = [NSMutableDictionary dictionary];
    }
    return self;
}

//- (void)insertKvoMutableArray:(NSArray *)array atIndexes:(NSIndexSet *)indexes
//{
//    NSLog(@"%s-start",__func__);
//    [_kvoMutableArray insertObjects:array atIndexes:indexes];
//    NSLog(@"%s-end",__func__);
//}

//- (void)removeKvoMutableArrayAtIndexes:(NSIndexSet *)indexes
//{
//    [_kvoMutableArray removeObjectsAtIndexes:indexes];
////    NSLog(@"%s",__func__);
//}

//- (void)replaceObjectInKvoMutableArrayAtIndex:(NSUInteger)index withObject:(id)object
//{
//    [_kvoMutableArray replaceObjectAtIndex:index withObject:object];
////    NSLog(@"%s",__func__);
//}

- (NSMutableArray *)kvoMutableArray
{
    NSLog(@"%s",__func__);
    return _kvoMutableArray;
}
@end
