//
//  EPPhotoAlbumCell.m
//  JuRongHRSS
//
//  Created by shi on 2018/1/18.
//  Copyright © 2018年 epsoft. All rights reserved.
//

#import "EPPhotoAlbumCell.h"

@interface EPPhotoAlbumCell ()

@end

@implementation EPPhotoAlbumCell

+ (instancetype)createCellWithTableView:(UITableView *)tableView
{
    static NSString *cellId = @"EPPhotoAlbumCellId";
    EPPhotoAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[self class] alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
        cell.imageView.clipsToBounds = YES;
        cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
        cell.textLabel.textColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0f];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0f];
    }
    return cell;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat cellH = self.bounds.size.height;
    
    CGFloat imgH = cellH * 0.7;
    self.imageView.frame = CGRectMake(15, (cellH - imgH)/2, imgH, imgH);
    self.textLabel.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame) + 10, (cellH - CGRectGetHeight(self.textLabel.frame))/2, self.textLabel.frame.size.width, self.textLabel.frame.size.height);
    self.detailTextLabel.frame = CGRectMake(CGRectGetMaxX(self.textLabel.frame) + 5, (cellH - CGRectGetHeight(self.detailTextLabel.frame))/2, self.detailTextLabel.frame.size.width, self.detailTextLabel.frame.size.height);
}


@end

