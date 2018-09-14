//
//  EpAlertView.h
//  zs_gjj
//
//  Created by shi on 2017/6/22.
//  Copyright © 2017年 epsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonMacro.h"

@interface EpAlertView : UIView

@property (strong, nonatomic, readonly) UILabel *titleLb;       //标题label

@property (strong, nonatomic, readonly) UILabel *contentLb;     //内容label

@property (strong, nonatomic, readonly) UIButton *cancleBtn;    //确认按钮，hideCancle 为yes，则不显示cancleBtn

@property (strong, nonatomic, readonly) UIButton *confirmBtn;   //取消按钮

+ (EpAlertView *)showAlertViewAndHideCancle:(BOOL)hideCancle
                            WithTapCallback:(void(^)(NSString *buttonTitle))tapCallback;

@end


//EpAlertView *alertView = [EpAlertView showAlertViewAndHideCancle:YES WithTapCallback:^(NSString *buttonTitle) {
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}];
//alertView.contentLb.text = @"本人签约完成，待配偶 张三\n（331919********212）同意协议";
//alertView.contentLb.text = @"签约完成，公积金中心将在1-2个工作日内进行审核\n\n如何疑问，请咨询12329";
