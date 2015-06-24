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
//    self.navigationController.navigationBar.hidden = YES;
//    
//    UINavigationBar *bar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
//    [bar setBackgroundImage:[UIImage imageNamed:@"regist_nav_bg"] forBarMetrics:UIBarMetricsDefault];
//    [bar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                  [UIColor whiteColor],
//                                  NSForegroundColorAttributeName,nil]];
//    
//    UINavigationItem *navItem = [[UINavigationItem alloc]initWithTitle:nil];
//    
//    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
//    [left setFrame:CGRectMake(10, 6, 100, 28)];
//    [left setImage:[UIImage imageNamed:@"pic_count"] forState:UIControlStateNormal];
//    
//    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:left];
//    [navItem setLeftBarButtonItem:leftButton];
//    
//    
//    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
//    [dateformatter setDateFormat:@"YYYY-MM-dd"];
//    NSString * locationString=[dateformatter stringFromDate:[NSDate date]];
//    
//    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
//    [right setFrame:CGRectMake(180, 6, 100, 28)];
//    [right setTitle:locationString forState:UIControlStateNormal];
//    [right setImage:[UIImage imageNamed:@"pic_count"] forState:UIControlStateNormal];
//    right.imageEdgeInsets = UIEdgeInsetsMake(4,80,4,right.titleLabel.bounds.size.width);
//    
//    UIBarButtonItem *rigthButton = [[UIBarButtonItem alloc] initWithCustomView:left];
//    [navItem setLeftBarButtonItem:rigthButton];
//    
//    
//    [bar pushNavigationItem:navItem animated:NO];
//    
//    [self.view addSubview:bar];
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
