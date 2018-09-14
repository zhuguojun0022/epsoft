//
//  LoopImageCell.m
//  EPStandardizationAPP
//
//  Created by shi on 2017/11/22.
//  Copyright © 2017年 epsoft. All rights reserved.
//

#import "LoopImageCell.h"

@interface LoopImageCell ()

@property (strong, nonatomic) LoopImageView *loopImageView;

@end

@implementation LoopImageCell

+ (instancetype)createCellWithTableView:(UITableView *)tableView
{
    static NSString *cellId = @"LoopImageCellId";
    LoopImageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[self class] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        LoopImageView *loopImageView = [[LoopImageView alloc] init];
        [self.contentView addSubview:loopImageView];
        self.loopImageView = loopImageView;
    }
    return self;
}

- (void)dealloc
{
    [self.loopImageView removetimer];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.loopImageView.frame = self.bounds;
}

@end
