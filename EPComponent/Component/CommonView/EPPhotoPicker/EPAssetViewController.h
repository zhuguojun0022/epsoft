//
//  EPAssetViewController.h
//  JuRongHRSS
//
//  Created by shi on 2018/1/18.
//  Copyright © 2018年 epsoft. All rights reserved.
//
//  相册中照片展示界面

#import <UIKit/UIKit.h>
@class EPPhotoAlbumModel;

@interface EPAssetViewController : UIViewController

@property (strong, nonatomic) EPPhotoAlbumModel *photoAlbumModel;    //相册数据

@end
