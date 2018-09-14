//
//  EPScrollTitleView.m
//  EPStandardizationAPP
//
//  Created by shi on 2017/11/26.
//  Copyright © 2017年 epsoft. All rights reserved.
//

#import "EPScrollTitleView.h"
#import "EPScrollTitleViewLayout.h"

static NSString *scrollTitleCellId = @"scrollTitleCellId";

@interface EPScrollTitleItemView : UICollectionViewCell
@property (strong, nonatomic) UILabel *titleLb;      //标题Label
@end

@implementation EPScrollTitleItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *titleLb = [[UILabel alloc] init];
//        titleLb.font = kdefaultFont;
        titleLb.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:titleLb];
        self.titleLb = titleLb;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLb.frame = self.contentView.bounds;
}

@end




@interface EPScrollTitleView ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,EPScrollTitleViewLayoutDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIView *bottomLineView;       //底部指示条
@property (assign, nonatomic) NSInteger currentIdx;    //当前被点击的标题位置

@end

@implementation EPScrollTitleView

@synthesize bottomLineHeight = _bottomLineHeight;
@synthesize bottomLineColor = _bottomLineColor;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupScrollTitleViewUI];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    self.collectionView.frame = CGRectMake(0, 0, w, h);
    
    if (self.currentIdx == 0) {
        EPScrollTitleViewLayout *layout = (EPScrollTitleViewLayout *)self.collectionView.collectionViewLayout;
        CGSize size = [self collectionView:self.collectionView layout:layout sizeForItemAtIndex:self.currentIdx];
        CGRect frame = CGRectMake(layout.space, h - self.bottomLineHeight, size.width, self.bottomLineHeight);
        self.bottomLineView.frame = frame;
    }else{
        NSIndexPath *idxPath = [NSIndexPath indexPathForRow:self.currentIdx inSection:0];
        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:idxPath];
        self.bottomLineView.frame = CGRectMake(CGRectGetMinX(cell.frame), h - self.bottomLineHeight, CGRectGetWidth(cell.frame), self.bottomLineHeight);
    }
}

/**
 初始化界面
 */
- (void)setupScrollTitleViewUI
{    
    //创建UICollectionView
    EPScrollTitleViewLayout *layout = [[EPScrollTitleViewLayout alloc] init];
    layout.space = 10;
    layout.delegate = self;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.bounces = YES;
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    //注册cell
    [collectionView registerClass:[EPScrollTitleItemView class] forCellWithReuseIdentifier:scrollTitleCellId];
    
    //创建底部指示条
    UIView *bottomLineView = [[UIView alloc] init];
    bottomLineView.backgroundColor = [UIColor colorWithRed:51/255.0f green:153/255.0f blue:255/255.0f alpha:1.0f];
    [collectionView addSubview:bottomLineView];
    self.bottomLineView = bottomLineView;
}

#pragma mark - setter/getter
- (void)setTitles:(NSMutableArray<NSString *> *)titles
{
    _titles = titles;
    self.currentIdx = 0;
    [self.collectionView reloadData];
    
    EPScrollTitleViewLayout *layout = (EPScrollTitleViewLayout *)self.collectionView.collectionViewLayout;
    CGSize size = [self collectionView:self.collectionView layout:layout sizeForItemAtIndex:self.currentIdx];
    CGRect frame = CGRectMake(layout.space, self.bounds.size.height - self.bottomLineHeight, size.width, self.bottomLineHeight);
    self.bottomLineView.frame = frame;
}

- (UIColor *)titleColor
{
    if (!_titleColor) {
        _titleColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0f];
    }
    return _titleColor;
}

- (UIColor *)selectedTitleColor
{
    if (!_selectedTitleColor) {
        _selectedTitleColor = [UIColor colorWithRed:51/255.0f green:153/255.0f blue:255/255.0f alpha:1.0f];
    }
    return _selectedTitleColor;
}

- (UIFont *)titleFont
{
    if (!_titleFont) {
        _titleFont = [UIFont systemFontOfSize:15];
    }
    return _titleFont;
}

- (UIFont *)selectedTitleFont
{
    if (!_selectedTitleFont) {
        _selectedTitleFont = [UIFont systemFontOfSize:15];
    }
    return _selectedTitleFont;
}

- (UIColor *)bottomLineColor
{
    if (!_bottomLineColor) {
        _bottomLineColor = [UIColor colorWithRed:51/255.0f green:153/255.0f blue:255/255.0f alpha:1.0f];
    }
    return _bottomLineColor;
}

