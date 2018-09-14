//
//  EPMenuCell.m
//  DongYangHRSS
//
//  Created by shi on 2017/11/21.
//  Copyright © 2017年 epsoft. All rights reserved.
//

#import "EPMenuCell.h"

@interface EPMenuCell ()

@property (strong, nonatomic) EPMenuView *menuView;

@end

@implementation EPMenuCell

+ (instancetype)createCellWithTableView:(UITableView *)tableView
{
    static NSString *cellId = @"EPMenuCellId";
    EPMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[self class] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        EPMenuView *menuView = [[EPMenuView alloc] init];
        [self.contentView addSubview:menuView];
        self.menuView = menuView;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.menuView.frame = self.bounds;
}

@end
