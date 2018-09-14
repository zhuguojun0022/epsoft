//
//  EPScrollPageController.m
//  EPStandardizationAPP
//
//  Created by shi on 2017/11/26.
//  Copyright © 2017年 epsoft. All rights reserved.
//

#import "EPScrollPageController.h"
#import "EPScrollTitleView.h"

@interface EPScrollPageController ()<UIScrollViewDelegate>

@property (strong, nonatomic) EPScrollTitleView *titleView;     //滚动的标题视图
@property (strong, nonatomic) UIScrollView *mainScrollView;     //主ScrollView,用来放置ViewController.view

@property (strong, nonatomic) NSMutableDictionary<NSNumber *, UIViewController *> *visibleViewControllers;   //要显示的视图控制器数组

@property (assign, nonatomic) NSInteger currentIdx;    //当前的页面

@end

@implementation EPScrollPageController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupScrollPageViewUI];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGFloat w = self.view.bounds.size.width;
    CGFloat h = self.view.bounds.size.height;
    
    //设置leftView的frame
    if (self.leftView) {
        self.leftView.frame = CGRectMake(0, 0, self.leftWidth, self.titleViewHeight);
    }
    //设置rightView的frame
    if (self.rightView) {
        self.rightView.frame = CGRectMake(w - self.rightWidth, 0, self.rightWidth, self.titleViewHeight);
    }
    //设置titleView的frame
    self.titleView.frame = CGRectMake(self.leftWidth, 0, w - self.leftWidth - self.rightWidth, self.titleViewHeight);
    CGFloat titleViewMaxY = CGRectGetMaxY(self.titleView.frame);
    //设置mainScrollView的Frame
    self.mainScrollView.frame = CGRectMake(0, titleViewMaxY, w, h - titleViewMaxY);
    
    CGFloat mainScrollViewHeight = self.mainScrollView.bounds.size.height;
    
    //设置pageViewController的frame
    NSInteger preIdx = self.currentIdx - 1<0?0:self.currentIdx-1;
    NSInteger nextIdx = self.currentIdx + 1>self.pageViewControllers.count-1?self.pageViewControllers.count-1:self.currentIdx+1;
    NSMutableArray *adds = [@[@(preIdx),@(self.currentIdx),@(nextIdx)]mutableCopy];
    
    for (NSNumber *number in adds) {
        UIViewController *vc = self.visibleViewControllers[number];
        vc.view.frame = CGRectMake([number integerValue] * w, 0, w, mainScrollViewHeight);
    }
    
    NSLog(@"000");
    self.mainScrollView.contentOffset = CGPointMake(w * self.currentIdx, 0);
    NSLog(@"111");
    self.mainScrollView.contentSize = CGSizeMake(w * self.pageViewControllers.count, mainScrollViewHeight);
    
}

