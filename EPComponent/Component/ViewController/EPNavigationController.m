//
//  EPNavigationController.m
//  JuRongHRSS
//
//  Created by shi on 2017/9/7.
//  Copyright © 2017年 epsoft. All rights reserved.
//

#import "EPNavigationController.h"
#import "CommonMacro.h"

#import "UIColor+EP.h"
#import "UIImage+Extension.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "UIView+Frame.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define kNavgationBarFont [UIFont boldSystemFontOfSize:17]       //导航字体大小

@interface EPNavigationController ()

@end

@implementation EPNavigationController

+ (void)initialize
{
    [UINavigationBar appearance].barStyle = UIBarStyleDefault;
    
    UIImage *bkImage = [UIImage imageWithColor:kThemeColor];
    [[UINavigationBar appearance] setShadowImage:bkImage];
    [[UINavigationBar appearance] setBackgroundImage:bkImage forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTranslucent:NO];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    //设置导航栏标题文字颜色和文字大小
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName : kNavgationBarFont}];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_left_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
        viewController.navigationItem.leftBarButtonItem = leftItem;
        
        //如果自定义返回按钮后, 滑动返回可能失效, 需要添加下面的代码
        __weak typeof(viewController)Weakself = viewController;
        self.interactivePopGestureRecognizer.delegate = (id)Weakself;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back{
    // 判断两种情况: push 和 present
    if ((self.presentedViewController || self.presentingViewController) && self.childViewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else
        [self popViewControllerAnimated:YES];
}

@end
