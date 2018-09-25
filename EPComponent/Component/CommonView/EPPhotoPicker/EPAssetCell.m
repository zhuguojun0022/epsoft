//
//  EPAssetCell.m
//  JuRongHRSS
//
//  Created by shi on 2018/1/18.
//  Copyright © 2018年 epsoft. All rights reserved.
//

#import "EPAssetCell.h"
#import <Photos/Photos.h>

@interface EPAssetCell()

@property (strong, nonatomic) UIImageView *photoView;    //图片
@property (strong, nonatomic) UIButton *selectBtn;    //选择按钮

@property (copy, nonatomic) void(^delHandleBlock)(void);

@end

@implementation EPAssetCell

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
    
    self.photoView.frame = self.contentView.bounds;
    self.selectBtn.frame = CGRectMake(w - 30, 0, 30, 30);
}

- (void)setupUI
{
    UIImageView *photoView = [[UIImageView alloc] init];
    photoView.clipsToBounds = YES;
    photoView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:photoView];
    self.photoView = photoView;
    
    UIButton *selectBtn = [[UIButton alloc] init];
    
    NSString * bundlePath = [[ NSBundle mainBundle] pathForResource: @"EPComponent" ofType :@"bundle"];
    NSBundle *securityBundle = [NSBundle bundleWithPath:bundlePath];
    
    NSString *path01 = [securityBundle pathForResource:@"photoPicker_nonSelected_icon" ofType:@"png"];
    
    
    UIImage *tempImage01 = [UIImage imageWithContentsOfFile:path01];
    [selectBtn setImage:tempImage01 forState:UIControlStateNormal];
    
    NSString *path02 = [securityBundle pathForResource:@"photoPicker_selected_icon" ofType:@"png"];
    UIImage *tempImage02 = [UIImage imageWithContentsOfFile:path02];
    
    [selectBtn setImage:tempImage02 forState:UIControlStateSelected];
    [selectBtn addTarget:self action:@selector(selectPhotoAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:selectBtn];
    self.selectBtn = selectBtn;
}

- (void)selectPhotoAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    [UIView animateWithDuration:0.2f animations:^{
        sender.transform = CGAffineTransformMakeScale(0.9f, 0.9f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2f animations:^{
            sender.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            if (self.selectHandleBlock) {
                self.selectHandleBlock(self.asset, self.photoView.image, sender.selected);
            }
        }];
    }];
}

//设置缩略图
- (void)setAsset:(PHAsset *)asset
{
    _asset = asset;
    
    PHImageRequestOptions *requestOptions = [[PHImageRequestOptions alloc] init];
//    requestOptions.synchronous = YES;
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(200, 200) contentMode:PHImageContentModeAspectFit options:requestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        self.photoView.image = result;
    }];
}

- (void)setSelectedState:(BOOL)selectedState
{
    self.selectBtn.selected = selectedState;
}


@end
