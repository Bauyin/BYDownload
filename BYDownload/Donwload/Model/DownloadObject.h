//
//  DownloadObject.h
//  BYDownload
//
//  Created by 崔宝印 on 2018/8/21.
//  Copyright © 2018年 Koolearn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadObject : NSObject

@property (nonatomic, strong) NSString *downloadURL;
@property (nonatomic, strong) NSString *downloadName;
@property (nonatomic, strong) NSString *cachedPath;
@property (nonatomic, strong) NSString *cachedSizeStr;
@property (nonatomic, strong) NSString *totalSizeStr;
@property (nonatomic, assign) long long cachedSize;
@property (nonatomic, assign) long long totalSize;

@end
