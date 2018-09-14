//
//  EpAlertView.m
//  zs_gjj
//
//  Created by shi on 2017/6/22.
//  Copyright © 2017年 epsoft. All rights reserved.
//

#import "EpAlertView.h"

#import "UIColor+EP.h"
#import "UIImage+Extension.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "UIView+Frame.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface EpAlertView ()

@property (strong, nonatomic) UILabel *titleLb;

@property (strong, nonatomic) UILabel *contentLb;

@property (strong, nonatomic) UIButton *cancleBtn;

@property (strong, nonatomic) UIButton *confirmBtn;

@property (strong, nonatomic) UIView *containerView;

@property (strong, nonatomic) UIView *titleToContentline;

@property (strong, nonatomic) UIView *buttonToContentline;

@property (strong, nonatomic) UIView *buttonToButtonline;

@property (copy) void(^tapCallback)(NSString *btnTitle);

@end

@implementation EpAlertView

+ (EpAlertView *)showAlertViewAndHideCancle:(BOOL)hideCancle
                            WithTapCallback:(void(^)(NSString *buttonTitle))tapCallback
{
    UIWindow *wd = [[UIApplication sharedApplication].delegate window];
    
    EpAlertView *alertView = [[EpAlertView alloc] initWithFrame:wd.bounds hideCancle:hideCancle];
    alertView.tapCallback = tapCallback;
    [wd addSubview:alertView];
    return alertView;
}

- (instancetype)initWithFrame:(CGRect)frame hideCancle:(BOOL)hideCancle
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
        titleLb.font = Font_Scale_375(17);
        titleLb.textColor = kThemeColor;
        [containerView addSubview:titleLb];
        self.titleLb = titleLb;
        
        UILabel *contentLb = [[UILabel alloc] init];
        contentLb.numberOfLines = 0;
        contentLb.font = Font_Scale_375(15);
        contentLb.textColor = kFontColor_Light;
        [containerView addSubview:contentLb];
        self.contentLb = contentLb;
        
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
        confirmBtn.backgroundColor = kThemeColor;
        [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [confirmBtn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        [containerView addSubview:confirmBtn];
        self.confirmBtn = confirmBtn;
        
        UIView *buttonToContentline = [[UIView alloc] init];
        buttonToContentline.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
        [containerView addSubview:buttonToContentline];
        self.buttonToContentline = buttonToContentline;
        
        UIView *titleToContentline = [[UIView alloc] init];
        titleToContentline.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
        [containerView addSubview:titleToContentline];
        self.titleToContentline = titleToContentline;
        
        UIView *buttonToButtonline = [[UIView alloc] init];
        buttonToButtonline.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
        [containerView addSubview:buttonToButtonline];
        self.buttonToButtonline = buttonToButtonline;
        
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.containerView).offset(kRatio_Scale_375(20));
            make.right.equalTo(self.containerView).offset(kRatio_Scale_375(-20));
            make.top.equalTo(self.containerView).offset(kRatio_Scale_375(20));
        }];
        
        [self.contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.containerView).offset(kRatio_Scale_375(20));
            make.right.equalTo(self.containerView).offset(kRatio_Scale_375(-20));
            make.top.equalTo(self.titleLb.mas_bottom).offset(kRatio_Scale_375(10));
        }];
        
        if (hideCancle) {
            [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentLb.mas_bottom).offset(kRatio_Scale_375(20));
                make.bottom.equalTo(self.containerView);
                make.left.equalTo(self.containerView);
                make.right.equalTo(self.containerView);
                make.height.equalTo(@(kRatio_Scale_375(40)));
            }];
        }else{
            [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentLb.mas_bottom).offset(kRatio_Scale_375(20));
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
        }
        
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


//返回方法被点击
- (void)tapAction:(UIButton *)sender
{
    if (self.tapCallback) {
        self.tapCallback(sender.currentTitle);
    }
    
    [self removeFromSuperview];
}


@end











