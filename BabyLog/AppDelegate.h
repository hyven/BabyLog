//
//  AppDelegate.h
//  BabyLog
//
//  Created by 恒昊 on 15-5-27.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

NSString *tokenStr;
NSString *userNameStr;
NSString *tag;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain) MainViewController *mainViewController;
@property (nonatomic ,retain)UIImageView * startView;


@end

