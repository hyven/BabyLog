//
//  MainViewController.m
//  BabyLog
//
//  Created by 恒昊 on 15-5-27.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import "MainViewController.h"
#import "NavBarView.h"
#import "ConstantDefine.h"
#import "APIService.h"

@interface MainViewController ()

@end

static MainViewController *tabMainContainer = nil;

@implementation MainViewController

+ (MainViewController *) shareMainContainer
{
    @synchronized(self){
        if (tabMainContainer == nil) {
            tabMainContainer = [[MainViewController alloc] init];
        }
    }
    
    return tabMainContainer;
    
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


-(void)SelectIndexController:(NSInteger) interger;
{
    self.selectedIndex = interger;
    [self tabBarController:self didSelectViewController:self.viewControllers[interger]];
}

-(void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    
    self.navigationItem.leftBarButtonItem=viewController.navigationItem.leftBarButtonItem;
    self.navigationItem.rightBarButtonItem=viewController.navigationItem.rightBarButtonItem;
    
    switch (viewController.view.tag) {
        case 1001:
            self.title = @"作息";
            break;
        case 1002:
            self.title = @"消息";
            break;
        case 1003:
            self.title = @"生活片段";
            break;
        case 1004:
            self.title = @"更多";
            break;
        default:
            break;
    }
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
