//
//  GesturePasswordView.m
//  HRSS
//
//  Created by shi on 2017/5/2.
//  Copyright © 2017年 epsoft. All rights reserved.
//

#import "GesturePasswordView.h"

#define kPadding kRatio_Scale_375(60)
#define kMargin_left_right kRatio_Scale_375(35)
#define kMargin_top kRatio_Scale_375(20)

@interface GesturePasswordView ()

@property (strong, nonatomic) NSMutableArray *touchPoints;
@property (strong, nonatomic) NSMutableArray *touchRects;
@property (strong, nonatomic) NSMutableArray *selectedPointIdxs;

@property (assign, nonatomic) CGPoint curPoint;

@property (assign, nonatomic) NSInteger radius;
@property (assign, nonatomic) NSInteger circleLineWidth;
@property (assign, nonatomic) NSInteger straightLineWidth;

@property (strong, nonatomic) UIColor *normalStrokeColor;
@property (strong, nonatomic) UIColor *normalFillColor;
@property (strong, nonatomic) UIColor *selectedStrokeColor;
@property (strong, nonatomic) UIColor *selectedFillColor;
@property (strong, nonatomic) UIColor *smallCircleFillColor;
@property (strong, nonatomic) UIColor *selectedSmallCircleFillColor;
@property (strong, nonatomic) UIColor *errorColor;

@property (assign, nonatomic) BOOL needDrawLastJoinLine;      //是否需要绘制最后一个连接线
@property (assign, nonatomic) BOOL enableInput;      //是否允许手势输入

@end

@implementation GesturePasswordView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.touchPoints = [[NSMutableArray alloc] init];
        self.touchRects = [[NSMutableArray alloc] init];
        self.selectedPointIdxs = [[NSMutableArray alloc] init];
        
        self.normalStrokeColor = [UIColor clearColor];
        self.normalFillColor = [UIColor whiteColor];
        self.selectedStrokeColor = [UIColor colorWithRed:51/255.0f green:153/255.0f blue:255/255.0f alpha:1.0f];
        self.selectedFillColor = [UIColor whiteColor];
        self.smallCircleFillColor = [UIColor colorWithRed:230/255.0f green:241/255.0f blue:255/255.0f alpha:1.0f];
        self.selectedSmallCircleFillColor = [UIColor colorWithRed:51/255.0f green:153/255.0f blue:255/255.0f alpha:1.0f];
        
        self.circleLineWidth = 2.0f;
        self.straightLineWidth = 4.0f;
        
        //当前不处于错误状态
        self.pwdError = NO;
        //需要绘制最后一个连接线
        self.needDrawLastJoinLine = YES;
        //允许手势输入
        self.enableInput = YES;
        
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat w = self.bounds.size.width;
    self.radius = floor((w - 2 * kMargin_left_right - 2 * kPadding) / 3 / 2);
    
    [self.touchRects removeAllObjects];
    [self.touchPoints removeAllObjects];
    
    for (int i = 0; i < 9; i++) {
        NSInteger row = i / 3;
        NSInteger col = i % 3;
        CGFloat x = kMargin_left_right + self.radius + col * (2 * self.radius + kPadding);
        CGFloat y = kMargin_top + self.radius + row * (2 * self.radius + kPadding);
        CGPoint center = CGPointMake(x, y);
        [self.touchPoints addObject:[NSValue valueWithCGPoint:center]];
        [self.touchRects addObject:[NSValue valueWithCGRect:[self computeRectWithCenter:center]]];
    }
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (int i = 0; i < self.touchPoints.count; i++) {
        NSValue *centerValue = self.touchPoints[i];
        CGPoint center = [centerValue CGPointValue];
        [path moveToPoint:CGPointMake(center.x + self.radius, center.y)];
        [path addArcWithCenter:center radius:self.radius startAngle:0 endAngle:2 * M_PI clockwise:YES];
    }
    [self.normalStrokeColor setStroke];
    [self.normalFillColor setFill];
    path.lineWidth = self.circleLineWidth;
    [path stroke];
    [path fill];
    
    
    path = [UIBezierPath bezierPath];
    for (int i = 0; i < 9; i++) {
        NSValue *centerValue = self.touchPoints[i];
        CGPoint center = [centerValue CGPointValue];
        [path moveToPoint:CGPointMake(center.x + self.radius * 0.6 , center.y)];
        [path addArcWithCenter:center radius:self.radius * 0.3 startAngle:0 endAngle:2 * M_PI clockwise:YES];
    }
    [self.smallCircleFillColor setFill];
    path.lineWidth = self.circleLineWidth;
    [path fill];
    
    
    //画连接线
    [self.selectedStrokeColor setStroke];
    CGPoint addLines[9];
    for (int i = 0; i < self.selectedPointIdxs.count; i++) {
        NSInteger idx = [self.selectedPointIdxs[i] integerValue];
        CGPoint point = [self.touchPoints[idx] CGPointValue];
        addLines[i] = point;
    }
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextAddLines(ctx, addLines, self.selectedPointIdxs.count);
    CGContextSetLineWidth(ctx, self.straightLineWidth);
    CGContextStrokePath(ctx);
    //------------绘制最后一条连接线------------------
    //确定是否要绘制最后一个线段(当前手指位置与最后一个选中的触控圈之间的连接线)
    if (self.needDrawLastJoinLine) {
        if ([self.selectedPointIdxs lastObject]) {  //判断是否有选中的点,如果还没有选中也不绘制
            NSInteger idx = [[self.selectedPointIdxs lastObject] integerValue];
            CGPoint point = [self.touchPoints[idx] CGPointValue];
            CGContextMoveToPoint(ctx, point.x, point.y);
            CGContextAddLineToPoint(ctx, self.curPoint.x, self.curPoint.y);
            CGContextStrokePath(ctx);
        }
    }
    
    
    path = [UIBezierPath bezierPath];
    for (int i = 0; i < self.selectedPointIdxs.count; i++) {
        NSInteger idx = [self.selectedPointIdxs[i] integerValue];
        NSValue *centerValue = self.touchPoints[idx];
        CGPoint center = [centerValue CGPointValue];
        [path moveToPoint:CGPointMake(center.x + self.radius, center.y)];
        [path addArcWithCenter:center radius:self.radius startAngle:0 endAngle:2 * M_PI clockwise:YES];
    }
    path.lineWidth = self.circleLineWidth;
    [self.selectedStrokeColor setStroke];
    [self.selectedFillColor setFill];
    [path stroke];
    [path fill];
    
    
    path = [UIBezierPath bezierPath];
    for (int i = 0; i < self.selectedPointIdxs.count; i++) {
        NSInteger idx = [self.selectedPointIdxs[i] integerValue];
        NSValue *centerValue = self.touchPoints[idx];
        CGPoint center = [centerValue CGPointValue];
        [path moveToPoint:CGPointMake(center.x + self.radius * 0.6 , center.y)];
        [path addArcWithCenter:center radius:self.radius * 0.3 startAngle:0 endAngle:2 * M_PI clockwise:YES];
    }
    [self.selectedSmallCircleFillColor setFill];
    path.lineWidth = self.circleLineWidth;
    [path fill];
}

