//
//  NavViewController.m
//  BabyLog
//
//  Created by 恒昊 on 15-6-5.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import "NavViewController.h"

@interface NavViewController ()

@end

@implementation NavViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, 320, 20)];
        statusBarView.backgroundColor=[UIColor whiteColor];
        [self.navigationBar addSubview:statusBarView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//调用子视图的状态栏样式
//子视图设置了导航条背景图之后，状态栏会变黑色，为了避免这个情况：
//1.在navcontroller里添加一个白色状态栏背景
//2.重写navcontroller的这个方法，通知程序调用子视图的状态栏样式
- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
