//
//  IconInputView.m
//  HRSS
//
//  Created by shi on 2017/4/13.
//  Copyright © 2017年 epsoft. All rights reserved.
//

#import "IconInputView.h"

#import "UIColor+EP.h"
#import "UIImage+Extension.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "UIView+Frame.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface IconInputView ()

@property (strong, nonatomic) UIImageView *iconView;

@property (strong, nonatomic) UITextField *inputField;

@property (assign, nonatomic) CGSize iconSize;

@property (assign, nonatomic) NSUInteger space;

@end

@implementation IconInputView

- (instancetype)initWithFrame:(CGRect)frame iconSize:(CGSize)size space:(NSUInteger)space
{
    self = [self initWithFrame:frame];
    self.iconSize = size;
    self.space = space;
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        UITextField *field = [[UITextField alloc] init];
        field.textColor = kFontColor_Dark;
        field.font = Font_Scale_375(14);
        [self addSubview:field];
        self.inputField = field;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.iconSize.width <=0 || self.iconSize.height <= 0) {
        self.iconSize = self.iconView.image.size;
    }
    
    self.iconView.frame = CGRectMake(0, (self.height - self.iconSize.height) / 2, self.iconSize.width, self.iconSize.height);
    CGFloat fieldX= CGRectGetMaxX(self.iconView.frame) + self.space;
    self.inputField.frame = CGRectMake(fieldX, 0, self.width - fieldX, self.height);
}

@end
