//
//  EPVerificationCodeAlertView.h
//  JuRongHRSS
//
//  Created by shi on 2017/9/25.
//  Copyright © 2017年 epsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EPVerificationCodeAlertView : UIView

@property (strong, nonatomic, readonly) UILabel *titleLb;       //标题label

@property (strong, nonatomic, readonly) UIButton *cancleBtn;    //确认按钮，hideCancle 为yes，则不显示cancleBtn

@property (strong, nonatomic, readonly) UIButton *confirmBtn;   //取消按钮

+ (EPVerificationCodeAlertView *)showVerificationCodeViewWithTapCallback:(void(^)(NSString *buttonTitle))tapCallback;

@end
