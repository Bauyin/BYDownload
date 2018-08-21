//
//  BYDownloadCell.h
//  BYDownload
//
//  Created by 崔宝印 on 2018/8/21.
//  Copyright © 2018年 Koolearn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloadObject.h"

@interface BYDownloadCell : UITableViewCell

- (void)refreshCellWith:(DownloadObject *)model;

@end
