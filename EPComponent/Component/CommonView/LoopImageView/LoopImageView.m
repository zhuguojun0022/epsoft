//
//  LoopImageView.m
//  HRSS
//
//  Created by shi on 2017/4/10.
//  Copyright © 2017年 epsoft. All rights reserved.
//

#import "LoopImageView.h"
#import "CommonMacro.h"

#import "UIColor+EP.h"
#import "UIImage+Extension.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "UIView+Frame.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface LoopImageView ()<UIScrollViewDelegate>

@property(strong, nonatomic) UIScrollView *scrollView;

@property(strong, nonatomic) NSMutableArray<UIImageView *> *imageViews;

@property(strong, nonatomic) UIPageControl *pageControl;

@property(strong, nonatomic) NSTimer *timer;

@end

@implementation LoopImageView

@synthesize images = _images;
@synthesize imageUrls = _imageUrls;
@synthesize imageNames = _imageNames;

#pragma mark - 生命周期方法
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
    
    CGFloat w = self.scrollView.bounds.size.width;
    CGFloat h = self.scrollView.bounds.size.height;
    
    for (int i = 0; i < self.imageViews.count; i++) {
        UIImageView *imgv = self.imageViews[i];
        imgv.frame = CGRectMake(i * w, 0, w, h);
    }
    
    //防止scrollView为第一个子视图时,系统自动加64的contentInset
    self.scrollView.contentInset = UIEdgeInsetsZero;
    if (self.imageViews.count <= 1) {
        self.scrollView.contentSize = CGSizeMake(w, h);
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }else{
        //两张图片或两张以上就要循环滚动,前后会多加两个UIImageView,当currentPage为0时,其实是第1个UIImageView,依次类推
        self.scrollView.contentSize = CGSizeMake(w * self.imageViews.count, h);
        self.scrollView.contentOffset = CGPointMake(w * (self.pageControl.currentPage + 1), 0);
    }
    
    self.pageControl.frame = CGRectMake(0, h - 20, w, 20);
}

#pragma mark - 初始化相关

-(void)initSubViews
{
    self.backgroundColor = [UIColor whiteColor];
    
    //创建 UIScrollview
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.scrollEnabled = YES;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    [self addSubview:self.scrollView];
    
    //创建指示器
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.currentPage = 0 ;
    self.pageControl.backgroundColor = [UIColor clearColor];
    self.pageControl.pageIndicatorTintColor = [UIColor colorWithHexString:@"d8d8d8"];
    self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"3399ff"];
    
    self.pageControl.userInteractionEnabled = NO;
    self.pageControl.hidesForSinglePage = YES;
    self.pageControl.currentPage = 0;
    [self addSubview:self.pageControl];
    
    _images = [[NSArray alloc] init];
    _imageNames = [[NSArray alloc] init];
    _imageUrls = [[NSArray alloc] init];
    _imageViews = [[NSMutableArray alloc] init];
}

#pragma mark - setter/getter
-(void)setImages:(NSArray<UIImage *> *)images
{
    _images = images;
    
    [self setupImageViewAndPageControl];
    
    for (int i = 0; i < self.imageViews.count; i++) {
        UIImageView *imgv = self.imageViews[i];
        if (i == 0) {
            imgv.image = images[images.count - 1];
        }else if (i == self.imageViews.count - 1){
            imgv.image = images[0];
        }else{
            imgv.image = images[i - 1];
        }
    }
}

-(void)setImageUrls:(NSArray<NSURL *> *)imageUrls
{
    _imageUrls = imageUrls;
    
    [self setupImageViewAndPageControl];
    
    for (int i = 0; i < self.imageViews.count; i++) {
        UIImageView *imgv = self.imageViews[i];
        if (i == 0) {
            [imgv sd_setImageWithURL:imageUrls[imageUrls.count - 1] placeholderImage:nil];
        }else if (i == self.imageViews.count - 1){
            [imgv sd_setImageWithURL:imageUrls[0] placeholderImage:nil];
        }else{
            [imgv sd_setImageWithURL:imageUrls[i - 1] placeholderImage:nil];
        }
    }
}

