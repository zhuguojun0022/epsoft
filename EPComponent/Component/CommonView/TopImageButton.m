//
//  TopImageButton.m
//  HRSS
//
//  Created by shi on 2017/4/10.
//  Copyright © 2017年 epsoft. All rights reserved.
//

#import "TopImageButton.h"
#import "UIButton+WebCache.h"

#import "UIColor+EP.h"
#import "UIImage+Extension.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "UIView+Frame.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface TopImageButton ()

@end

@implementation TopImageButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        //设置默认值
        self.space = kRatio_Scale_375(8);
        [self setTitleColor:[UIColor colorWithHexString:@"3c3c3c"] forState:UIControlStateNormal];
        [self.titleLabel setFont:Font_Scale_375(14)];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnH = self.bounds.size.height;
    CGFloat btnW = self.bounds.size.width;
    
    //计算单行高度
    NSDictionary *attr = @{ NSFontAttributeName: self.titleLabel.font };
    CGSize singleSize = [@" " sizeWithAttributes:attr];
    //实际高度
    CGSize size = [self.titleLabel.attributedText boundingRectWithSize:CGSizeMake(btnW - 0, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    //垂直方向上图片与单行文本的高度作为整体居中
    CGRect imgFrame = CGRectMake((btnW - self.imageSize.width) / 2, (btnH - self.imageSize.height - self.space - singleSize.height) / 2, self.imageSize.width, self.imageSize.height);
    self.imageView.frame = imgFrame;
    
    CGRect textFrame = CGRectMake((btnW - size.width) / 2, CGRectGetMaxY(self.imageView.frame) + self.space, size.width, size.height);
    self.titleLabel.frame = textFrame;
}


@end
