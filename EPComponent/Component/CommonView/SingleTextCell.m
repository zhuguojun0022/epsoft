//
//  SingleTextCell.m
//  PingHuHRSS
//
//  Created by shi on 2017/8/3.
//  Copyright © 2017年 许芳芳. All rights reserved.
//

#import "SingleTextCell.h"

#import "UIColor+EP.h"
#import "UIImage+Extension.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "UIView+Frame.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SingleTextCell ()

@property (strong, nonatomic) UITextField *field;

@end

@implementation SingleTextCell

@synthesize placeholderColor=_placeholderColor;
@synthesize titleColor=_titleColor;
@synthesize valueColor=_valueColor;
@synthesize titleFont=_titleFont;
@synthesize valueFont=_valueFont;

+ (instancetype)createCellWithTableView:(UITableView *)tableView
{
    static NSString *cellId = @"SingleTextCellId";
    
    SingleTextCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[self class] alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UITextField *field = [[UITextField alloc] init];
        [field addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
        [self.contentView addSubview:field];
        self.field = field;
        
        field.clearButtonMode = UITextFieldViewModeWhileEditing;
        field.textColor = self.valueColor;
        field.font = self.valueFont;
        
        self.textLabel.numberOfLines = 0;
        self.textLabel.textColor = self.titleColor;
        self.textLabel.font = self.titleFont;
        
        self.space = kRatio_Scale_375(15);
        self.contentAlignment = ContentAlignmentNoSet;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.titleWidth > 0) {
        self.textLabel.frame = CGRectMake(self.textLabel.x, 0, self.titleWidth, self.height);
    }else{
        self.textLabel.y = 0;
        self.textLabel.height = self.height;
    }
    
    CGFloat fieldX = CGRectGetMaxX(self.textLabel.frame) + self.space;
    CGFloat fieldW;
    if (!self.accessoryView && self.accessoryType == UITableViewCellAccessoryNone) {
        fieldW = UI_SCREEN_WIDTH - 20 - fieldX;
    }else{
        CGFloat accessoryViewW = 35;
        if (self.accessoryView) {
            accessoryViewW = 10 + 20 + self.accessoryView.width;
        }
        
        fieldW = UI_SCREEN_WIDTH - accessoryViewW - fieldX;
    }
    
    self.field.frame = CGRectMake(fieldX, 0, fieldW, self.height);
    
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.accessoryType = UITableViewCellAccessoryNone;
    self.accessoryView = nil;
}

-(void)textChange:(UITextField *)textField
{
    if (self.textContentDidChange) {
        self.textContentDidChange(textField.text);
    }
}

#pragma mark - setter/getter

- (void)setCanEdit:(BOOL)canEdit
{
    _canEdit = canEdit;
    self.field.enabled = canEdit;
}

- (void)setContentAlignment:(ContentAlignment)contentAlignment
{
    _contentAlignment = contentAlignment;
    switch (contentAlignment) {
        case ContentAlignmentNoSet:
            
            break;
        case ContentAlignmentLeft:
            self.field.textAlignment = NSTextAlignmentLeft;
            break;
        case ContentAlignmentCenter:
            self.field.textAlignment = NSTextAlignmentCenter;
            break;
        case ContentAlignmentRight:
            self.field.textAlignment = NSTextAlignmentRight;
            break;
        case ContentAlignmentJustified:
            self.field.textAlignment = NSTextAlignmentJustified;
            break;
    }
}

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
    self.field.text = value;
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
    self.field.textColor = valueColor;
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
    self.field.font = valueFont;
    [self setDetailTextLb];
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
    NSMutableDictionary *attr = [[NSMutableDictionary alloc] init];
    attr[NSForegroundColorAttributeName] = self.placeholderColor;
    attr[NSFontAttributeName] = self.field.font;
    
    if (self.placeholder.length > 0) {
        NSAttributedString *placeholderStr = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attr];
        self.field.attributedPlaceholder = placeholderStr;
    }
}

@end







