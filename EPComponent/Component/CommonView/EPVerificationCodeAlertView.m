//
//  EPVerificationCodeAlertView.m
//  JuRongHRSS
//
//  Created by shi on 2017/9/25.
//  Copyright © 2017年 epsoft. All rights reserved.
//

#import "EPVerificationCodeAlertView.h"
#import "CommonMacro.h"

#import "UIColor+EP.h"
#import "UIImage+Extension.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "UIView+Frame.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface EPVerificationCodeAlertView ()

@property (strong, nonatomic) UILabel *titleLb;

@property (strong, nonatomic) UITextField *verifCodeField;

@property (strong, nonatomic) UIButton *getVerifCodeBtn;

@property (strong, nonatomic) UIButton *cancleBtn;

@property (strong, nonatomic) UIButton *confirmBtn;

@property (strong, nonatomic) UIView *containerView;

@property (strong, nonatomic) UIView *buttonToContentline;

@property (strong, nonatomic) UIView *buttonToButtonline;

@property (copy) void(^tapCallback)(NSString *btnTitle);

@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) NSInteger totalSeconds;     //到计时秒数

@end

@implementation EPVerificationCodeAlertView

+ (EPVerificationCodeAlertView *)showVerificationCodeViewWithTapCallback:(void(^)(NSString *buttonTitle))tapCallback
{
    UIWindow *wd = [[UIApplication sharedApplication].delegate window];
    
    EPVerificationCodeAlertView *alertView = [[EPVerificationCodeAlertView alloc] initWithFrame:wd.bounds];
    alertView.tapCallback = tapCallback;
    [wd addSubview:alertView];
    return alertView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3f];
        
        UIView *containerView = [[UIView alloc] init];
        containerView.layer.cornerRadius = 7.0f;
        containerView.clipsToBounds = YES;
        containerView.backgroundColor = [UIColor whiteColor];
        containerView.layer.cornerRadius = 5.0f;
        self.containerView = containerView;
        [self addSubview:containerView];
        
        UILabel *titleLb = [[UILabel alloc] init];
        titleLb.font = Font_Scale_375(15);
        titleLb.textColor = kFontColor_Dark;
        [containerView addSubview:titleLb];
        self.titleLb = titleLb;
        
        UITextField *verifCodeField = [[UITextField alloc] init];
        verifCodeField.borderStyle = UITextBorderStyleRoundedRect;
        verifCodeField.textColor = kFontColor_Dark;
        verifCodeField.font = Font_Scale_375(14);
        verifCodeField.placeholder = @"请输入验证码";
        [containerView addSubview:verifCodeField];
        self.verifCodeField = verifCodeField;
        
        UIButton *getVerifCodeBtn = [[UIButton alloc] init];
        getVerifCodeBtn.titleLabel.font = Font_Scale_375(14);
        getVerifCodeBtn.backgroundColor = [UIColor whiteColor];
        [getVerifCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [getVerifCodeBtn setTitleColor:kThemeColor forState:UIControlStateNormal];
        [getVerifCodeBtn setTitleColor:kFontColor_Light forState:UIControlStateDisabled];
        [getVerifCodeBtn addTarget:self action:@selector(getVerifyCodeAction:) forControlEvents:UIControlEventTouchUpInside];
        [containerView addSubview:getVerifCodeBtn];
        self.getVerifCodeBtn = getVerifCodeBtn;

        UIButton *cancleBtn = [[UIButton alloc] init];
        cancleBtn.titleLabel.font = Font_Scale_375(17);
        cancleBtn.backgroundColor = [UIColor whiteColor];
        [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancleBtn setTitleColor:kThemeColor forState:UIControlStateNormal];
        [cancleBtn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        [containerView addSubview:cancleBtn];
        self.cancleBtn = cancleBtn;
        
        UIButton *confirmBtn = [[UIButton alloc] init];
        confirmBtn.titleLabel.font = Font_Scale_375(17);
        [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        [confirmBtn setTitleColor:kThemeColor forState:UIControlStateNormal];
        [confirmBtn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        [containerView addSubview:confirmBtn];
        self.confirmBtn = confirmBtn;
        
        UIView *buttonToContentline = [[UIView alloc] init];
        buttonToContentline.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
        [containerView addSubview:buttonToContentline];
        self.buttonToContentline = buttonToContentline;
        
        UIView *buttonToButtonline = [[UIView alloc] init];
        buttonToButtonline.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
        [containerView addSubview:buttonToButtonline];
        self.buttonToButtonline = buttonToButtonline;
        
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.containerView).offset(kRatio_Scale_375(20));
            make.right.equalTo(self.containerView).offset(kRatio_Scale_375(-20));
            make.top.equalTo(self.containerView).offset(kRatio_Scale_375(20));
        }];
        
        [self.verifCodeField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLb.mas_left);
            make.top.equalTo(self.titleLb.mas_bottom).offset(kRatio_Scale_375(20));
            make.height.equalTo(@(kRatio_Scale_375(32)));
        }];
        
        [self.getVerifCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.verifCodeField.mas_right).offset(kRatio_Scale_375(10));
            make.centerY.equalTo(self.verifCodeField.mas_centerY);
            make.height.equalTo(self.verifCodeField);
            make.right.equalTo(self.titleLb.mas_right);
            make.width.equalTo(@(kRatio_Scale_375(110)));
        }];
        
        [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.verifCodeField.mas_bottom).offset(kRatio_Scale_375(20));
            make.bottom.equalTo(self.containerView);
            make.left.equalTo(self.containerView);
            make.right.equalTo(self.confirmBtn.mas_left);
            make.height.equalTo(@(kRatio_Scale_375(40)));
            make.width.equalTo(self.confirmBtn.mas_width);
            make.height.equalTo(self.confirmBtn.mas_height);
        }];
        
        [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.containerView);
            make.centerY.equalTo(self.cancleBtn);
        }];
        
        [self.buttonToButtonline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.confirmBtn.mas_left);
            make.top.equalTo(self.confirmBtn.mas_top);
            make.width.equalTo(@(0.5));
            make.height.equalTo(self.confirmBtn.mas_height);
        }];
        
        [self.buttonToContentline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.containerView);
            make.left.equalTo(self.containerView);
            make.height.equalTo(@(0.5));
            make.top.equalTo(self.confirmBtn.mas_top);
        }];
        
        [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.equalTo(self.mas_width).multipliedBy(0.8);
        }];
    }
    
    return self;
}