-(void)setImageNames:(NSArray<NSString *> *)imageNames
{
    _imageNames = imageNames;
    
    [self setupImageViewAndPageControl];
    
    for (int i = 0; i < self.imageViews.count; i++) {
        UIImageView *imgv = self.imageViews[i];
        if (i == 0) {
            imgv.image = [UIImage imageNamed:imageNames[imageNames.count - 1]];
        }else if (i == self.imageViews.count - 1){
            imgv.image = [UIImage imageNamed:imageNames[0]];
        }else{
            imgv.image = [UIImage imageNamed:imageNames[i - 1]];
        }
    }
}

/**
 *  创建UIImageView,如果图片数量为0,不会创建,图片数据为1,创建1个,图片数量>=2,创建 数量+2 个
 */
- (void)setupImageViewAndPageControl
{
    NSUInteger num = 0;
    if (self.images.count > 0) {
        num = self.images.count;
    }else if (self.imageNames.count > 0){
        num = self.imageNames.count;
    }else if (self.imageUrls.count > 0){
        num = self.imageUrls.count;
    }
    
    //设置pageControl
    self.pageControl.numberOfPages = num;
    if (num == 0) {
        self.pageControl.hidden = YES;
        return;
    }else if (num == 1){
        self.pageControl.hidden = YES;
    }else{
        self.pageControl.hidden = NO;
    }
    
    [self.imageViews removeAllObjects];
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //循环创建imageView
    for (int i = 0; i < num + 2; i++) {
        
        UIImageView *imgv = [[UIImageView alloc] init];
        imgv.clipsToBounds = YES;
        //添加手势
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage:)];
        [imgv addGestureRecognizer:tapRecognizer];
        imgv.userInteractionEnabled = YES;
        
        [self.scrollView addSubview:imgv];
        [self.imageViews addObject:imgv];
        
        //只有一张图片只创建一个UIImageView
        if (num == 1) {
            break;
        }
    }
    
    [self setNeedsLayout];
    
    //两张图片及以上才进行滚动
    if (num >= 2) {
        //添加定时器
        [self addtimer];
    }
}


#pragma mark - 协议方法
#pragma mark  UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger pageNum = floor(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5);
    
    if (pageNum - 1 < 0) {
        self.pageControl.currentPage = 0;
    }else{
        self.pageControl.currentPage = pageNum - 1;
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removetimer];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self scrollViewDidEndDecelerating:scrollView];
//        [self addtimer];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat w = self.scrollView.bounds.size.width;
    NSUInteger pageNum = floor(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5);
    if (pageNum == self.imageViews.count - 1) {
        [self.scrollView setContentOffset:CGPointMake(w, 0) animated:NO];
    }else if (pageNum == 0){
        [self.scrollView setContentOffset:CGPointMake(w * (self.imageViews.count - 2), 0) animated:NO];
    }
    
    [self addtimer];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollViewDidEndDecelerating:scrollView];
}

#pragma mark - 定时器相关
/**
 * 添加定时器
 */
-(void)addtimer
{
    if (self.imageViews.count <= 3) {
        return;
    }
    
    if (!self.timer) {
        self.timer = [NSTimer timerWithTimeInterval:4.0f target:self selector:@selector(loadNextPage) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

/**
 * 移除定时器
 */
-(void)removetimer
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

/**
 * 定时器自动调用方法，显示下一张图片
 */
-(void)loadNextPage
{
    NSUInteger pageNum = floor(self.scrollView.contentOffset.x / self.scrollView.bounds.size.width + 0.5);
    [self.scrollView setContentOffset:CGPointMake((pageNum + 1) * self.scrollView.bounds.size.width, 0) animated:YES];
}

/**
 * 点击图片时回调并传加图片所属序号
 */
-(void)clickImage:(UITapGestureRecognizer *)tapRecognizer
{
    if (self.tapImageCallback) {
        self.tapImageCallback(self.pageControl.currentPage);
    }
    
}

@end
