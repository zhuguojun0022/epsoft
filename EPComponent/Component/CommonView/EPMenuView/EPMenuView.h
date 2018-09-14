//
//  EPMenuView.h
//  DongYangHRSS
//
//  Created by shi on 2017/11/20.
//  Copyright © 2017年 epsoft. All rights reserved.
//
//  用于上图下标题的菜单列表的显示

#import <UIKit/UIKit.h>

///指示器的高度。默认情况下，指示器覆盖在EPMenuView上方，会遮住选项，可以通过把EPMenuView的margin属性的bottom为indicatorHeight来给指示器留出高度。如：UIEdgeInsetsMake(0, 0, indicatorHeight, 0)
extern CGFloat const indicatorHeight;

@interface EPMenuItem : NSObject

@property (strong, nonatomic) NSString *title;

//下面三个属性使用的优先级: picName > picImage > picURL
@property (strong, nonatomic) NSString *picName;
@property (strong, nonatomic) UIImage *picImage;
@property (strong, nonatomic) NSURL *picURL;

///占位图片
@property (strong, nonatomic) NSString *placeholderPic;
///选项对应的数据(可选，可通过该字段来携带额外的信息，如title=汉族，extraObj=001 )
@property (strong, nonatomic) id extraObj;

@end


@interface EPMenuView : UIView
//--------------对整个MenuView的布局进行设置----------
///一页有几行
@property (assign, nonatomic) NSInteger rowNum;
///一页有几列
@property (assign, nonatomic) NSInteger colNum;
///页内的上下左右四个边距
@property (assign, nonatomic) UIEdgeInsets margin;
///行间距
@property (assign, nonatomic) CGFloat rowSpace;
///列间距
@property (assign, nonatomic) CGFloat colSpace;
///背景颜色
@property (strong, nonatomic) UIColor *menuViewBackgroundColor;

//--------------指示器颜色----------
///指示器当前页颜色
@property (strong, nonatomic) UIColor *indicatorColor;
///指示器其他页颜色
@property (strong, nonatomic) UIColor *indicatorOtherColor;
///指示器背景颜色
@property (strong, nonatomic) UIColor *indicatorBackgroundColor;

//--------------对MenuView内部的MenuItemView的布局进行设置----------
///标题字体
@property (strong, nonatomic) UIFont *titleFont;
///标题颜色
@property (strong, nonatomic) UIColor *titleColor;
///图标大小
@property (assign, nonatomic) CGSize iconSize;
///图标与标题之间的间隔
@property (assign, nonatomic) CGFloat iconTitleSpace;

///数据源
@property (strong, nonatomic) NSArray<EPMenuItem *> *menuViewDatas;

@property (copy)void(^tapItemCompletionHandler)(EPMenuItem *tappedItem,NSInteger idx);

///数据源和布局属性设置完成后要调用该方法重新布局计算(!!!!重要!!!!)
- (void)layoutUI;

///调用该方法可以获取EPMenuView实际的高度，但要先调用layoutUI进行布局计算
- (CGFloat)heightOfMenuView;

@end





