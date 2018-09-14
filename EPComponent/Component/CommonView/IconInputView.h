//
//  IconInputView.h
//  HRSS
//
//  Created by shi on 2017/4/13.
//  Copyright © 2017年 epsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonMacro.h"

@interface IconInputView : UIView

@property (strong, nonatomic, readonly) UIImageView *iconView;

@property (strong, nonatomic, readonly) UITextField *inputField;

- (instancetype)initWithFrame:(CGRect)frame iconSize:(CGSize)size space:(NSUInteger)space;

@end
