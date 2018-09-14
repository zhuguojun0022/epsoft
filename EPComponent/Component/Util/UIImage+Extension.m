//
//  UIImage+Extension.m
//  HRSS
//
//  Created by zhu guojun on 2017/4/8.
//  Copyright © 2017年 epsoft. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

/** 设置保持原始色彩*/
+(UIImage *)imageWithRenderingModeOriginal:(NSString *)imageName{
    return [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


+ (UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    
    // create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

-(UIImage *)scaleImageToSize:(CGSize)size
{
    UIImage *img = [self scaleImageToSize:size scale:[UIScreen mainScreen].scale];
    return img;
}

-(UIImage *)scaleImageToSize:(CGSize)size scale:(CGFloat)scale
{
    CGFloat scaleW = size.width/self.size.width;
    CGFloat scaleH = size.height/self.size.height;
    
    CGFloat finalScale;
    if (scaleW > scaleH) {
        finalScale = scaleW;
    }else{
        finalScale = scaleH;
    }
    
    CGFloat finalW = self.size.width *finalScale;
    CGFloat finalH = self.size.height *finalScale;
    CGRect finalRect;
    if (scaleW < scaleH) {
        finalRect = CGRectMake((size.width - finalW)/2, 0, finalW, finalH);
    }else{
        finalRect = CGRectMake(0, (size.height - finalH)/2, finalW, finalH);
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    [self drawInRect:finalRect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}


@end

