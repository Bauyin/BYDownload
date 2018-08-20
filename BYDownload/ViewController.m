//
//  ViewController.m
//  BYDownload
//
//  Created by 崔宝印 on 2018/8/15.
//  Copyright © 2018年 Koolearn. All rights reserved.
//

#import "ViewController.h"
#import "BYDownloadManager.h"

//https://devstreaming-cdn.apple.com/videos/wwdc/2015/2267p2ni281ba/226/226_hd_advanced_nsoperations.mp4?dl=1
//https://devstreaming-cdn.apple.com/videos/wwdc/2015/2267p2ni281ba/226/226_sd_advanced_nsoperations.mp4?dl=1
@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *downloadArray;

@property (strong, nonatomic) NSString *downloadTaskId;

@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *writedLabel;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)startDownload:(id)sender
{
    NSString *urlStr = @"https://devstreaming-cdn.apple.com/videos/wwdc/2015/2267p2ni281ba/226/226_sd_advanced_nsoperations.mp4?dl=1";
    NSString *fileName = [NSString stringWithString:urlStr.lastPathComponent];
    if ([fileName containsString:@"?"])
    {
        fileName = [[fileName componentsSeparatedByString:@"?"] firstObject];
    }
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *videoPath = [docPath stringByAppendingPathComponent:fileName];
    
    __weak typeof(self) weakSelf = self;
    self.downloadTaskId = [[BYDownloadManager sharedDownloadManager] startDownloadWithUrl:urlStr toFilePath:videoPath startLocation:0 progressBlock:^(NSData *recivedData, long recivedDataLengh, long totalDataLengh) {
        float progress = recivedDataLengh/(float)totalDataLengh;
        weakSelf.progressLabel.text = [NSString stringWithFormat:@"进度：%.0f%%",progress * 100];
        weakSelf.totalLabel.text = [NSString stringWithFormat:@"总大小：%.2fM",totalDataLengh/1024.0/1024.0];
        weakSelf.writedLabel.text = [NSString stringWithFormat:@"写大小：%.2fM",recivedDataLengh/1024.0/1024.0];

    } completeBlock:^(NSString *taskId, BOOL isFinished, NSError *error) {
        if (isFinished)
        {
            [weakSelf.downloadArray removeObject:taskId];
        }
    }];
//    [self.downloadArray addObject:taskId];
}

- (IBAction)suspendDownload:(id)sender
{
    [[BYDownloadManager sharedDownloadManager] pauseDownload:self.downloadTaskId];
}

- (IBAction)resumeDownload:(id)sender
{
    [[BYDownloadManager sharedDownloadManager] resumeDownload:self.downloadTaskId];
}

- (IBAction)cancelDownload:(id)sender
{
    [[BYDownloadManager sharedDownloadManager] cancelDownload:self.downloadTaskId];
}

#pragma mark - Getter
- (NSMutableArray *)downloadArray
{
    if (_downloadArray == nil)
    {
        _downloadArray = [NSMutableArray array];
    }
    return _downloadArray;
}

@end
