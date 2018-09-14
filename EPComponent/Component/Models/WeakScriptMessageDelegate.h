//
//  WeakScriptMessageDelegate.h
//  DongYangHRSS
//
//  Created by shi on 2017/10/10.
//  Copyright © 2017年 epsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface WeakScriptMessageDelegate : NSObject<WKScriptMessageHandler>

@property (weak, nonatomic) id<WKScriptMessageHandler> scriptDelegate;

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end
