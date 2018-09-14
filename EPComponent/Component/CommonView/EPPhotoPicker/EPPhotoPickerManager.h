//
//  EPPhotoPickerManager.h
//  JuRongHRSS
//
//  Created by shi on 2018/1/18.
//  Copyright © 2018年 epsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EPAssetModel.h"

@interface EPPhotoPickerManager : NSObject

+(instancetype)shareInstance;

@property (assign, nonatomic) NSInteger maximumNumber;     //选择的最大照片数,默认是 9张

///选择完成后的回调(一般不需要手动调用)
@property (copy, readonly)void(^finishPickBlock)(NSArray<EPAssetModel *> *pickedPhotoArray);
//隐藏图片选择器(一般不需要手动调用)
- (void)hidePhotoPicker;

///显示图片选择器
- (void)showPhotoPickerToViewController:(UIViewController *)viewController
                             finishPick:(void(^)(NSArray<EPAssetModel *> *pickedPhotoArray))finishPickBlock;

@end



