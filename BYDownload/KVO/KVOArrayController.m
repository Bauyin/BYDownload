//
//  KVOArrayController.m
//  BYDownload
//
//  Created by 崔宝印 on 2018/8/28.
//  Copyright © 2018年 Koolearn. All rights reserved.
//

#import "KVOArrayController.h"
#import "BYKVOArray.h"
typedef void(^TestBlock)(void);

@interface KVOArrayController ()
@property (nonatomic, strong) BYKVOArray *myKvoArray;

@end

@implementation KVOArrayController

- (void)viewDidLoad
{
    [super viewDidLoad];
    __block int a = 10;
//    NSString *str = @"123";
//    NSLog(@"1:%p",&a);
//    NSLog(@"2:%p",&str);

//    NSMutableString *str = [[NSMutableString alloc]initWithString:@"Hello,"];
    NSString *str = @"123";

    TestBlock block = ^{
//        [str appendString:@"World!"];
//        NSLog(@"Block中 str = %@",str);
        a = 15;
//        NSLog(@"2:%@",str);
//        NSLog(@"2:%p",&str);

//        NSLog(@"2:%d",a);
//        NSLog(@"3:%p",&a);
    };
    
    str = @"456";
    block();
    NSLog(@"Block外 str = %@",str);

//    str = @"456";
//    a = 20;
//    block();
//    NSLog(@"4:%d",a);

    self.myKvoArray = [[BYKVOArray alloc] init];
    
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.myKvoArray addObserver:self forKeyPath:@"kvoMutableArray" options:options context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    id newValue = change[NSKeyValueChangeNewKey];
    id oldValue = change[NSKeyValueChangeOldKey];
    NSLog(@"new:%@",newValue);
    NSLog(@"old:%@",oldValue);
}

#pragma mark - Action
- (IBAction)mutableArrayAddObject:(id)sender
{
    NSLog(@"add get");
//    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(self.myKvoArray.kvoMutableArray.count, 1)];

//    [self.myKvoArray insertKvoMutableArray:@[@"123"] atIndexes:indexSet];
    NSMutableArray *kvcArray = [self.myKvoArray mutableArrayValueForKey:@"kvoMutableArray"];

    NSLog(@"add start");
    [kvcArray addObject:@"123"];
    NSLog(@"add end");
}

- (IBAction)mutableArrayRemoveObject:(id)sender
{
    NSLog(@"remove get");
    NSMutableArray *kvcArray = [self.myKvoArray mutableArrayValueForKey:@"kvoMutableArray"];
    if (kvcArray.count)
    {
        NSLog(@"remove start");
        [kvcArray removeLastObject];
        NSLog(@"remove end");
    }
}

- (IBAction)mutableArrayRepalceObject:(id)sender
{
    NSLog(@"replace get");
    NSMutableArray *kvcArray = [self.myKvoArray mutableArrayValueForKey:@"kvoMutableArray"];
    if (kvcArray.count)
    {
        NSLog(@"replace start");
        [kvcArray replaceObjectAtIndex:0 withObject:@"456"];
        NSLog(@"replace end");
    }
}

- (IBAction)mutableDictionaryAddObject:(id)sender
{
    
    NSLog(@"add start");
//    [kvcDict setObject:@"123" forKey:@"456"];
    NSLog(@"add end");
}

- (IBAction)mutableDictionaryRemoveObject:(id)sender
{
}

- (IBAction)mutableDictionaryRepalceObject:(id)sender
{
}

@end
