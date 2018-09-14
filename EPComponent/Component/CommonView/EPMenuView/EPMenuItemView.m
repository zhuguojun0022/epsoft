//
//  EPMenuItemView.m
//  DongYangHRSS
//
//  Created by shi on 2017/11/20.
//  Copyright © 2017年 epsoft. All rights reserved.
//

#import "EPMenuItemView.h"

@interface EPMenuItemView ()

@property (strong, nonatomic) UIImageView *iconView;    //图标
@property (strong, nonatomic) UILabel *titleLb;         //标题

@end

@implementation EPMenuItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
//    self.backgroundColor = [UIColor greenColor];
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    CGFloat iconW = self.iconSize.width;
    CGFloat iconH = self.iconSize.height;
    if (iconW <= 0 || iconH <= 0) {
        iconW = self.iconView.image.size.width;
        iconH = self.iconView.image.size.height;
    }
    self.iconView.frame = CGRectMake((w - iconW)/2, 0, iconW, iconH);
    
    CGSize titleSize = [self.titleLb.text boundingRectWithSize:CGSizeMake(w, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.titleLb.font} context:nil].size;
    self.titleLb.frame = CGRectMake(0, h - titleSize.height, w, titleSize.height);
}

- (void)setupUI
{
    UIImageView *iconView = [[UIImageView alloc] init];
    [self.contentView addSubview:iconView];
    self.iconView = iconView;
    
    UILabel *titleLb = [[UILabel alloc] init];
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.textColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0f];
    titleLb.font = [UIFont systemFontOfSize:15];
    titleLb.numberOfLines = 1;
    titleLb.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:titleLb];
    self.titleLb = titleLb;
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    self.titleLb.font = titleFont;
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    self.titleLb.textColor = titleColor;
}

@end



