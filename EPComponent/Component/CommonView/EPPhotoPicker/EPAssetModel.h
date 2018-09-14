//
//  EPAssetModel.h
//  JuRongHRSS
//
//  Created by shi on 2018/1/18.
//  Copyright © 2018年 epsoft. All rights reserved.
//
//  资源model

#import <UIKit/UIKit.h>

@interface EPAssetModel : NSObject

@property (strong, nonatomic) UIImage *thubImage;     //缩略图
@property (strong, nonatomic) UIImage *originalImage;   //原始图
@property (strong, nonatomic) NSData *originalData;    //图片数据
@property (copy, nonatomic) NSString *fileURL;    //图片地址

@end