- (void)tapAction:(UIButton *)sender
{
    if (self.tapCallback) {
        self.tapCallback(sender.currentTitle);
    }
    
    [self removeFromSuperview];
}

/**
 *  获取验证码
 */
- (void)getVerifyCodeAction:(UIButton *)sender
{
    [self startCountDown];
    
}

#pragma mark - 到计时相关
- (void)startCountDown
{
    [self stopCountDown];
    
    self.getVerifCodeBtn.enabled = NO;
    self.totalSeconds = 60;
    NSString *title = [NSString stringWithFormat:@"（%d）重新发送",(int)self.totalSeconds];
    [self.getVerifCodeBtn setTitle:title forState:UIControlStateNormal];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(changeSeconds) userInfo:nil repeats:YES];
}

- (void)stopCountDown
{
    if ([self.timer isValid]) {
        [self.timer invalidate];
    }
    
    self.timer = nil;
}

- (void)changeSeconds
{
    self.totalSeconds--;
    
    if (self.totalSeconds < 0) {
        [self stopCountDown];
        [self.getVerifCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
        self.getVerifCodeBtn.enabled = YES;
        return;
    }
    NSString *title = [NSString stringWithFormat:@"（%d）重新发送",(int)self.totalSeconds];
    [self.getVerifCodeBtn setTitle:title forState:UIControlStateNormal];
}

@end



