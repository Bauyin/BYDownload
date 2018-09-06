//
//  BYKVOArray.h
//  BYDownload
//
//  Created by 崔宝印 on 2018/8/28.
//  Copyright © 2018年 Koolearn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BYKVOArray : NSObject

@property (nonatomic, strong) NSArray *kvoArray;
@property (nonatomic, strong) NSMutableArray *kvoMutableArray;
@property (nonatomic, strong) NSDictionary *kvoDictionary;
@property (nonatomic, strong) NSMutableDictionary *kvoMutableDictionary;

//- (void)insertKvoMutableArray:(NSArray *)array atIndexes:(NSIndexSet *)indexes;

@end