#pragma - mark 初始化界面
- (void)setupScrollPageViewUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.bottomLineHeight = 3.0f;
    
    //创建titleView
    EPScrollTitleView *titleView = [[EPScrollTitleView alloc] init];
    [self.view addSubview:titleView];
    self.titleView = titleView;
    __weak typeof(self) weakSelf = self;
    titleView.tapTitleCallback = ^(NSInteger tappedIdx){
        CGPoint offset = CGPointMake(tappedIdx * weakSelf.mainScrollView.bounds.size.width, 0);
        [weakSelf.mainScrollView setContentOffset:offset animated:YES];
    };

    //创建mainScrollView
    UIScrollView *mainScrollView = [[UIScrollView alloc] init];
    mainScrollView.backgroundColor = [UIColor whiteColor];
    mainScrollView.showsVerticalScrollIndicator = NO;
    mainScrollView.showsHorizontalScrollIndicator = NO;
    mainScrollView.delegate = self;
    mainScrollView.pagingEnabled = YES;
    mainScrollView.bounces = NO;
    [self.view addSubview:mainScrollView];
    self.mainScrollView = mainScrollView;
    if (@available(iOS 11.0, *)) {
        self.mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma getter/setter方法
/**
 设置左侧视图
 */
- (void)setLeftView:(UIView *)leftView
{
    if (_leftView != leftView) {
        [_leftView removeFromSuperview];
    }
    _leftView = leftView;
    if (leftView) {
        [self.view addSubview:leftView];
    }
}

/**
 设置右侧视图
 */
- (void)setRightView:(UIView *)rightView
{
    if (_rightView != rightView) {
        [_rightView removeFromSuperview];
    }
    _rightView = rightView;
    if (rightView) {
        [self.view addSubview:rightView];
    }
}

#pragma mark - 协议方法
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.currentIdx = floor(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5);
    [self.titleView scrollBottomLineToIndex:self.currentIdx];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger preIdx = self.currentIdx - 1<0?0:self.currentIdx-1;
    NSInteger nextIdx = self.currentIdx + 1>self.pageViewControllers.count-1?self.pageViewControllers.count-1:self.currentIdx+1;
    
    NSMutableArray *adds = [@[@(preIdx),@(self.currentIdx),@(nextIdx)]mutableCopy];
    
    CGFloat w = scrollView.bounds.size.width;
    CGFloat h = scrollView.bounds.size.height;
    
    for (NSNumber *nubmer in adds){
        NSInteger idx = [nubmer integerValue];
        UIViewController *needShowVC = self.pageViewControllers[idx];
        if (!needShowVC.view.superview) {
            [self.mainScrollView addSubview:needShowVC.view];
            needShowVC.view.frame = CGRectMake(w * idx, 0, w, h);
            self.visibleViewControllers[nubmer] = needShowVC;
        }
    }
    
    NSArray *allKeys = [self.visibleViewControllers allKeys];
    for (NSNumber *number in allKeys) {
        if ([number integerValue]==preIdx || [number integerValue]==self.currentIdx || [number integerValue]==nextIdx) {
            continue;
        }
        UIViewController *vc = self.visibleViewControllers[number];
        [vc.view removeFromSuperview];
        self.visibleViewControllers[number] = nil;
    }

    [self.titleView scrollTitleToIndex:self.currentIdx];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollViewDidEndDecelerating:scrollView];
}

#pragma mark - 公开方法
/**
 更新数据,设置完成视图数据后要调用该方法
 (注意:只更新pageViewController和标题视图,右侧视图不更新,如果需要更新右侧视图,请设置rightView属性)
 */
- (void)updateDatas
{
    //移除旧的
    for (UIViewController *childVC in self.childViewControllers) {
        [childVC.view removeFromSuperview];
        [childVC removeFromParentViewController];
    }
    
    self.visibleViewControllers = [[NSMutableDictionary alloc] init];
    NSMutableArray *itemTitles = [[NSMutableArray alloc] init];
    int i = 0;
    for (UIViewController *vc in self.pageViewControllers) {
        NSString *title = vc.title;
        if (title.length <= 0) {   //标题不能有空的
            _pageViewControllers = nil;
            self.visibleViewControllers = nil;
            self.titleView.titles = nil;
            //移除前面添加的视图
            for (UIViewController *childVC in self.childViewControllers) {
                [childVC.view removeFromSuperview];
                [childVC removeFromParentViewController];
            }
            NSLog(@"UIViewController标题不能为空");
            return;
        }
        
        [self addChildViewController:vc];
        [itemTitles addObject:title];
        
        if (i < 1) {
            self.visibleViewControllers[@(i)] = vc;
            [self.mainScrollView addSubview:vc.view];
        }
        i++;
    }
    
    self.currentIdx = 0;
    
    self.titleView.titleFont = self.titleFont;
    self.titleView.selectedTitleFont = self.selectedTitleFont;
    self.titleView.titleColor = self.titleColor;
    self.titleView.selectedTitleColor = self.selectedTitleColor;
    
    self.titleView.bottomLineHeight = self.bottomLineHeight;
    self.titleView.bottomLineColor = self.bottomLineColor;
    
    self.titleView.titles = itemTitles;
}

@end



