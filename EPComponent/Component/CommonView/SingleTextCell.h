//
//  SingleTextCell.h
//  PingHuHRSS
//
//  Created by shi on 2017/8/3.
//  Copyright © 2017年 许芳芳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonMacro.h"

#ifndef ContentAlignment_macro
#define ContentAlignment_macro
typedef NS_ENUM(NSUInteger, ContentAlignment) {
    ContentAlignmentNoSet = 0,      //表示由cell内部自己决定，默认为这个
    ContentAlignmentLeft,
    ContentAlignmentCenter,
    ContentAlignmentRight,
    ContentAlignmentJustified
};
#endif

@interface SingleTextCell : UITableViewCell

@property (strong, nonatomic, readonly) UITextField *field;

@property (assign, nonatomic) CGFloat space;      //标题与内容之间的间隔,默认为15

@property (assign, nonatomic) CGFloat titleWidth;      //标题宽度,默认为0。(0或负数表示使用原始实际的宽度)

@property (assign, nonatomic) ContentAlignment contentAlignment;      //内容对齐方式

@property (assign, nonatomic) BOOL canEdit;      //是否允许编辑

@property (copy, nonatomic) NSString *title;
@property (strong, nonatomic) UIColor *titleColor;
@property (strong, nonatomic) UIFont *titleFont;

@property (copy, nonatomic) NSString *value;
@property (strong, nonatomic) UIColor *valueColor;
@property (strong, nonatomic) UIFont *valueFont;

@property (copy, nonatomic) NSString *placeholder;
@property (strong, nonatomic) UIColor *placeholderColor;

@property (copy, nonatomic) void(^textContentDidChange)(NSString *content);

+ (instancetype)createCellWithTableView:(UITableView *)tableView;

@end
