//
//  EPPicSelectView.h
//  JuRongHRSS
//
//  Created by shi on 2018/1/16.
//  Copyright © 2018年 epsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EPPicSelectView : UIView

///最多显示图片的数量,默认为0即一张都不显示;
@property (assign, nonatomic) NSUInteger maxPicNums;

///是否可编辑(YES表示不可编辑,不能添加和删除,但可以点击查看, NO表示可以编辑)
@property (assign, nonatomic) BOOL nonEditable;

///要显示的图片数组
- (void)setdatas:(NSArray<UIImage *> *)datas;

///删除操作回调,delIdx删除的位置
@property (copy) void(^delHandleBlock)(NSInteger delIdx);
///增加操作回调,addIdx增加的位置
@property (copy) void(^addHandleBlock)(NSInteger addIdx);
///点击操作回调,tapIdx点击的位置
@property (copy) void(^tapHandleBlock)(NSInteger tapIdx);

/**
 根据EPPicSelectView的宽高计算出高度
 @param viewWidth EPPicSelectView的宽度
 @return EPPicSelectView的高度
 */
- (CGFloat)heightForPicSelectViewWithWidth:(CGFloat)viewWidth;

@end
