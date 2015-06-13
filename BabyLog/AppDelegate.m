//
//  AppDelegate.m
//  BabyLog
//
//  Created by 恒昊 on 15-5-27.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "MainViewController.h"
#import "DiaryViewController.h"
#import "MessageViewController.h"
#import "VideoViewController.h"
#import "MoreViewController.h"
#import "ConstantDefine.h"
#import "NavViewController.h"

@interface AppDelegate ()
            

@end

@implementation AppDelegate
            

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    
    DiaryViewController *logVC = [[DiaryViewController alloc]init];
    MessageViewController *messageVC = [[MessageViewController alloc]init];
    VideoViewController *videoVC = [[VideoViewController alloc]init];
    MoreViewController *moreVC = [[MoreViewController alloc]init];
    
    NSArray *tabControllers = [[NSArray alloc]initWithObjects:
                               logVC, messageVC, videoVC, moreVC, nil];
    
    _mainViewController = [MainViewController shareMainContainer];
    _mainViewController.viewControllers = tabControllers;
    _mainViewController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    _mainViewController.view.backgroundColor = [UIColor whiteColor];
    
    NavViewController *navController = [[NavViewController alloc]initWithRootViewController:loginVC];
    navController.navigationBarHidden = YES;
    
    self.window.rootViewController = navController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
