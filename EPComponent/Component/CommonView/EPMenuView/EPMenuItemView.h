//
//  EPMenuItemView.h
//  DongYangHRSS
//
//  Created by shi on 2017/11/20.
//  Copyright © 2017年 epsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EPMenuItemView : UICollectionViewCell

@property (strong, nonatomic, readonly) UIImageView *iconView;    //图标
@property (strong, nonatomic, readonly) UILabel *titleLb;         //标题

///标题字体
@property (strong, nonatomic) UIFont *titleFont;
///标题颜色
@property (strong, nonatomic) UIColor *titleColor;
///图标大小
@property (assign, nonatomic) CGSize iconSize;
///图标与标题之间的间隔
@property (assign, nonatomic) CGFloat iconTitleSpace;
@end
