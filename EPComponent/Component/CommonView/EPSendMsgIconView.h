//
//  EPSendMsgIconView.h
//  PingHuHRSS
//
//  Created by zhu guojun on 2018/1/5.
//  Copyright © 2018年 许芳芳. All rights reserved.
//  发送短信验证码

#import <UIKit/UIKit.h>
#import "CommonMacro.h"

@interface EPSendMsgIconView : UIView

@property (nonatomic,assign) BOOL showButtonBorderColor;//显示按钮外框

@property (copy,nonatomic) BOOL(^sendButtonClicked)(void);//按钮被点击

@end