- (void)setBottomLineColor:(UIColor *)bottomLineColor
{
    _bottomLineColor = bottomLineColor;
    self.bottomLineView.backgroundColor = self.bottomLineColor;
}

- (void)setBottomLineHeight:(CGFloat)bottomLineHeight
{
    _bottomLineHeight = bottomLineHeight;
    CGRect frame = self.bottomLineView.frame;
    frame.size.height = self.bottomLineHeight;
    frame.origin.y = self.bounds.size.height - self.bottomLineHeight;
    self.bottomLineView.frame =  frame;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *itemTitle = self.titles[indexPath.row];
    EPScrollTitleItemView *titleItemView = (EPScrollTitleItemView *)[collectionView dequeueReusableCellWithReuseIdentifier:scrollTitleCellId forIndexPath:indexPath];
    titleItemView.titleLb.text = itemTitle;
    if (self.currentIdx == indexPath.row) {
        titleItemView.titleLb.textColor = self.selectedTitleColor;
        titleItemView.titleLb.font = self.selectedTitleFont;
    }else{
        titleItemView.titleLb.textColor = self.titleColor;
        titleItemView.titleLb.font = self.titleFont;
    }
    return titleItemView;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.currentIdx = indexPath.row;
    
    [self scrollTitleToIndex:indexPath.row];
    
    if (self.tapTitleCallback) {
        self.tapTitleCallback(self.currentIdx);
    }
}

#pragma mark - EPScrollTitleViewLayoutDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndex:(NSInteger)index
{
    if (self.titles.count <= 0 || index > self.titles.count - 1) {
        return CGSizeZero;
    }
    
    NSString *itemTitle = self.titles[index];
    //计算字体长度
    NSMutableDictionary *titleAttr = [[NSMutableDictionary alloc] init];
    titleAttr[NSFontAttributeName] = self.titleFont;
//    if (index == self.currentIdx) {
//        titleAttr[NSFontAttributeName] = [UIFont systemFontOfSize:20];
//    }else{
//        titleAttr[NSFontAttributeName] = kdefaultFont;
//    }
    
    CGSize titleSize = [itemTitle sizeWithAttributes:titleAttr];
    
    return CGSizeMake(titleSize.width, collectionView.bounds.size.height);
}

#pragma mark - 公开方法
/**
 滚动到指定的标题
 @param index 标题位置
 */
- (void)scrollTitleToIndex:(NSInteger)index
{
//    self.currentIdx = index;
    [self.collectionView reloadData];
    
    EPScrollTitleViewLayout *layout = (EPScrollTitleViewLayout *)self.collectionView.collectionViewLayout;
    CGRect itemFrame = [layout.itemViewFrame[index] CGRectValue];
    
    CGFloat offsetX = 0;
    CGRect scrollViewBound = self.collectionView.bounds;
    CGFloat currentTitleBtnMaxX = CGRectGetMaxX(itemFrame);
    CGFloat currentTitleBtnMinX = CGRectGetMinX(itemFrame);
    if (currentTitleBtnMaxX > CGRectGetMaxX(scrollViewBound)) {
        CGFloat offsetXOfMax = self.collectionView.contentSize.width - scrollViewBound.size.width;
        offsetX = currentTitleBtnMaxX + 30 - scrollViewBound.size.width;
        if (offsetX > offsetXOfMax) {
            offsetX = offsetXOfMax;
        }
    }else if (currentTitleBtnMinX < CGRectGetMinX(scrollViewBound)){
        offsetX = currentTitleBtnMinX - 30;
        if (offsetX < 0) {
            offsetX = 0;
        }
    }else{
        offsetX = self.collectionView.contentOffset.x;
    }
    
    CGPoint offset = CGPointMake(offsetX, 0);
    [self.collectionView setContentOffset:offset animated:YES];
    
}

/**
 滚动底部指示条到指定的位置
 @param index 标题位置
 */
- (void)scrollBottomLineToIndex:(NSInteger)index
{
    if (index == self.currentIdx) {
        return;
    }
    
    self.currentIdx = index;
//    [self.collectionView reloadData];
    
    CGFloat h = self.bounds.size.height;
    EPScrollTitleViewLayout *layout = (EPScrollTitleViewLayout *)self.collectionView.collectionViewLayout;
    CGRect itemFrame = [layout.itemViewFrame[index] CGRectValue];
    
    [UIView animateWithDuration:0.3f animations:^{
        self.bottomLineView.frame = CGRectMake(CGRectGetMinX(itemFrame), h - self.bottomLineHeight, CGRectGetWidth(itemFrame), self.bottomLineHeight);
    } completion:^(BOOL finished) {
//        [self.collectionView reloadData];
    }];
}


@end
