//
//  MultiLineCell.m
//  HRSS
//
//  Created by shi on 2017/4/20.
//  Copyright © 2017年 epsoft. All rights reserved.
//

#import "MultiLineCell.h"

#import "UIColor+EP.h"
#import "UIImage+Extension.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "UIView+Frame.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MultiLineCell ()

@property (assign, nonatomic) BOOL contentMoreHeight;    //内容文本比标题高

@property (assign, nonatomic) CGSize titleSize ;

@property (assign, nonatomic) CGSize contentTextSize ;

@end

@implementation MultiLineCell

@synthesize placeholderColor=_placeholderColor;
@synthesize titleColor=_titleColor;
@synthesize valueColor=_valueColor;
@synthesize titleFont=_titleFont;
@synthesize valueFont=_valueFont;

+ (instancetype)createCellWithTableView:(UITableView *)tableView
{
    static NSString *cellId = @"MultiLineCellId";
    
    MultiLineCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[self class] alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.detailTextLabel.textAlignment = NSTextAlignmentJustified;
        self.detailTextLabel.numberOfLines = 0;
        self.detailTextLabel.font = self.valueFont;
        self.detailTextLabel.textColor = self.valueColor;
        
        self.textLabel.numberOfLines = 0;
        self.textLabel.font = self.titleFont;
        self.textLabel.textColor = self.titleColor;
        
        self.space = kRatio_Scale_375(15);
        self.contentAlignment = ContentAlignmentNoSet;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.contentMoreHeight) {
        self.textLabel.frame= CGRectMake(self.textLabel.x, kRatio_Scale_375(10), self.titleSize.width, self.titleSize.height);
    }else{
        self.textLabel.frame = CGRectMake(self.textLabel.x, (self.height - self.titleSize.height)/2, self.titleSize.width, self.titleSize.height);
    }
    self.detailTextLabel.frame = CGRectMake(CGRectGetMaxX(self.textLabel.frame) + self.space, self.textLabel.y, self.contentTextSize.width, self.contentTextSize.height);
    
    switch (self.contentAlignment) {
        case ContentAlignmentNoSet:
            
            break;
        case ContentAlignmentLeft:
            self.detailTextLabel.textAlignment = NSTextAlignmentLeft;
            break;
        case ContentAlignmentCenter:
            self.detailTextLabel.textAlignment = NSTextAlignmentCenter;
            break;
        case ContentAlignmentRight:
            self.detailTextLabel.textAlignment = NSTextAlignmentRight;
            break;
        case ContentAlignmentJustified:
            self.detailTextLabel.textAlignment = NSTextAlignmentJustified;
            break;
    }
}

- (void)setupCell
{
    CGSize titleSize = CGSizeZero;
    NSDictionary *titleAttrDict = @{ NSFontAttributeName:self.textLabel.font };
    if (self.titleWidth > 0) {
        titleSize = [self.textLabel.text boundingRectWithSize:CGSizeMake(self.titleWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:titleAttrDict context:nil].size;
    }else{
        titleSize = [self.textLabel.text sizeWithAttributes:titleAttrDict];
        self.titleWidth = titleSize.width;
    }
    self.titleSize = CGSizeMake(self.titleWidth, titleSize.height);
    
    CGFloat maxWidth = 0;
    if (!self.accessoryView && self.accessoryType == UITableViewCellAccessoryNone) {
        maxWidth = UI_SCREEN_WIDTH - 20 - kRatio_Scale_375(20) - self.space - self.titleWidth;
    }else{
        
        CGFloat accessoryViewW = 35;
        if (self.accessoryView) {
            accessoryViewW = 10 + 20 + self.accessoryView.width;
        }
        
        maxWidth = UI_SCREEN_WIDTH - accessoryViewW - kRatio_Scale_375(20) - self.space - self.titleWidth;
    }
    
    NSDictionary *contentAttrDict = @{NSFontAttributeName:self.detailTextLabel.font};
    CGSize acticalSize = [self.detailTextLabel.text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:contentAttrDict context:nil].size;
    
    CGFloat contenHeight = titleSize.height;
    self.contentTextSize = CGSizeMake(maxWidth, titleSize.height);
    self.contentMoreHeight = NO;
    if (acticalSize.height > titleSize.height) {
        contenHeight = acticalSize.height;
        self.contentTextSize = CGSizeMake(maxWidth, acticalSize.height);
        self.contentMoreHeight = YES;
    }
    
    CGFloat maxLineWidth = [self.detailTextLabel.text sizeWithAttributes:contentAttrDict].width;
    if (maxLineWidth > maxWidth) {
        self.detailTextLabel.textAlignment = NSTextAlignmentJustified;
    }else{
        self.detailTextLabel.textAlignment = NSTextAlignmentRight;
    }
    
    switch (self.contentAlignment) {
        case ContentAlignmentNoSet:
            
            break;
        case ContentAlignmentLeft:
            self.detailTextLabel.textAlignment = NSTextAlignmentLeft;
            break;
        case ContentAlignmentCenter:
            self.detailTextLabel.textAlignment = NSTextAlignmentCenter;
            break;
        case ContentAlignmentRight:
            self.detailTextLabel.textAlignment = NSTextAlignmentRight;
            break;
        case ContentAlignmentJustified:
            self.detailTextLabel.textAlignment = NSTextAlignmentJustified;
            break;
    }
    
    self.height = contenHeight + kRatio_Scale_375(20);
}


#pragma mark - setter/getter
#pragma mark title相关
- (void)setTitle:(NSString *)title
{
    _title = title;
    self.textLabel.text = title;
}

- (UIColor *)titleColor
{
    if (!_titleColor) {
        _titleColor = kFontColor_Dark;
    }
    return _titleColor;
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    self.textLabel.textColor = titleColor;
}

- (UIFont *)titleFont
{
    if (!_titleFont) {
        _titleFont = [UIFont systemFontOfSize:kRatio_Scale_375(15)];
    }
    return _titleFont;
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    self.textLabel.font = titleFont;
}

#pragma mark value相关
- (void)setValue:(NSString *)value
{
    _value = value;
    [self setDetailTextLb];
}

- (UIColor *)valueColor
{
    if (!_valueColor) {
        _valueColor = kFontColor_Dark;
    }
    return _valueColor;
}

- (void)setValueColor:(UIColor *)valueColor
{
    _valueColor = valueColor;
    [self setDetailTextLb];
}

- (UIFont *)valueFont
{
    if (!_valueFont) {
        _valueFont = [UIFont systemFontOfSize:kRatio_Scale_375(15)];
    }
    return _valueFont;
}

- (void)setValueFont:(UIFont *)valueFont
{
    _valueFont = valueFont;
    self.detailTextLabel.font = valueFont;
}

#pragma mark placeholder相关
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    [self setDetailTextLb];
}

- (UIColor *)placeholderColor
{
    if (!_placeholderColor) {
        _placeholderColor = kFontColor_Light;
    }
    return _placeholderColor;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setDetailTextLb];
}

- (void)setDetailTextLb
{
    if (self.value.length > 0) {
        self.detailTextLabel.text = self.value;
        self.detailTextLabel.textColor = self.valueColor;
    }else{
        self.detailTextLabel.text = self.placeholder;
        self.detailTextLabel.textColor = self.placeholderColor;
    }
}

@end




