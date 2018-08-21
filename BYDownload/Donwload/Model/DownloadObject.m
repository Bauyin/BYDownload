//
//  DownloadObject.m
//  BYDownload
//
//  Created by 崔宝印 on 2018/8/21.
//  Copyright © 2018年 Koolearn. All rights reserved.
//

#import "DownloadObject.h"

@implementation DownloadObject

- (instancetype)init
{
    if (self = [super init])
    {
        self.downloadURL = nil;
        self.cachedSize = 0;
        self.totalSize = 0;
    }
    return self;
}

- (void)setDownloadURL:(NSString *)downloadURL
{
    _downloadURL = downloadURL;
    
    [self setFileWith:downloadURL];
}

- (void)setFileWith:(NSString *)downloadURL
{
    if (!downloadURL)
    {
        self.cachedPath = nil;
        return;
    }
    
    NSString *fileName = [NSString stringWithString:downloadURL.lastPathComponent];
    if ([fileName containsString:@"?"])
    {
        fileName = [[fileName componentsSeparatedByString:@"?"] firstObject];
    }
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];

    NSString *videoPath = [docPath stringByAppendingPathComponent:@"BYDownload"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:videoPath])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:videoPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    self.cachedPath = [videoPath stringByAppendingPathComponent:fileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.cachedPath])
    {
        NSError *error = nil;
        NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:self.cachedPath error:&error];
        if (error == nil)
        {
            self.cachedSize = [dict[NSFileSize] longLongValue];
        }
    }
}

- (void)setCachedSize:(long long)cachedSize
{
    _cachedSize = cachedSize;
    _cachedSizeStr = [NSString stringWithFormat:@"%.1fM",cachedSize/1024.0/1024.0];
}

- (void)setTotalSize:(long long)totalSize
{
    _totalSize = totalSize;
    _totalSizeStr = [NSString stringWithFormat:@"%.1fM",totalSize/1024.0/1024.0];
}
@end
