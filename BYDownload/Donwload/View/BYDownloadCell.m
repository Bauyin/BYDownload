//
//  BYDownloadCell.m
//  BYDownload
//
//  Created by 崔宝印 on 2018/8/21.
//  Copyright © 2018年 Koolearn. All rights reserved.
//

#import "BYDownloadCell.h"
#import "BYDownloadManager.h"
#import "BYDownloadOpreation.h"

typedef enum{
    BYDownloadCellStatusUnstart = 0,
    BYDownloadCellStatusReady = 1,
    BYDownloadCellStatusExecuting = 2,
    BYDownloadCellStatusPaused = 3 ,
    BYDownloadCellStatusFinished = 4 ,
    BYDownloadCellStatusError = 5
}BYDownloadCellStatus;


@interface BYDownloadCell()

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@property (nonatomic, strong) DownloadObject *downloadModel;
@property (nonatomic, strong) NSString *downloadOperationId;
@property (nonatomic, assign) BYDownloadCellStatus nowStatus;
@property (nonatomic, strong) BYDownloadOpreation *opreation;

@end

@implementation BYDownloadCell

- (void)refreshCellWith:(DownloadObject *)model
{
    self.downloadModel = model;
    
    self.nameLabel.text = model.downloadName;
    self.nowStatus = BYDownloadCellStatusUnstart;
    [self refreshProgressUI];
}

- (void)refreshProgressUI
{
    if (_downloadModel.cachedSize == _downloadModel.totalSize && _downloadModel.cachedSize > 0)
    {
        self.nowStatus = BYDownloadCellStatusFinished;
    }
    float progress = _downloadModel.cachedSize == 0 ? 0 : _downloadModel.cachedSize/(float)_downloadModel.totalSize;
    self.progressView.progress = progress;
    self.progressLabel.text = [NSString stringWithFormat:@"%.1f%%",progress * 100];
    self.sizeLabel.text = [NSString stringWithFormat:@"%@/%@",_downloadModel.cachedSizeStr,_downloadModel.totalSizeStr];
}

#pragma mark - Setter
- (void)setNowStatus:(BYDownloadCellStatus)nowStatus
{
    _nowStatus = nowStatus;
    switch (_nowStatus)
    {
        case BYDownloadCellStatusUnstart:
        {
            self.statusLabel.text = @"点击开始下载";
            break;
        }
        case BYDownloadCellStatusReady:
        {
            self.statusLabel.text = @"等待中";
            break;
        }
        case BYDownloadCellStatusExecuting:
        {
            self.statusLabel.text = @"点击暂停下载";
            break;
        }
        case BYDownloadCellStatusPaused:
        {
            self.statusLabel.text = @"点击继续下载";
            break;
        }
        case BYDownloadCellStatusFinished:
        {
            self.statusLabel.text = @"下载完成";
            break;
        }
        case BYDownloadCellStatusError:
        {
            self.statusLabel.text = @"下载失败,点击重试";
            break;
        }
        default:
            break;
    }
}

#pragma mark - IBAction
- (IBAction)cellClicked:(id)sender
{
    if (self.nowStatus == BYDownloadCellStatusFinished) return;
    if (self.nowStatus == BYDownloadCellStatusError) return;
    if (self.nowStatus == BYDownloadCellStatusReady || self.nowStatus == BYDownloadCellStatusExecuting)
    {
        self.nowStatus = BYDownloadCellStatusPaused;
//        [[BYDownloadManager sharedDownloadManager] pauseDownload:self.downloadOperationId];
        [self.opreation suspend];
    }
    if (self.nowStatus == BYDownloadCellStatusPaused)
    {
        self.nowStatus = BYDownloadCellStatusReady;
//        [[BYDownloadManager sharedDownloadManager] resumeDownload:self.downloadOperationId];
        [self.opreation resume];
    }
    if (self.nowStatus == BYDownloadCellStatusUnstart)
    {
//        [self startDownload];
        [self startDownloadOperation];
    }
}

- (void)startDownload
{
    __weak typeof(self) weakSelf = self;
    self.downloadOperationId = [[BYDownloadManager sharedDownloadManager] startDownloadWithUrl:_downloadModel.downloadURL toFilePath:_downloadModel.cachedPath startLocation:_downloadModel.cachedSize progressBlock:^(NSData *recivedData, long recivedDataLengh, long totalDataLengh) {
        self.nowStatus = BYDownloadCellStatusExecuting;
        
        weakSelf.downloadModel.cachedSize = recivedDataLengh;
        weakSelf.downloadModel.totalSize = totalDataLengh;
        [weakSelf refreshProgressUI];
    } completeBlock:^(NSString *taskId, BOOL isFinished, NSError *error) {
        if (!isFinished && error != nil)
        {
            weakSelf.nowStatus = BYDownloadCellStatusError;
        }
        else
        {
            weakSelf.nowStatus = BYDownloadCellStatusFinished;
        }
    }];
    self.nowStatus = BYDownloadCellStatusReady;
}

- (void)startDownloadOperation
{
    __weak typeof(self) weakSelf = self;
    self.opreation = [[BYDownloadOpreation alloc] initOperationWithDownloadUrl:self.downloadModel.downloadURL writeToFilePath:self.downloadModel.cachedPath writedFileSize:self.downloadModel.cachedSize progressBlock:^(NSData *recivedData, long recivedDataLengh, long totalDataLengh) {
        self.nowStatus = BYDownloadCellStatusExecuting;
        weakSelf.downloadModel.cachedSize = recivedDataLengh;
        weakSelf.downloadModel.totalSize = totalDataLengh;
        [weakSelf refreshProgressUI];
    } completeBlock:^(NSString *taskId, BOOL isFinished, NSError *error) {
        if (!isFinished && error != nil)
        {
            weakSelf.nowStatus = BYDownloadCellStatusError;
        }
        else
        {
            weakSelf.nowStatus = BYDownloadCellStatusFinished;
        }
    }];
    [self.opreation start];
    self.nowStatus = BYDownloadCellStatusReady;
}
@end
