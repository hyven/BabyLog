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
#import "MainViewController.h"

@interface DiaryViewController ()
{
    APIService *service;
    NavBarView *navbar;
}

@end

@implementation DiaryViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.tag = 1001;
        self.tabBarItem.image = [[UIImage imageNamed:@"Zuoxi-Grey"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.selectedImage = [[UIImage imageNamed:@"Zuoxi-Blue"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        self.tabBarItem.title = @"作息";
        [self.tabBarItem setImageInsets:UIEdgeInsetsMake(5.5, 0.0, -5.5, 0.0)];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]];
    navbar = super.navbar;
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(20, 68, 280, 35);
    addBtn.backgroundColor = [UIColor colorWithRed:197/255.0 green:197/255.0 blue:197/255.0 alpha:1];
    [addBtn setTitle:@"新增作息" forState:UIControlStateNormal];
    [addBtn.titleLabel setTextColor:[UIColor blackColor]];
    [addBtn addTarget:self action:@selector(createDiary) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
    
    dataTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 114, SCREEN_WIDTH, SCREEN_HEIGHT - 163)];
    dataTable.delegate = self;
    dataTable.dataSource = self;
    dataTable.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    dataTable.rowHeight = 70;
    dataTable.showsVerticalScrollIndicator = NO;
    dataTable.tableFooterView = [[UIView alloc]init];
    dataTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:dataTable];
    
    UIImageView *spview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 113, SCREEN_WIDTH, 1)];
    spview.backgroundColor = TABLEVIEWCELL_BACKGROUN_COLOR;
    [self.view addSubview:spview];

    dataArray=[[NSMutableArray alloc] init];
        
    service = [[APIService alloc] init];
    service.delegate = self;
    
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString * locationString=[dateformatter stringFromDate:[NSDate date]];
    [service getDiaryList:locationString];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectDate:) name:@"SelectDairyDate" object:nil];
}

#pragma mark - NavBarDelegate

-(void)TouchRightButton
{
    SelectDateViewController *dateVC = [[SelectDateViewController alloc]init];
    dateVC.notificationName = @"SelectDairyDate";
    [self.navigationController pushViewController:dateVC animated:YES];
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
        [dataArray removeAllObjects];
        [dataArray addObjectsFromArray: list.Diary];
        [self performSelectorOnMainThread:@selector(endThread) withObject:nil waitUntilDone:NO];
    }
}

-(void)deleteDiaryCallBack:(APIResult *)result
{
    if (result.statusCode == 200) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"删除成功"];
        [dataTable reloadData];
    }
    else
    {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:[NSString stringWithFormat:@"删除失败：%@", result.error]];
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
    
    cell.diaryId = model.diaryId;
    cell.backgroundColor=[UIColor clearColor];
    cell.timeLable.text = [NSString stringWithFormat:@"%@", model.entryTime];
    cell.nameLable.text = [NSString stringWithFormat:@"%@", model.diaryTypeName];
    cell.diaryTypeImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"activity_%d", model.diaryTypeId]];
    [cell.rankImgView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"stars_%d", model.rank]]];
    if (model.picCount == 0) {
        [cell.picCountImgView setImage:[UIImage imageNamed:@"Tupian-Grey"]];
    }
    
    UIImageView *spview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 69, SCREEN_WIDTH, 1)];
    spview.backgroundColor = TABLEVIEWCELL_BACKGROUN_COLOR;
    [cell addSubview:spview];
    
    UITapGestureRecognizer *delTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(DeleteDetail:)];
    [cell.delImgView addGestureRecognizer:delTap];

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DiaryModel *model = [dataArray objectAtIndex:indexPath.row];
    if(model.picCount > 0)
    {    
        DiaryInfoViewController *infoVC = [[DiaryInfoViewController alloc]init];
        infoVC.diaryId = model.diaryId;
        infoVC.picList = model.picList;
        infoVC.title = @"作息详情";
        [self.navigationController pushViewController:infoVC animated:YES];
    }
}

-(void)DeleteDetail:(id)sender
{
    DiaryTableViewCell *cell = (DiaryTableViewCell *)[sender superview];
    int diaryid = cell.diaryId;
    [service deleteDiary: [NSString stringWithFormat:@"%d", diaryid]];
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
