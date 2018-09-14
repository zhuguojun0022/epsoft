//
//  UIColor+JuRong.h
//  JuRongHRSS
//
//  Created by shi on 2017/9/7.
//  Copyright © 2017年 epsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (EP)

//颜色
+(UIColor *) colorWithHexString: (NSString *)stringToConvert;

+(UIColor *) colorWithHexString: (NSString *) stringToConvert alpha:(CGFloat)alpha;

///随机颜色,主要用于调试
+ (UIColor *)randomColor;

@end
