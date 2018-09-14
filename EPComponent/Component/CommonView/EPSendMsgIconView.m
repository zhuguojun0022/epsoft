//
//  EPSendMsgIconView.m
//  PingHuHRSS
//
//  Created by zhu guojun on 2018/1/5.
//  Copyright © 2018年 许芳芳. All rights reserved.
//

#import "EPSendMsgIconView.h"

#import "UIColor+EP.h"
#import "UIImage+Extension.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "UIView+Frame.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define kFont [UIFont systemFontOfSize:15]
#define kButtonDefaultTitle @"获取验证码"

@interface EPSendMsgIconView ()

@property (strong, nonatomic) UIButton *button;

@property (nonatomic,strong) NSTimer  *timeInterval;

@property (nonatomic,assign) NSInteger remainSeconds;//剩下秒数

@end

@implementation EPSendMsgIconView

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _button.titleLabel.font = kFont;
        [_button setTitle:kButtonDefaultTitle forState:UIControlStateNormal];
        [self addSubview:_button];
        
        [self setButtonColor];
        
        WeakSelf(weakSelf);
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(weakSelf);
        }];
        
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];

    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _button.titleLabel.font = kFont;
    [_button setTitle:kButtonDefaultTitle forState:UIControlStateNormal];
    [self addSubview:_button];
    
    [self setButtonColor];
    
    WeakSelf(weakSelf);
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(weakSelf);
    }];
    
}

- (void)buttonClicked:(id)sender{    
    if (self.sendButtonClicked) {
        BOOL isReady = self.sendButtonClicked();
        if (isReady) {
            _remainSeconds = 59;
            _button.enabled = NO;
            UIColor *useColor = [UIColor colorWithHexString:@"#cacaca"];
            _button.backgroundColor = useColor;
            NSString *buttonTitle = [NSString stringWithFormat:@"%li",_remainSeconds];
            [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _button.layer.borderColor = useColor.CGColor;
            [_button setTitle:buttonTitle forState:UIControlStateNormal];
            self.timeInterval = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateButtonTitle) userInfo:nil repeats:YES];
        }
    }
}

//更新钮标题
- (void)updateButtonTitle{
    _remainSeconds = _remainSeconds-1;
    
    NSString *buttonTitle = [NSString stringWithFormat:@"%li",_remainSeconds];
    [_button setTitle:buttonTitle forState:UIControlStateNormal];
    
    if (_remainSeconds == 0) {
        [self.timeInterval invalidate];
        self.timeInterval = nil;
        _button.enabled = YES;
        _button.backgroundColor = [UIColor clearColor];
        [self setButtonColor];
        [_button setTitle:kButtonDefaultTitle forState:UIControlStateNormal];
    }
}

- (void)setButtonColor{
    UIColor *useColor = kThemeColor;
    [_button setTitleColor:useColor forState:UIControlStateNormal];
    
    if (_showButtonBorderColor) {
        _button.layer.cornerRadius = 4.0;
        _button.layer.borderWidth = 1;
        _button.layer.borderColor = useColor.CGColor;
    }
}

- (void)dealloc{
    NSLog(@"dealloc .....");
    if (self.timeInterval) {
        NSLog(@"set timeInterval to nil .....");
        [self.timeInterval invalidate];
        self.timeInterval = nil;
    }
}

@end
