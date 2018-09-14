//
//  LoopImageView.h
//  HRSS
//
//  Created by shi on 2017/4/10.
//  Copyright © 2017年 epsoft. All rights reserved.
//
//  轮播图视图

#import <UIKit/UIKit.h>

@interface LoopImageView : UIView

///显示的图片
@property(strong, nonatomic) NSArray<UIImage *> *images;

///显示图片的url
@property(strong, nonatomic) NSArray<NSURL *> *imageUrls;

///显示图片的名字
@property(strong, nonatomic) NSArray<NSString *> *imageNames;

/**
 *  点击图片后的回调，idx 点击图片的位置
 */
@property (copy)void(^tapImageCallback)(NSInteger idx);

/**
 *  移除定时器, 在需要释放LoopImageView的时候，要调用该方法来停止定时器，防止内存泄露
 */
-(void)removetimer;

@end

