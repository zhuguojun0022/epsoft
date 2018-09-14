//
//  EPPicSelectViewLayout.m
//  JuRongHRSS
//
//  Created by shi on 2018/1/17.
//  Copyright © 2018年 epsoft. All rights reserved.
//

#import "EPPicSelectViewLayout.h"

@implementation EPPicSelectViewLayout

- (void)prepareLayout
{
    if (self.colNums <= 0) {
        self.colNums = 4;
    }
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray* attributes = [super layoutAttributesForElementsInRect:rect];
 
    CGFloat itemW = (self.collectionView.bounds.size.width - self.margins.left - self.margins.right - (self.colNums - 1) * self.colSpace)/self.colNums;
    
    for(int i = 0; i < attributes.count; i++) {
        
        NSInteger row = i / self.colNums;
        NSInteger col = i % self.colNums;
        
        UICollectionViewLayoutAttributes *currentLayoutAttributes = attributes[i];
        CGRect frame = currentLayoutAttributes.frame;
        frame.origin.x = self.margins.left + col * (itemW + self.colSpace);
        frame.origin.y = self.margins.top + (itemW + self.rowSpace) * row;
        frame.size.width = itemW;
        frame.size.height = itemW;
        currentLayoutAttributes.frame = frame;
    }
    return attributes;
}

@end
