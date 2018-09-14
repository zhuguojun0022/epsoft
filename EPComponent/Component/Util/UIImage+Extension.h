//
//  UIImage+Extension.h
//  HRSS
//
//  Created by zhu guojun on 2017/4/8.
//  Copyright © 2017年 epsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/** 保持原始色彩*/
+(UIImage *)imageWithRenderingModeOriginal:(NSString *)imageName;
/** 设置一张有颜色的图片*/
+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height;

-(UIImage *)scaleImageToSize:(CGSize)size;
-(UIImage *)scaleImageToSize:(CGSize)size scale:(CGFloat)scale;

@end
