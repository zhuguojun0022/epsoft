//
//  EPPhotoAlbumController.m
//  JuRongHRSS
//
//  Created by shi on 2018/1/18.
//  Copyright © 2018年 epsoft. All rights reserved.
//

#import "EPPhotoAlbumController.h"
#import "EPPhotoAlbumCell.h"
#import "EPPhotoAlbumModel.h"
#import "EPAssetViewController.h"
#import "EPPhotoPickerManager.h"

@interface EPPhotoAlbumController ()

@property (strong, nonatomic) NSArray<EPPhotoAlbumModel *> *photoAlbumArray;     //所有相册

@end

@implementation EPPhotoAlbumController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"相册";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_left_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    //检查相册使用权限
    [self authPhotoLibraryCheck];
}

#pragma mark - 协议方法
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.photoAlbumArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EPPhotoAlbumCell *cell = [EPPhotoAlbumCell createCellWithTableView:tableView];
    EPPhotoAlbumModel *md = self.photoAlbumArray[indexPath.row];
    cell.textLabel.text = md.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"(%d)",(int)md.count];
    if (md.assetArray.count > 0) {
        //取第一张作为封面
        [[PHImageManager defaultManager] requestImageForAsset:[md.assetArray firstObject] targetSize:CGSizeMake(300, 300) contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            cell.imageView.image = result;
        }];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取出当前相册数据
    EPPhotoAlbumModel *photoAlbumModel = self.photoAlbumArray[indexPath.row];
    EPAssetViewController *assetVC = [[EPAssetViewController alloc] init];
    assetVC.photoAlbumModel = photoAlbumModel;
    [self.navigationController pushViewController:assetVC animated:YES];
}

/**
 获取所有相册
 */
- (NSArray<EPPhotoAlbumModel *> *)getAllPhotoAlbums
{
    NSMutableArray *albumArray = [[NSMutableArray alloc] init];
    
    //获取所有相册
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    //获取相册中的照片数量和第一张照片
    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
    fetchOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
    [smartAlbums enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull collection, NSUInteger idx, BOOL *stop) {
        //获取相册中所有照片
        PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:collection options:fetchOptions];
        
        if ([result countOfAssetsWithMediaType:PHAssetMediaTypeImage] > 0) {
            NSMutableArray *assetArray = [[NSMutableArray alloc] init];
            [result enumerateObjectsUsingBlock:^(PHAsset *asset, NSUInteger idx, BOOL * _Nonnull stop) {
                [assetArray addObject:asset];
            }];
            
            EPPhotoAlbumModel *albumModel = [[EPPhotoAlbumModel alloc] init];
            albumModel.count = result.count;
            albumModel.title = collection.localizedTitle;
            albumModel.assetArray = assetArray;
            [albumArray addObject:albumModel];
        }

    }];

    return albumArray;
}

/**
 检查相册授权状态
 */
- (void)authPhotoLibraryCheck
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    switch (status) {
        case PHAuthorizationStatusNotDetermined:
        {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status){
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (status == PHAuthorizationStatusAuthorized) {
                        self.photoAlbumArray = [self getAllPhotoAlbums];
                        [self.tableView reloadData];
                    }else{
                        //退出
                        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"您稍后可以在设置中心重新设置App的相册使用权限" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            [self dismissViewControllerAnimated:YES completion:nil];
                        }];
                        [alertVC addAction:confirmAction];
                        [self presentViewController:alertVC animated:YES completion:nil];
                    }
                });
            }];
            break;
        }
        case PHAuthorizationStatusAuthorized:
        {
            NSLog(@"用户允许当前应用访问相册");
            self.photoAlbumArray = [self getAllPhotoAlbums];
            [self.tableView reloadData];
            break;
        }
        case PHAuthorizationStatusDenied:
        case PHAuthorizationStatusRestricted:
        {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"App需要访问您的相册,请前往设置中心重新设置App的相册使用权限" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertVC addAction:confirmAction];
            [self presentViewController:alertVC animated:YES completion:nil];
            break;
        }
    }
}

- (void)back
{
    [[EPPhotoPickerManager shareInstance] hidePhotoPicker];
}


@end

