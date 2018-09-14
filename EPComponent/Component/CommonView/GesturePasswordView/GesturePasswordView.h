//
//  GesturePasswordView.h
//  HRSS
//
//  Created by shi on 2017/5/2.
//  Copyright © 2017年 epsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonMacro.h"

@interface GesturePasswordView : UIView
///重置界面为初始状态
@property (assign, nonatomic) BOOL reset;
///设置界面为错误状态
@property (assign, nonatomic, getter=isPwdError) BOOL pwdError;
///密码输入完成后回调,每次手势输入完成后界面会被锁定,不允许再次输入,需要进行重置,设置reset为YES表示重置界面,重置后可以重新输入
@property (copy) void(^setPasswordCallback)(NSString *pwd);

@end
