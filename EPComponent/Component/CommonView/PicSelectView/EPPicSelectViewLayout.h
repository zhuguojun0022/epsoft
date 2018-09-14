//
//  EPPicSelectViewLayout.h
//  JuRongHRSS
//
//  Created by shi on 2018/1/17.
//  Copyright © 2018年 epsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EPPicSelectViewLayout : UICollectionViewFlowLayout

@property (assign, nonatomic) UIEdgeInsets margins;   //上下左右边距

@property (assign, nonatomic) CGFloat colSpace;   //列间距
@property (assign, nonatomic) CGFloat rowSpace;   //行间距
@property (assign, nonatomic) NSInteger colNums;    //一行放几列

@end
