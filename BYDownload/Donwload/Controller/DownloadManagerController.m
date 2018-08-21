//
//  ViewController.m
//  BYDownload
//
//  Created by 崔宝印 on 2018/8/15.
//  Copyright © 2018年 Koolearn. All rights reserved.
//

#import "DownloadManagerController.h"
#import "BYDownloadManager.h"
#import "DownloadObject.h"
#import "BYDownloadCell.h"

//https://devstreaming-cdn.apple.com/videos/wwdc/2015/2267p2ni281ba/226/226_hd_advanced_nsoperations.mp4?dl=1
//https://devstreaming-cdn.apple.com/videos/wwdc/2015/2267p2ni281ba/226/226_sd_advanced_nsoperations.mp4?dl=1
@interface DownloadManagerController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTable;

@property (strong, nonatomic) NSMutableArray *downloadObjectArray;
@property (strong, nonatomic) NSMutableArray *downloadOperationArray;

//@property (strong, nonatomic) NSString *downloadTaskId;
//
//@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
//@property (weak, nonatomic) IBOutlet UILabel *writedLabel;
//@property (weak, nonatomic) IBOutlet UILabel *progressLabel;

@end

@implementation DownloadManagerController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createData];
    [self.myTable reloadData];
}

- (void)createData
{
    DownloadObject *object1 = [[DownloadObject alloc] init];
    object1.downloadURL = @"https://devstreaming-cdn.apple.com/videos/wwdc/2015/2267p2ni281ba/226/226_sd_advanced_nsoperations.mp4?dl=1";
    object1.downloadName = @"Advanced NSOperations视频";
    
    DownloadObject *object2 = [[DownloadObject alloc] init];
    object2.downloadURL = @"https://devstreaming-cdn.apple.com/videos/wwdc/2015/2267p2ni281ba/226/226_advanced_nsoperations.pdf?dl=1";
    object2.downloadName = @"Advanced NSOperations pdf";
    
    [self.downloadObjectArray addObject:object1];
    [self.downloadObjectArray addObject:object2];
}

//
//- (IBAction)startDownload:(id)sender
//{
//    NSString *urlStr = ;
//    NSString *fileName = [NSString stringWithString:urlStr.lastPathComponent];
//    if ([fileName containsString:@"?"])
//    {
//        fileName = [[fileName componentsSeparatedByString:@"?"] firstObject];
//    }
//    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
//    NSString *videoPath = [docPath stringByAppendingPathComponent:fileName];
//    long long localFileSize = 0;
//    if ([[NSFileManager defaultManager] fileExistsAtPath:videoPath])
//    {
//        NSError *error = nil;
//        NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:videoPath error:&error];
//        if (error == nil)
//        {
//            localFileSize = [dict[NSFileSize] longLongValue];
//        }
//    }
//    __weak typeof(self) weakSelf = self;
//    self.downloadTaskId = [[BYDownloadManager sharedDownloadManager] startDownloadWithUrl:urlStr toFilePath:videoPath startLocation:localFileSize progressBlock:^(NSData *recivedData, long recivedDataLengh, long totalDataLengh) {
//        float progress = recivedDataLengh/(float)totalDataLengh;
//        weakSelf.progressLabel.text = [NSString stringWithFormat:@"进度：%.0f%%",progress * 100];
//        weakSelf.totalLabel.text = [NSString stringWithFormat:@"总大小：%.2fM",totalDataLengh/1024.0/1024.0];
//        weakSelf.writedLabel.text = [NSString stringWithFormat:@"写大小：%.2fM",recivedDataLengh/1024.0/1024.0];
//
//    } completeBlock:^(NSString *taskId, BOOL isFinished, NSError *error) {
//        if (isFinished)
//        {
//            [weakSelf.downloadArray removeObject:taskId];
//        }
//    }];
////    [self.downloadArray addObject:taskId];
//}
//
//- (IBAction)suspendDownload:(id)sender
//{
//    [[BYDownloadManager sharedDownloadManager] pauseDownload:self.downloadTaskId];
//}
//
//- (IBAction)resumeDownload:(id)sender
//{
//    [[BYDownloadManager sharedDownloadManager] resumeDownload:self.downloadTaskId];
//}
//
//- (IBAction)cancelDownload:(id)sender
//{
//    [[BYDownloadManager sharedDownloadManager] cancelDownload:self.downloadTaskId];
//}
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//
//}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.downloadObjectArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"BYDownloadCell";
    BYDownloadCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil)
    {
        cell = [[BYDownloadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [cell refreshCellWith:self.downloadObjectArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Getter
- (NSMutableArray *)downloadObjectArray
{
    if (_downloadObjectArray == nil)
    {
        _downloadObjectArray = [NSMutableArray array];
    }
    return _downloadObjectArray;
}

- (NSMutableArray *)downloadOperationArray
{
    if(_downloadOperationArray == nil)
    {
        _downloadOperationArray = [NSMutableArray array];
    }
    return _downloadOperationArray;
}

@end
