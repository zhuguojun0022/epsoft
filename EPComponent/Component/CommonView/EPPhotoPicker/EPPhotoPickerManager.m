//
//  EPPhotoPickerManager.m
//  JuRongHRSS
//
//  Created by shi on 2018/1/18.
//  Copyright © 2018年 epsoft. All rights reserved.
//

#import "EPPhotoPickerManager.h"
#import "EPPhotoAlbumController.h"

@interface EPPhotoPickerManager ()

@property (strong, nonatomic) EPPhotoAlbumController *photoAlbumVC;

@property (copy)void(^finishPickBlock)(NSArray<EPAssetModel *> *pickedPhotoArray);

@end

@implementation EPPhotoPickerManager

+(instancetype)shareInstance
{
    static EPPhotoPickerManager *obj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[self.class alloc] init];
    });
    
    return obj;
}

- (NSInteger)maximumNumber
{
    if (_maximumNumber <= 0) {
        _maximumNumber = 9;
    }
    return _maximumNumber;
}

- (void)showPhotoPickerToViewController:(UIViewController *)viewController
                             finishPick:(void(^)(NSArray<EPAssetModel *> *pickedPhotoArray))finishPickBlock
{
    EPPhotoAlbumController *photoAlbumVC = [[EPPhotoAlbumController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:photoAlbumVC];
    [viewController presentViewController:nav animated:YES completion:^{
        self.photoAlbumVC = photoAlbumVC;
        self.finishPickBlock = finishPickBlock;
    }];
}

- (void)hidePhotoPicker
{
    if (self.photoAlbumVC && self.photoAlbumVC.navigationController.presentingViewController) {
        [self.photoAlbumVC dismissViewControllerAnimated:YES completion:nil];
    }
    self.photoAlbumVC = nil;
    self.finishPickBlock = nil;
    
}

@end

