//
//  EPPicSelectView.m
//  JuRongHRSS
//
//  Created by shi on 2018/1/16.
//  Copyright © 2018年 epsoft. All rights reserved.
//

#import "EPPicSelectView.h"
#import "EPPicSelectViewLayout.h"
#import "CommonMacro.h"

@interface EPPicSelectItemView : UICollectionViewCell

@property (strong, nonatomic) UIImageView *picView;    //图片
@property (strong, nonatomic) UIButton *delbtn;    //删除图标

@property (copy, nonatomic) void(^delHandleBlock)(void);

@end

@implementation EPPicSelectItemView

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
    
    self.picView.frame = self.contentView.bounds;
    self.delbtn.frame = CGRectMake(w - 20, 0, 20, 20);
}

- (void)setupUI
{
    UIImageView *picView = [[UIImageView alloc] init];
    picView.clipsToBounds = YES;
    picView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:picView];
    self.picView = picView;
    
    UIButton *delbtn = [[UIButton alloc] init];
    [delbtn setBackgroundImage:[UIImage imageNamed:@"picSelectView_del.png"] forState:UIControlStateNormal];
    [delbtn addTarget:self action:@selector(tapDelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:delbtn];
    self.delbtn = delbtn;
}

- (void)tapDelBtn:(UIButton *)sender
{
    if (self.delHandleBlock) {
        self.delHandleBlock();
    }
}

@end



static NSString *picSelectItemViewId = @"picSelectItemView";

@interface EPPicSelectView ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSArray <UIImage *> *datas;

@end

@implementation EPPicSelectView

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
    
    self.collectionView.frame = self.bounds;
}

/**
 初始化界面
 */
- (void)setupUI
{
    EPPicSelectViewLayout *layout = [[EPPicSelectViewLayout alloc] init];
    layout.colNums = 5;
    layout.colSpace = kRatio_Scale_375(10);
    layout.rowSpace = kRatio_Scale_375(10);

    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    [collectionView registerClass:[EPPicSelectItemView class] forCellWithReuseIdentifier:picSelectItemViewId];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.datas.count >= self.maxPicNums) {
        return self.maxPicNums;
    }else if (self.nonEditable){
        return self.datas.count;
    }else{
        return self.datas.count + 1;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EPPicSelectItemView *picItemView = (EPPicSelectItemView *)[collectionView dequeueReusableCellWithReuseIdentifier:picSelectItemViewId forIndexPath:indexPath];
    if (indexPath.row < self.datas.count) {
        picItemView.picView.image = self.datas[indexPath.row];
        picItemView.delbtn.hidden = self.nonEditable;
    }else{
        picItemView.picView.image = [UIImage imageNamed:@"pic_upload_icon"];
        picItemView.delbtn.hidden = YES;
    }
    
    __weak typeof(self) weakSelf = self;
    picItemView.delHandleBlock = ^{
        [weakSelf deleteItem:indexPath.row];
    };
    
    
    return picItemView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.datas.count) {
        if (self.tapHandleBlock) {
            self.tapHandleBlock(indexPath.row);
        }
    }else{
        if (self.addHandleBlock) {
            self.addHandleBlock(indexPath.row);
        }
    }
}

- (void)deleteItem:(NSInteger)idx
{
    if (self.delHandleBlock) {
        self.delHandleBlock(idx);
    }
}

- (void)setdatas:(NSArray<UIImage *> *)datas
{
    _datas = datas;
    [self.collectionView reloadData];
}

/**
 根据EPPicSelectView的宽高计算出高度
 @param viewWidth EPPicSelectView的宽度
 @return EPPicSelectView的高度
 */
- (CGFloat)heightForPicSelectViewWithWidth:(CGFloat)viewWidth
{
    EPPicSelectViewLayout *layout = (EPPicSelectViewLayout *)self.collectionView.collectionViewLayout;
    CGFloat itemW = (viewWidth - layout.margins.left - layout.margins.right - (layout.colNums - 1) * layout.colSpace)/layout.colNums;
    CGFloat itemNumbers = [self.collectionView numberOfItemsInSection:0];
    NSInteger rows = ceil(itemNumbers * 1.0 / layout.colNums);
    CGFloat h = (rows - 1) * layout.rowSpace + rows *itemW + layout.margins.top + layout.margins.bottom;
    return h;
}




@end


