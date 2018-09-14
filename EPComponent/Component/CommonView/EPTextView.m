//
//  EPTextView.m
//  PingHuHRSS
//
//  Created by shi on 2017/8/8.
//  Copyright © 2017年 许芳芳. All rights reserved.
//

#import "EPTextView.h"

@interface EPTextView ()

@property (strong, nonatomic) UILabel *placeholderLb;

@end

@implementation EPTextView

@synthesize placeholderColor = _placeholderColor;

#pragma mark - 父类方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.placeholderLb.frame = CGRectMake(5, 8, self.bounds.size.width - 10, 0);
    [self.placeholderLb sizeToFit];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    if (text.length > 0) {
        self.placeholderLb.hidden = YES;
    }else{
        self.placeholderLb.hidden = NO;
    }
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    if (attributedText.length > 0) {
        self.placeholderLb.hidden = YES;
    }else{
        self.placeholderLb.hidden = NO;
    }
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLb.font = font;
    [self.placeholderLb sizeToFit];
}

#pragma mark - setter/getter

- (UILabel *)placeholderLb
{
    if (!_placeholderLb) {
        _placeholderLb = [[UILabel alloc]init];
        _placeholderLb.textColor = self.placeholderColor;
        _placeholderLb.font = [UIFont systemFontOfSize:15];
        _placeholderLb.numberOfLines = 0;
        [self addSubview:_placeholderLb];
    }
    return _placeholderLb;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    self.placeholderLb.text = placeholder;
    [self.placeholderLb sizeToFit];
}

- (UIColor *)placeholderColor
{
    if (!_placeholderColor) {
        _placeholderColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0f];
    }
    return _placeholderColor;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.placeholderLb.textColor = placeholderColor;
}

#pragma mark - 通知事件方法
- (void)textDidChange:(NSNotification *)notification
{
    if (self.text.length > 0) {
        self.placeholderLb.hidden = YES;
    }else{
        self.placeholderLb.hidden = NO;
    }
}

@end
