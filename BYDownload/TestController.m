//
//  TestController.m
//  BYDownload
//
//  Created by 崔宝印 on 2018/8/15.
//  Copyright © 2018年 Koolearn. All rights reserved.
//

#import "TestController.h"
#import "TestObject.h"
#import "TestOperation.h"

@interface TestController ()
@property (nonatomic, strong) TestBlock myBlock;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, copy) NSMutableString *stringA;
@property (nonatomic, strong) NSMutableString *stringB;
@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation TestController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.queue = [[NSOperationQueue alloc] init];
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

/**
 同步执行blockOperation
 */
- (IBAction)blockOperationSync:(id)sender
{
    NSBlockOperation *opreation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%@",[NSThread currentThread]);//<NSThread: 0x608000263200>{number = 1, name = main}
    }];
    [opreation start];
}


/**
 异步执行blockOperation
 */
- (IBAction)blockOperationAsync:(id)sender
{
    NSBlockOperation *opreation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%@",[NSThread currentThread]);//<NSThread: 0x600000278a00>{number = 3, name = (null)}
    }];
    [self.queue addOperation:opreation];
}

/**
 同步执行custom operation
 start函数：主线程；<NSThread: 0x60800006ca40>{number = 1, name = main}
 main函数：在start函数中调用，主线程；<NSThread: 0x60800006ca40>{number = 1, name = main}
 completionBlock：异步线程；<NSThread: 0x6040004620c0>{number = 3, name = (null)}
 */
- (IBAction)customOperationSync:(id)sender
{
    TestOperation *operation = [[TestOperation alloc] init];
    operation.completionBlock = ^{
        NSLog(@"completionBlock--%@",[NSThread currentThread]);
    };
    [operation start];
}

/**
 异步执行custom operation
 start函数：子线程；<NSThread: 0x60400027db00>{number = 4, name = (null)}
 main函数：在start函数中调用，子线程；<NSThread: 0x60400027db00>{number = 4, name = (null)}
 completionBlock：异步线程；<NSThread: 0x60c00006df00>{number = 5, name = (null)}
 */
- (IBAction)customOperationAsync:(id)sender
{
    TestOperation *operation = [[TestOperation alloc] init];
    operation.completionBlock = ^{
        NSLog(@"completionBlock--%@",[NSThread currentThread]);
    };
    [self.queue addOperation:operation];
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
