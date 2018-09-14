//
//  EPAssetCell.h
//  JuRongHRSS
//
//  Created by shi on 2018/1/18.
//  Copyright © 2018年 epsoft. All rights reserved.
//
//  图片缩略图cell

#import <UIKit/UIKit.h>
@class PHAsset;

@interface EPAssetCell : UICollectionViewCell

@property (copy)void(^selectHandleBlock)(PHAsset *asset, UIImage *thumbImage, BOOL selected);

@property (strong, nonatomic) PHAsset *asset;

@property (assign, nonatomic) BOOL selectedState;

@end
