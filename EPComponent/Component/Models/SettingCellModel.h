//
//  SettingCellModel.h
//  JuRongHRSS
//
//  Created by shi on 2017/9/17.
//  Copyright © 2017年 epsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingCellModel : NSObject

@property (copy, nonatomic) NSString *title;

@property (copy, nonatomic) NSString *value;

@property (copy, nonatomic) NSString *placeholder;

@property (strong, nonatomic) id extraObject;       //可通过该属性来携带额外的值

@end
