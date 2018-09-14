//
//  PassThroughView.m
//  EPStandardizationAPP
//
//  Created by zhu guojun on 2018/5/11.
//  Copyright © 2018年 epsoft. All rights reserved.
//

#import "PassThroughView.h"

@implementation PassThroughView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitview = [super hitTest:point withEvent:event];
    if (hitview == self) {
        return nil;
    }else {
        return hitview;
    }
}

@end
