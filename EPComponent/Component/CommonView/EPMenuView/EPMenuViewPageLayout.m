//
//  EPMenuViewPageLayout.m
//  DongYangHRSS
//
//  Created by shi on 2017/11/20.
//  Copyright © 2017年 epsoft. All rights reserved.
//

#import "EPMenuViewPageLayout.h"

@interface EPMenuViewPageLayout ()

@property (assign, nonatomic) NSInteger total;

@end

@implementation EPMenuViewPageLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    self.total = [self.collectionView numberOfItemsInSection:0];
}

- (CGSize)collectionViewContentSize
{
    CGRect bounds = self.collectionView.bounds;
    
    NSInteger numsInPage = self.rowNum * self.colNum;
    NSInteger pageNums = ceil(self.total * 1.0 / numsInPage);
    CGSize size = CGSizeMake(bounds.size.width * pageNums, bounds.size.height);
    
    return size;
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
    CGFloat collectionViewWidth = self.collectionView.bounds.size.width;
    CGFloat collectionViewHeight = self.collectionView.bounds.size.height;
    
    CGFloat cellWidth = floor((collectionViewWidth - self.margin.left - self.margin.right - (self.colNum - 1) * self.colSpace) / self.colNum) ;
    CGFloat cellHeight = floor((collectionViewHeight - self.margin.top - self.margin.bottom - (self.rowNum - 1) * self.rowSpace) / self.rowNum) ;
    
    NSInteger positionPage = indexPath.row / (self.colNum * self.rowNum);    //所在页面
    NSInteger positionRow = indexPath.row / self.colNum % self.rowNum;    //所在页的第几行
    NSInteger positionCol = indexPath.row % self.colNum;    //所在页的第几列
    
    CGFloat x = collectionViewWidth * positionPage + self.margin.left + (cellWidth + self.colSpace) * positionCol;
    CGFloat y = self.margin.top + (cellHeight + self.rowSpace) * positionRow;
    
    
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attr.frame = CGRectMake(x, y, cellWidth, cellHeight);
    
    
    return attr;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

@end
