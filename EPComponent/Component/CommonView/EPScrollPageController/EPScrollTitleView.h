//
//  EPScrollTitleView.h
//  EPStandardizationAPP
//
//  Created by shi on 2017/11/26.
//  Copyright © 2017年 epsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EPScrollTitleView : UIView
/**
 要显示的标题数组
 */
@property (strong, nonatomic) NSMutableArray<NSString *> *titles;

/**未选中时候的标题颜色*/
@property (strong, nonatomic) UIColor *titleColor;
/**选中时候的标题颜色*/
@property (strong, nonatomic) UIColor *selectedTitleColor;
/**未选中时候的标题字体*/
@property (strong, nonatomic) UIFont *titleFont;
/**选中时候的标题字体*/
@property (strong, nonatomic) UIFont *selectedTitleFont;

/**指示条颜色*/
@property (strong, nonatomic) UIColor *bottomLineColor;
/**指示条高度*/
@property (assign, nonatomic) CGFloat bottomLineHeight;

/**
 点击标题后的回调,tappedIdx:被点击标题的位置
 */
@property (copy) void(^tapTitleCallback)(NSInteger tappedIdx);

/**
 滚动到指定的标题
 @param index 标题位置
 */
- (void)scrollTitleToIndex:(NSInteger)index;

/**
 滚动底部指示条到指定的位置
 @param index 标题位置
 */
- (void)scrollBottomLineToIndex:(NSInteger)index;

@end
