//
//  TitleInputView.m
//  HRSS
//
//  Created by shi on 2017/4/12.
//  Copyright © 2017年 epsoft. All rights reserved.
//

#import "TitleInputView.h"

#import "UIColor+EP.h"
#import "UIImage+Extension.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "UIView+Frame.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface TitleInputView ()

@property (strong, nonatomic) UILabel *titleLb;

@property (strong, nonatomic) UITextField *inputField;

@property (assign, nonatomic) NSUInteger titleWidth;

@property (assign, nonatomic) NSUInteger space;

@end

@implementation TitleInputView

- (instancetype)initWithFrame:(CGRect)frame titleWidth:(NSUInteger)width space:(NSUInteger)space
{
    self = [self initWithFrame:frame];
    self.titleWidth = width;
    self.space = space;
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *lb = [[UILabel alloc] init];
        lb.textColor = kFontColor_Dark;
        lb.font = Font_Scale_375(14);
        [self addSubview:lb];
        self.titleLb = lb;
        
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
    
    self.titleLb.frame = CGRectMake(0, 0, self.titleWidth, self.height);
    CGFloat fieldX= CGRectGetMaxX(self.titleLb.frame) + self.space;
    self.inputField.frame = CGRectMake(fieldX, 0, self.width - fieldX, self.height);
}

@end
