//
//  EPMenuViewPageLayout.h
//  DongYangHRSS
//
//  Created by shi on 2017/11/20.
//  Copyright © 2017年 epsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EPMenuViewPageLayout : UICollectionViewLayout
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

@end
