//
//  UIView+Frame.m
//  HRSS
//
//  Created by shi on 2017/4/10.
//  Copyright © 2017年 epsoft. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x
{
    CGRect tempFrame = self.frame;
    tempFrame.origin.x = x;
    self.frame = tempFrame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y
{
    CGRect tempFrame = self.frame;
    tempFrame.origin.y = y;
    self.frame = tempFrame;
}

- (CGFloat)maxX
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setMaxX:(CGFloat)maxX
{
    CGRect frame = self.frame;
    frame.origin.x = maxX - frame.size.width;
    self.frame = frame;
}

- (CGFloat)maxY
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setMaxY:(CGFloat)maxY
{
    CGRect frame = self.frame;
    frame.origin.y = maxY - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint tempPoint = self.center;
    tempPoint.x = centerX;
    self.center = tempPoint;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint tempPoint = self.center;
    tempPoint.y = centerY;
    self.center = tempPoint;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect tempFrame = self.frame;
    tempFrame.size.width = width;
    self.frame = tempFrame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect tempFrame = self.frame;
    tempFrame.size.height = height;
    self.frame = tempFrame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect tempFrame = self.frame;
    tempFrame.size = size;
    self.frame = tempFrame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect tempFrame = self.frame;
    tempFrame.origin = origin;
    self.frame = tempFrame;
}


@end
