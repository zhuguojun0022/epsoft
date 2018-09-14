//
//  EPPhotoAlbumModel.h
//  JuRongHRSS
//
//  Created by shi on 2018/1/18.
//  Copyright © 2018年 epsoft. All rights reserved.
//
//  相册数据model(代表一个相册)

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface EPPhotoAlbumModel : NSObject
///相册标题
@property (copy, nonatomic) NSString *title;
///相册中照片数量
@property (assign, nonatomic) NSInteger count;
///所有照片资源
@property (strong, nonatomic) NSArray<PHAsset *> *assetArray;

@end
