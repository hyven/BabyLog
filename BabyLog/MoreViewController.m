//
//  MoreViewController.m
//  BabyLog
//
//  Created by 恒昊 on 15-5-28.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import "MoreViewController.h"
#import "ConstantDefine.h"
#import "LoginViewController.h"
#import "NavViewController.h"
#import "BabyConfigViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController
{
    NavBarView *navbar;
    UITableView *tv;
    NSMutableArray *tvsection;
    NSMutableArray *tvsection2;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.image = [[UIImage imageNamed:@"Gengduo-Grey"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.selectedImage = [[UIImage imageNamed:@"Gengduo-Blue"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self.tabBarItem setImageInsets:UIEdgeInsetsMake(5.5, 0.0, -5.5, 0.0)];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1]];
    
    tv = [[UITableView alloc]initWithFrame:CGRectMake(10, 64, SCREEN_WIDTH-20,SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    tv.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];

    tv.delegate=self;
    tv.dataSource=self;
    
    tv.showsVerticalScrollIndicator=NO;
    [self.view addSubview:tv];
    
    tvsection = [NSMutableArray arrayWithObjects:@"宝贝管理", @"查询班级", @"所在班级", nil];
    tvsection2 = [NSMutableArray arrayWithObjects:@"检查新版本", @"关于", nil];
}


#pragma mark - tableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return [tvsection count];
            break;
        case 1:
            return [tvsection2 count];
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * strID = [NSString stringWithFormat:@"strID"];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = [tvsection objectAtIndex:indexPath.row];
    }
    else
    {
        cell.textLabel.text = [tvsection2 objectAtIndex:indexPath.row];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 7;
    }
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        
        UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 324, 320, 100)];
        
        UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(0, 10, 300, 40);
        [button setBackgroundImage:[UIImage imageNamed:@"logout"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"logout_on"] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        return view;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:{
            BabyConfigViewController *babyCV= [[BabyConfigViewController alloc]init];
            [self.navigationController pushViewController:babyCV animated:YES];
        }
            break;
        case 1:{
           
        }
            break;
        case 2:{
           
        }
            break;
        case 3:{
            
        }
            break;
            
        default:
            break;
    }
}

- (void)logout
{
    UIActionSheet * actionSheet=[[UIActionSheet alloc]initWithTitle:@"确定要退出登录吗?" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [actionSheet setActionSheetStyle:UIActionSheetStyleDefault];
    [actionSheet showInView:[self.view window]];
}

#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        tokenStr=@"";
        [[NSUserDefaults standardUserDefaults] setValue:tokenStr forKey:@"userToken"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        LoginViewController *loginvc = [[LoginViewController alloc]init];
        NavViewController *navController = [[NavViewController alloc]initWithRootViewController:loginvc];
        navController.navigationBarHidden = YES;
        
        self.view.window.rootViewController = navController;
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
