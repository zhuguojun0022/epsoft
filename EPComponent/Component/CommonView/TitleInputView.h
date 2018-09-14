//
//  TitleInputView.h
//  HRSS
//
//  Created by shi on 2017/4/12.
//  Copyright © 2017年 epsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonMacro.h"

@interface TitleInputView : UIView

@property (strong, nonatomic, readonly) UILabel *titleLb;

@property (strong, nonatomic, readonly) UITextField *inputField;

- (instancetype)initWithFrame:(CGRect)frame titleWidth:(NSUInteger)width space:(NSUInteger)space;

@end
