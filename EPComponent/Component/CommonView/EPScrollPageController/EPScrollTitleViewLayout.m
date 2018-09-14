//
//  EPScrollTitleViewLayout.m
//  EPStandardizationAPP
//
//  Created by shi on 2017/11/27.
//  Copyright © 2017年 epsoft. All rights reserved.
//

#import "EPScrollTitleViewLayout.h"

#define kMargin 10

@interface EPScrollTitleViewLayout ()

@property (strong, nonatomic) NSMutableArray<NSValue *> *itemFrames;   //所有title的Frame
@property (assign, nonatomic) NSInteger total;          //title总条数
@property (assign, nonatomic) CGSize contentSize;     //contentSize

@end

@implementation EPScrollTitleViewLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    self.total = [self.collectionView numberOfItemsInSection:0];
    self.itemFrames = [[NSMutableArray alloc] init];
    
    CGFloat collectionViewHeight = self.collectionView.bounds.size.height;

    CGFloat contentSizeWidth = 0;
    CGRect preItemFrame = CGRectZero;
    for (int i = 0; i < self.total; i++) {
        CGSize itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndex:i];
        CGRect frame = CGRectZero;
        if (i == 0) {
            frame = CGRectMake(kMargin, (collectionViewHeight - itemSize.height) / 2, itemSize.width, itemSize.height);
        }else{
            frame = CGRectMake(CGRectGetMaxX(preItemFrame) + self.space, (collectionViewHeight - itemSize.height) / 2, itemSize.width, self.collectionView.bounds.size.height);
        }
        
        [self.itemFrames addObject:[NSValue valueWithCGRect:frame]];
        preItemFrame = frame;
    }
    
    contentSizeWidth += CGRectGetMaxX(preItemFrame) + kMargin;
    self.contentSize = CGSizeMake(contentSizeWidth, self.collectionView.bounds.size.height);
}

- (CGSize)collectionViewContentSize
{
    return self.contentSize;
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray* attributes = [NSMutableArray array];
    for (int i = 0; i < self.total; i++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    
    return attributes;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGRect frame = [self.itemFrames[indexPath.row] CGRectValue];
    attr.frame = frame;
    return attr;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

/**
 返回所有标题项的Frame
 */
- (NSMutableArray<NSValue *> *)itemViewFrame
{
    return self.itemFrames;
}

@end




