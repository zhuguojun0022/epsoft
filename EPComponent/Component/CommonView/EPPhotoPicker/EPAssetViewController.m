//
//  EPAssetViewController.m
//  JuRongHRSS
//
//  Created by shi on 2018/1/18.
//  Copyright © 2018年 epsoft. All rights reserved.
//

#import "EPAssetViewController.h"
#import <Photos/Photos.h>
#import "EPAssetCell.h"
#import "EPAssetModel.h"
#import "EPPhotoAlbumModel.h"
#import "EPPhotoPickerManager.h"

static NSString * const assetCellId = @"EPAssetCellId";

@interface EPAssetViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray<EPAssetModel *> *finalArray;     //处理完成的数据(与selectedAssetArray是一一对应的)
@property (strong, nonatomic) NSMutableArray<PHAsset *> *selectedAssetArray;     //当前选中的资源数据

@end

@implementation EPAssetViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = self.photoAlbumModel.title;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_left_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishAction)];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat space = 3;
    layout.minimumLineSpacing = space;
    layout.minimumInteritemSpacing = space;
    CGFloat viewW = self.view.bounds.size.width;
    CGFloat itemW = (viewW - 2*space - space*3) / 4;
    layout.itemSize = CGSizeMake(itemW, itemW);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.frame = self.view.bounds;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.contentInset = UIEdgeInsetsMake(space, space, 90, space);
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    //注册EPAssetCell
    [collectionView registerClass:[EPAssetCell class] forCellWithReuseIdentifier:assetCellId];
    
    //初始化数组
    self.selectedAssetArray = [[NSMutableArray alloc] init];
    self.finalArray = [[NSMutableArray alloc] init];
}

- (void)dealloc
{
    NSLog(@"释放  EPAssetViewController  ");
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoAlbumModel.assetArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    EPAssetCell *cell = (EPAssetCell *)[collectionView dequeueReusableCellWithReuseIdentifier:assetCellId forIndexPath:indexPath];
    PHAsset *asset = self.photoAlbumModel.assetArray[indexPath.row];
    cell.asset = asset;
    cell.selectHandleBlock = ^(PHAsset *asset, UIImage *thumbImage, BOOL selected) {
        //处理点击事件
        [weakSelf selectAsset:indexPath.row
                   thumbImage:thumbImage
                     selected:selected];
    };
    
    cell.selectedState = [self.selectedAssetArray containsObject:asset];
    
    return cell;
}

- (void)selectAsset:(NSInteger)idx
         thumbImage:(UIImage *)thumbImage
           selected:(BOOL)selected
{
    PHAsset *asset = self.photoAlbumModel.assetArray[idx];
    
    if (selected) {   //选中这个资源文件
        NSInteger max = [EPPhotoPickerManager shareInstance].maximumNumber;
        if (self.finalArray.count >= max) {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"超过最大选择张数!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.collectionView reloadData];
            }];
            [alertVC addAction:confirmAction];
            [self presentViewController:alertVC animated:YES completion:nil];
            return;
        }
        
        PHImageRequestOptions *requestOptions = [[PHImageRequestOptions alloc] init];
        requestOptions.synchronous = YES;
        [[PHImageManager defaultManager] requestImageDataForAsset:asset options:requestOptions resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            if (imageData) {
                EPAssetModel *assetMd = [[EPAssetModel alloc] init];
                //实际使用中发现,服务端没法直接接收imageData这个数据,要UIImageJPEGRepresentation或者UIImagePNGRepresentation转一下才行,为了适配服务端,这里转了一下.
                UIImage *originalImage = [[UIImage alloc] initWithData:imageData];
                NSData *originalData = UIImageJPEGRepresentation(originalImage, 1.0f);
                assetMd.originalImage = originalImage;
                assetMd.originalData = originalData;
                assetMd.fileURL = info[@"PHImageFileURLKey"];
                assetMd.thubImage = thumbImage;
                
                [self.finalArray addObject:assetMd];
                [self.selectedAssetArray addObject:asset];
            }
        }];
    }else{   //取消选中
        NSInteger location = [self.selectedAssetArray indexOfObject:asset];
        if (location != NSNotFound) {
            [self.finalArray removeObjectAtIndex:location];
            [self.selectedAssetArray removeObjectAtIndex:location];
            [self.collectionView reloadData];
        }
    }
}

- (void)finishAction
{
    [EPPhotoPickerManager shareInstance].finishPickBlock(self.finalArray);
    [[EPPhotoPickerManager shareInstance] hidePhotoPicker];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end





