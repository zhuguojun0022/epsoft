//
//  EPScrollPageController.h
//  EPStandardizationAPP
//
//  Created by shi on 2017/11/26.
//  Copyright © 2017年 epsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EPScrollPageController : UIViewController

///需要显示的控制器数组(注意:必须要设置title属性)
@property (strong, nonatomic) NSArray<UIViewController *> *pageViewControllers;

///顶部滚动的标题栏左侧视图,用来显示一些额外的视图
@property (strong, nonatomic) UIView *leftView;
///左侧视图宽度
@property (assign, nonatomic) CGFloat leftWidth;
///顶部滚动的标题栏右侧视图,用来显示一些额外的视图
@property (strong, nonatomic) UIView *rightView;
///右侧视图宽度
@property (assign, nonatomic) CGFloat rightWidth;

///标题栏视图高度
@property (assign, nonatomic) CGFloat titleViewHeight;

///未选中时候的标题颜色
@property (strong, nonatomic) UIColor *titleColor;
///选中时候的标题颜色
@property (strong, nonatomic) UIColor *selectedTitleColor;
///未选中时候的标题字体
@property (strong, nonatomic) UIFont *titleFont;
///选中时候的标题字体
@property (strong, nonatomic) UIFont *selectedTitleFont;
/**指示条颜色*/
@property (strong, nonatomic) UIColor *bottomLineColor;
/**指示条高度, 默认高度 3.0f*/
@property (assign, nonatomic) CGFloat bottomLineHeight;

/**
 更新数据,设置完成视图数据后要调用该方法
 (注意:只更新pageViewController和标题视图,右侧视图不更新,如果需要更新右侧视图,请设置rightView属性)
 */
- (void)updateDatas;

@end