#pragma mark - 手势事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!self.enableInput) {
        return;
    }
    
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    self.curPoint = touchPoint;
    
    for (int i = 0; i < self.touchRects.count; i++) {
        if (CGRectContainsPoint([self.touchRects[i] CGRectValue], touchPoint) && ![self.selectedPointIdxs containsObject:@(i)]) {
            [self.selectedPointIdxs addObject:@(i)];
            break;
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!self.enableInput) {
        return;
    }
    
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    self.curPoint = touchPoint;
    
    for (int i = 0; i < self.touchRects.count; i++) {
        if (CGRectContainsPoint([self.touchRects[i] CGRectValue], touchPoint)) {
            if (![self.selectedPointIdxs containsObject:@(i)]) {
                [self.selectedPointIdxs addObject:@(i)];
            }
            break;
        }
    }
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!self.enableInput) {
        return;
    }
    
    if (self.selectedPointIdxs.count > 0) {
        NSLog(@"%@",self.selectedPointIdxs);
        NSString *handlePwd = [self.selectedPointIdxs componentsJoinedByString:@""];
        NSLog(@"%@",handlePwd);
        if (self.setPasswordCallback) {
            self.setPasswordCallback(handlePwd);
        }
    }
    //不需要绘制最后一个连接线
    self.needDrawLastJoinLine = NO;
    //输入完成后就不允许再次手势输入,需要重置View的状态后才能再次输入
    if (self.selectedPointIdxs.count > 0) {
        self.enableInput = NO;
    }
    
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self setReset:YES];
}

#pragma mark - getter/setter
- (void)setReset:(BOOL)reset
{
    _reset = reset;
    
    [self.selectedPointIdxs removeAllObjects];
    
    if (reset) {
        //允许手势输入
        self.enableInput = YES;
        //需要绘制最后一个连接线
        self.needDrawLastJoinLine = YES;
        self.pwdError = NO;
        
        self.normalStrokeColor = [UIColor clearColor];
        self.normalFillColor = [UIColor whiteColor];
        self.selectedStrokeColor = [UIColor colorWithRed:51/255.0f green:153/255.0f blue:255/255.0f alpha:1.0f];
        self.selectedFillColor = [UIColor whiteColor];
        self.smallCircleFillColor = [UIColor colorWithRed:230/255.0f green:241/255.0f blue:255/255.0f alpha:1.0f];
        self.selectedSmallCircleFillColor = [UIColor colorWithRed:51/255.0f green:153/255.0f blue:255/255.0f alpha:1.0f];
    }
    
    [self setNeedsDisplay];
}

- (void)setPwdError:(BOOL)pwdError
{
    _pwdError = pwdError;
    if (pwdError) {
        self.normalStrokeColor = [UIColor redColor];
        self.normalFillColor = [UIColor whiteColor];
        self.selectedStrokeColor = [UIColor redColor];
        self.selectedFillColor = [UIColor whiteColor];
        self.smallCircleFillColor = [UIColor redColor];
        self.selectedSmallCircleFillColor = [UIColor redColor];
    }
    
    [self setNeedsDisplay];
}

#pragma mark - 工具方法
//根据中点计算Frame
- (CGRect)computeRectWithCenter:(CGPoint)center
{
    return CGRectMake(center.x - self.radius, center.y - self.radius, 2 * self.radius, 2 * self.radius);
}

@end





