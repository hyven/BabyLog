//
//  MainViewController.h
//  BabyLog
//
//  Created by 恒昊 on 15-5-27.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UITabBarController<UITabBarControllerDelegate>

+ (MainViewController *) shareMainContainer;

-(void)SelectIndexController:(NSInteger) interger;

@end
