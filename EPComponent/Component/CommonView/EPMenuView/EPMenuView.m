//
//  EPMenuView.m
//  DongYangHRSS
//
//  Created by shi on 2017/11/20.
//  Copyright © 2017年 epsoft. All rights reserved.
//

#import "EPMenuView.h"
#import "EPMenuItemView.h"
#import "EPMenuViewPageLayout.h"
#import "CommonMacro.h"

#import "UIColor+EP.h"
#import "UIImage+Extension.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "UIView+Frame.h"
#import <SDWebImage/UIImageView+WebCache.h>

static NSString *menuItemViewId = @"EPMenuItemViewId";

CGFloat const indicatorHeight = 20;

@implementation EPMenuItem

@end


@interface EPMenuView ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIPageControl *pageControl;

@end

@implementation EPMenuView

@synthesize indicatorBackgroundColor = _indicatorBackgroundColor;
@synthesize indicatorOtherColor = _indicatorOtherColor;
@synthesize indicatorColor = _indicatorColor;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    self.collectionView.frame = CGRectMake(0, 0, w, h);
    self.pageControl.frame = CGRectMake(0, h - indicatorHeight, w, indicatorHeight);
}

/**
 初始化界面
 */
- (void)setupUI
{
    EPMenuViewPageLayout *layout = [[EPMenuViewPageLayout alloc] init];
    //防止初始化时候colNum和rowNum为0崩溃
    layout.colNum = self.colNum;
    layout.rowNum = self.rowNum;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.pagingEnabled = YES;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    collectionView.backgroundColor = [UIColor whiteColor];
    
    [collectionView registerClass:[EPMenuItemView class] forCellWithReuseIdentifier:menuItemViewId];
    
    //创建指示器
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.backgroundColor = self.indicatorBackgroundColor;
    pageControl.pageIndicatorTintColor = self.indicatorOtherColor;
    pageControl.currentPageIndicatorTintColor = self.indicatorColor;
    pageControl.userInteractionEnabled = NO;
    pageControl.hidesForSinglePage = YES;
    pageControl.currentPage = 0;
    [self addSubview:pageControl];
    self.pageControl = pageControl;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.menuViewDatas.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EPMenuItem *itemMd = self.menuViewDatas[indexPath.row];
    
    EPMenuItemView *menuItemView = (EPMenuItemView *)[collectionView dequeueReusableCellWithReuseIdentifier:menuItemViewId forIndexPath:indexPath];
    menuItemView.titleFont = self.titleFont;
    menuItemView.titleColor = self.titleColor;
    menuItemView.iconSize = self.iconSize;
    menuItemView.iconTitleSpace = self.iconTitleSpace;
    
    menuItemView.titleLb.text = itemMd.title;
    if (itemMd.picName.length > 0) {
        menuItemView.iconView.image = [UIImage imageNamed:itemMd.picName];
    }else if (itemMd.picImage){
        menuItemView.iconView.image = itemMd.picImage;
    }else{
        UIImage *placeholderImg = nil;
        if (itemMd.placeholderPic.length > 0) {
            placeholderImg = [UIImage imageNamed:itemMd.placeholderPic];
        }
        [menuItemView.iconView sd_setImageWithURL:itemMd.picURL placeholderImage:placeholderImg];
    }
    return menuItemView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    EPMenuItem *item = self.menuViewDatas[indexPath.row];
    if (self.tapItemCompletionHandler) {
        self.tapItemCompletionHandler(item, indexPath.row);
    }
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    CGSize size = CGSizeMake(collectionView.bounds.size.width / 4, 40);
//    return size;
//}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger pageNum = floor(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5);
    if (pageNum - 1 < 0) {
        self.pageControl.currentPage = 0;
    }else{
        self.pageControl.currentPage = pageNum;
    }
}

#pragma mark - getter/setter
//-----------MenuView的默认值----------
//margin默认是{0，0，0，0}
//colSpacel默认是0
- (NSInteger)rowNum
{
    if (_rowNum <= 0 ) {
        _rowNum = 1;
    }
    return _rowNum;
}

