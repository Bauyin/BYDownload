//
//  main.m
//  BYDownload
//
//  Created by 崔宝印 on 2018/8/15.
//  Copyright © 2018年 Koolearn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "BlockTest.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        BlockTest *test = [[BlockTest alloc] init];
        [test blockTestGloabl1];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

