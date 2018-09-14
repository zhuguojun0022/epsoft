//
//  LoopImageCell.h
//  EPStandardizationAPP
//
//  Created by shi on 2017/11/22.
//  Copyright © 2017年 epsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoopImageView.h"

@interface LoopImageCell : UITableViewCell

@property (strong, nonatomic, readonly) LoopImageView *loopImageView;

+ (instancetype)createCellWithTableView:(UITableView *)tableView;

@end