- (NSInteger)colNum
{
    if (_colNum <= 0) {
        _colNum = 4;
    }
    return _colNum;
}

- (CGFloat)rowSpace
{
    if (_rowSpace <= 0) {
        _rowSpace = 10;
    }
    return _rowSpace;
}

//--------------MenuItemView的默认值----------
- (UIFont *)titleFont
{
    if (!_titleFont) {
        _titleFont = [UIFont systemFontOfSize:14];
    }
    return _titleFont;
}

- (UIColor *)titleColor
{
    if (!_titleColor) {
        _titleColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0f];
    }
    return _titleColor;
}

- (CGSize)iconSize
{
    if (_iconSize.width<=0 || _iconSize.height<= 0) {
        _iconSize = CGSizeMake(40, 40);
    }
    return _iconSize;
}

- (CGFloat)iconTitleSpace
{
    if (_iconTitleSpace <= 0) {
        _iconTitleSpace = 5;
    }
    return _iconTitleSpace;
}

- (void)setMenuViewBackgroundColor:(UIColor *)menuViewBackgroundColor
{
    self.collectionView.backgroundColor = menuViewBackgroundColor;
}
    
//--------------指示器颜色默认值----------
- (UIColor *)indicatorColor
{
    if (!_indicatorColor) {
        _indicatorColor = [UIColor colorWithRed:51/255.0f green:153/255.0f blue:255/255.0f alpha:1.0f];
    }
    return _indicatorColor;
}

- (UIColor *)indicatorOtherColor
{
    if (!_indicatorOtherColor) {
        _indicatorOtherColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
    }
    return _indicatorOtherColor;
}

- (UIColor *)indicatorBackgroundColor
{
    if (!_indicatorBackgroundColor) {
        _indicatorBackgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2f];
    }
    return _indicatorBackgroundColor;
}

- (void)setIndicatorColor:(UIColor *)indicatorColor
{
    _indicatorColor = indicatorColor;
    self.pageControl.currentPageIndicatorTintColor = indicatorColor;
}

- (void)setIndicatorOtherColor:(UIColor *)indicatorOtherColor
{
    _indicatorOtherColor = indicatorOtherColor;
    self.pageControl.pageIndicatorTintColor = indicatorOtherColor;
}

- (void)setIndicatorBackgroundColor:(UIColor *)indicatorBackgroundColor
{
    _indicatorOtherColor = indicatorBackgroundColor;
    self.pageControl.backgroundColor = indicatorBackgroundColor;
}

#pragma mark - 公开方法

/**
 设置布局属性
 */
- (void)layoutUI
{
    EPMenuViewPageLayout *pageLayout = (EPMenuViewPageLayout *)self.collectionView.collectionViewLayout;
    pageLayout.colNum = self.colNum;
    pageLayout.rowNum = self.rowNum;
    pageLayout.rowSpace = self.rowSpace;
    pageLayout.colSpace = self.colSpace;
    pageLayout.margin = self.margin;
    [self.collectionView reloadData];
    
    NSInteger numsInPage = self.rowNum * self.colNum;
    NSInteger pageNums = ceil(self.menuViewDatas.count * 1.0 / numsInPage);
    self.pageControl.numberOfPages = pageNums;
    self.pageControl.currentPage = 0;
}

/**
 获取View的高度
 */
- (CGFloat)heightOfMenuView
{
    CGFloat h = 0.0f;
    EPMenuViewPageLayout *pageLayout = (EPMenuViewPageLayout *)self.collectionView.collectionViewLayout;
//    CGFloat menuItemViewW = (UI_SCREEN_WIDTH - pageLayout.margin.left - pageLayout.margin.right - (pageLayout.colNum - 1) * pageLayout.colSpace)/pageLayout.colNum;
    CGSize titleSize = [@"计算文本" sizeWithAttributes:@{NSFontAttributeName: self.titleFont}];
    CGFloat menuItemViewH = self.iconSize.height + self.iconTitleSpace + titleSize.height;
    h = pageLayout.margin.top + pageLayout.margin.bottom + (pageLayout.rowNum - 1) * pageLayout.rowSpace + pageLayout.rowNum * menuItemViewH;
    return h;
}

@end







