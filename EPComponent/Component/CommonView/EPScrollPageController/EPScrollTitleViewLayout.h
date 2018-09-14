//
//  EPScrollTitleViewLayout.h
//  EPStandardizationAPP
//
//  Created by shi on 2017/11/27.
//  Copyright © 2017年 epsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol EPScrollTitleViewLayoutDelegate;

@interface EPScrollTitleViewLayout : UICollectionViewLayout
/**
 标题之间的间隔
 */
@property (assign, nonatomic) CGFloat space;

/**
 代理对象,使用EPScrollTitleViewLayout的类必须要实现该对象
 */
@property (weak, nonatomic) id<EPScrollTitleViewLayoutDelegate>delegate;

/**
 返回所有标题项的Frame
 */
- (NSMutableArray<NSValue *> *)itemViewFrame;

@end


@protocol EPScrollTitleViewLayoutDelegate <NSObject>
/**
 EPScrollTitleViewLayout通过该方法来获取cell的大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndex:(NSInteger)index;

@end
