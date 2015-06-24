//
//  LogViewController.m
//  BabyLog
//
//  Created by 恒昊 on 15-5-27.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import "DiaryViewController.h"
#import "ConstantDefine.h"
#import "TKAlertCenter.h"
#import "APIResult.h"
#import "DiaryListResult.h"
#import "DiaryModel.h"
#import "DiaryTableViewCell.h"
#import "DiaryInfoViewController.h"
#import "DiaryCreateViewController.h"
#import "SelectDateViewController.h"

@interface DiaryViewController ()
{
    APIService *service;
}

@end

@implementation DiaryViewController
{
    NavBarView *navbar;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.tag = 1001;
        self.tabBarItem.image = [[UIImage imageNamed:@"tabicon_log_off"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabicon_log_on"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.title = @"作息";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1]];
    navbar = [[NavBarView alloc]init];
    navbar.delegate = self;
    navbar.frame = CGRectMake(0, 20, SCREEN_WIDTH, 44);
    [self.view addSubview:navbar];
    
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(20, 68, 280, 35);
    addBtn.backgroundColor = [UIColor colorWithRed:197/255.0 green:197/255.0 blue:197/255.0 alpha:1];
    [addBtn setTitle:@"新增作息" forState:UIControlStateNormal];
    [addBtn.titleLabel setTextColor:[UIColor blackColor]];
    [addBtn addTarget:self action:@selector(createDiary) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
    
    dataTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 114, SCREEN_WIDTH, SCREEN_HEIGHT)];
    dataTable.delegate = self;
    dataTable.dataSource = self;
    dataTable.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    dataTable.rowHeight = 75;
    dataTable.showsVerticalScrollIndicator = NO;
    dataTable.tableFooterView = [[UIView alloc]init];
    dataTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:dataTable];

    dataArray=[[NSMutableArray alloc] init];
        
    service = [[APIService alloc] init];
    service.delegate = self;
    
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString * locationString=[dateformatter stringFromDate:[NSDate date]];
    [service getDiaryList:locationString];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectDate:) name:@"SelectDate" object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
//    [service getDiaryList:@"2015-05-12"];

}

-(void)TouchRightButton
{
    SelectDateViewController *dateVC = [[SelectDateViewController alloc]init];
    [self.navigationController pushViewController:dateVC animated:YES];
}

-(UINavigationController *)setSuperViewNavigationController
{
    return self.navigationController;
}

- (void)selectDate:(NSNotification *)_notification
{
    NSString *dateStr = [_notification object];
    [service getDiaryList:dateStr];
    [navbar setDateStr:dateStr];
}


#pragma mark 回调函数

-(void)getDiaryListCallBack:(APIResult*) result
{
    if (result.statusCode == 200) {
        DiaryListResult *list = [DiaryListResult getModelFromJson:result.data];
        [dataArray addObjectsFromArray: list.Diary];
        [self performSelectorOnMainThread:@selector(endThread) withObject:nil waitUntilDone:NO];
    }
}

-(void)endThread
{
    [dataTable reloadData];
}

#pragma mark - tableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *strID = [NSString stringWithFormat:@"strID"];
    DiaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (cell == nil) {
        cell = [[DiaryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    
    DiaryModel *model = [dataArray objectAtIndex:indexPath.row];
    
    cell.backgroundColor=[UIColor clearColor];
    cell.timeLable.text = [NSString stringWithFormat:@"%@", model.entryTime];
    cell.nameLable.text = [NSString stringWithFormat:@"%@", model.diaryTypeName];
    cell.diaryTypeImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"diary_%d", model.diaryTypeId]];
    [cell.rankImgView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"stars_%d", model.rank]]];
    [cell.picCountLabel setText:[NSString stringWithFormat:@"%d", model.picCount]];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DiaryModel * model=[dataArray objectAtIndex:indexPath.row];
    
    DiaryInfoViewController *infoVC = [[DiaryInfoViewController alloc]init];
    infoVC.diaryId = model.diaryId;
    infoVC.picList = model.picList;
    infoVC.title = @"作息详情";
    [self.navigationController pushViewController:infoVC animated:YES];
}


#pragma mark 页面效果
-(void)createDiary
{
    DiaryCreateViewController *infoVC = [[DiaryCreateViewController alloc]init];
    infoVC.title = @"添加作息";
    [self.navigationController pushViewController:infoVC animated:YES];

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
