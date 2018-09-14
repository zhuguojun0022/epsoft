//
//  EPTextView.h
//  PingHuHRSS
//
//  Created by shi on 2017/8/8.
//  Copyright © 2017年 许芳芳. All rights reserved.
//
//  带有palceholder的TextView

#import <UIKit/UIKit.h>

@interface EPTextView : UITextView

@property (strong, nonatomic) NSString *placeholder;

@property (strong, nonatomic) UIColor *placeholderColor;

@end
