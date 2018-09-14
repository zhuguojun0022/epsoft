//
//  CommonMacro.h
//  JuRongHRSS
//
//  Created by shi on 2017/9/27.
//  Copyright © 2017年 epsoft. All rights reserved.
//


#ifndef CommonMacro_h
#define CommonMacro_h

//弱指针
#define WeakSelf(ws) __weak __typeof(&*self)weakSelf = self


//屏幕宽高
#define UI_SCREEN_WIDTH   ([[UIScreen mainScreen] bounds].size.width)
#define UI_SCREEN_HEIGHT  ([[UIScreen mainScreen] bounds].size.height)

//屏幕宽度相对iPhone6屏幕宽度的比例
#define kWidth_Scale_375    ([UIScreen mainScreen].bounds.size.width/375.0f)
//屏幕宽度相对iPhone6屏幕宽度的比例计算函数
#define kRatio_Scale_375(Scale) (kWidth_Scale_375 * Scale)




//字体设置
//#define kFont_Name_HeiTi @"Heiti SC"
//#define FONT(x) [UIFont fontWithName:kFont_Name_HeiTi size:x]
//#define FONT(x) [UIFont systemFontOfSize:x]
#define Font_Scale_375(a)  [UIFont systemFontOfSize:kRatio_Scale_375(a)]

//主题颜色
#define kThemeColor [UIColor colorWithHexString:@"#3399FF"]
//视图控制器背景颜色
#define kViewControllerBkColor [UIColor colorWithHexString:@"#f4f4f4"]
//字体颜色
#define kFontColor_Dark   [UIColor colorWithHexString:@"#333333"]     //黑
#define kFontColor_Gray   [UIColor colorWithHexString:@"#666666"]     //灰
#define kFontColor_Light  [UIColor colorWithHexString:@"#999999"]    //浅灰

#define kInpub_bgLineColor  [UIColor colorWithHexString:@"#CACACA"]    //输入框背景色

#define kFontColor_Light2 [UIColor colorWithHexString:@"888888"] //浅灰2
//分割线颜色
#define kSplitLineColor   [UIColor colorWithHexString:@"#d9d9d9"]

//点击查看更多文字颜色
#define kShowMoreColor [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0]

#define kLineColor [UIColor colorWithHexString:@"DFDFDF"]

//人社地图详情页标题文字颜色
#define kMapDetailTitleColor [UIColor colorWithHexString:@"353535"]



#endif /* CommonMacro_h */







