//
//  TopImageButton.h
//  HRSS
//
//  Created by shi on 2017/4/10.
//  Copyright © 2017年 epsoft. All rights reserved.
//
// 图片在上,文字在下的按钮

#import <UIKit/UIKit.h>
#import "CommonMacro.h"


@interface TopImageButton : UIButton

@property (assign, nonatomic) CGSize imageSize;

@property (assign, nonatomic) CGFloat space;

//@property (strong, nonatomic) NSDictionary *dataDict;

@end
