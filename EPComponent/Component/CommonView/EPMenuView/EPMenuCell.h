//
//  EPMenuCell.h
//  DongYangHRSS
//
//  Created by shi on 2017/11/21.
//  Copyright © 2017年 epsoft. All rights reserved.
//
//  对EPMenuView的简单包装,以便用于UITablieView中

#import <UIKit/UIKit.h>
#import "EPMenuView.h"

@interface EPMenuCell : UITableViewCell

@property (strong, nonatomic, readonly) EPMenuView *menuView;

+ (instancetype)createCellWithTableView:(UITableView *)tableView;

@end
