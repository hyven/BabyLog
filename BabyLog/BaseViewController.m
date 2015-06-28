//
//  BaseViewController.m
//  BabyLog
//
//  Created by jiangbin on 15/6/27.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _navbar = [[NavBarView alloc]init];
    _navbar.delegate = self;
    _navbar.frame = CGRectMake(0, 20, SCREEN_WIDTH, 44);
    [self.view addSubview:_navbar];
}

-(void)viewWillAppear:(BOOL)animated
{
    [_navbar reloadBabyInfo];
}

#pragma mark - NavBarDelegate

-(void)TouchRightButton
{
    
}

-(UINavigationController *)setSuperViewNavigationController
{
    return self.navigationController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
