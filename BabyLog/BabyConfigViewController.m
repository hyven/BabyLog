//
//  BabyConfigViewController.m
//  BabyLog
//
//  Created by jiangbin on 15/6/13.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import "BabyConfigViewController.h"
#import "APIService.h"
#import "APIResult.h"
#import "ConstantDefine.h"
#import "BabyInfoModel.h"
#import "SelectBloodTypeViewController.h"
#import "SelectSexViewController.h"
#import "SelectAreaViewController.h"


@interface BabyConfigViewController ()
{
    APIService *service;
    NSString *userid;
    BabyInfoModel *info;
    UITableView *formTV;
    UITextField *nameTF;
    UITextField *nicknameTF;
    UITextField *birthdayTF;
    UITextField *sexTF;
    UITextField *btTextField;
    UITextField *areaTF;
    NSMutableArray *itemsArray;
}


@end

@implementation BabyConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1]];
    
    UIImageView *navBarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, 320, 44)];
    navBarImageView.image = [UIImage imageNamed:@"regist_nav_bg"];
    [self.view addSubview:navBarImageView];
    
    userid = tokenStr;
    
    formTV = [[UITableView alloc]initWithFrame:CGRectMake(10, 120, SCREEN_WIDTH-20,SCREEN_HEIGHT-120) style:UITableViewStylePlain];
    formTV.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    formTV.tableFooterView = [[UIView alloc] init];
    formTV.delegate=self;
    formTV.dataSource=self;
    formTV.showsVerticalScrollIndicator=NO;
    formTV.tag = 9001;
    [self.view addSubview:formTV];
    
    itemsArray = [NSMutableArray arrayWithObjects:@"O",@"A",@"B",@"AB", nil];

    
    service = [[APIService alloc] init];
    service.delegate = self;
    [service getBabyInfo];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectBloodType:) name:@"SelectBloodType" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectSex:) name:@"SelectSex" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectArea:) name:@"SelectArea" object:nil];

}

#pragma mark 页面效果

-(void)rightSwipe
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)selectSex
{
    SelectSexViewController *btView = [[SelectSexViewController alloc]init];
    [self.navigationController pushViewController:btView animated:YES];
}

-(void)selectBloodType
{
    SelectBloodTypeViewController *btView = [[SelectBloodTypeViewController alloc]init];
    [self.navigationController pushViewController:btView animated:YES];
}

-(void)selectArea
{
    SelectAreaViewController *btView = [[SelectAreaViewController alloc]init];
    [self.navigationController pushViewController:btView animated:YES];
}


#pragma mark - 观察者

- (void)selectSex:(NSNotification *)_notification
{
    int row =[[_notification object] intValue];
    sexTF.text = row == 1 ? @"男" : @"女";
}

- (void)selectBloodType:(NSNotification *)_notification
{
    int row =[[_notification object] intValue];
    btTextField.text = [itemsArray objectAtIndex:row];
}

- (void)selectArea:(NSNotification *)_notification
{
    areaTF.text = [_notification object];
}

#pragma mark tableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * strID = [NSString stringWithFormat:@"strID"];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    switch (indexPath.row) {
        case 0:
        {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 60, 40)];
            [label setText:@"姓  名："];
            [label setFont:[UIFont systemFontOfSize:12.0f]];
            [cell addSubview:label];
            
            nameTF = [[UITextField alloc]initWithFrame:CGRectMake(80, 0, 200, 40)];
            [nameTF setPlaceholder:@"请输入宝贝名称"];
            [nameTF setFont:[UIFont systemFontOfSize:12.0f]];
            [cell addSubview:nameTF];
            [nameTF setText:info.name];
        }
            break;
        case 1:
        {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 60, 40)];
            [label setText:@"小  名："];
            [label setFont:[UIFont systemFontOfSize:12.0f]];
            [cell addSubview:label];
            
            nicknameTF = [[UITextField alloc]initWithFrame:CGRectMake(80, 0, 200, 40)];
            [nicknameTF setPlaceholder:@"请输入宝贝小名"];
            [nicknameTF setFont:[UIFont systemFontOfSize:12.0f]];
            [cell addSubview:nicknameTF];
            [nicknameTF setText:info.nickName];
        }
            break;
        case 2:
        {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 60, 40)];
            [label setText:@"生  日："];
            [label setFont:[UIFont systemFontOfSize:12.0f]];
            [cell addSubview:label];
            
            birthdayTF = [[UITextField alloc]initWithFrame:CGRectMake(80, 0, 200, 40)];
            [birthdayTF setPlaceholder:@"请输入出生日期"];
            [birthdayTF setFont:[UIFont systemFontOfSize:12.0f]];
            [cell addSubview:birthdayTF];
            [birthdayTF setText:info.birthday];
            birthdayTF.tag = 1001;
        }
            break;
        case 3:
        {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 60, 40)];
            [label setText:@"性  别："];
            [label setFont:[UIFont systemFontOfSize:12.0f]];
            [cell addSubview:label];
            
            UIButton *btButton = [UIButton buttonWithType:UIButtonTypeCustom];
            btButton.frame = CGRectMake(80, 0, SCREEN_WIDTH - 90, 40);
            [btButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btButton addTarget:self action:@selector(selectSex) forControlEvents:UIControlEventTouchUpInside];
            
            sexTF=[[UITextField alloc] init];
            sexTF.frame=CGRectMake(0, 3, SCREEN_WIDTH - 100, 35);
            sexTF.backgroundColor=[UIColor clearColor];
            sexTF.textColor=[UIColor blackColor];
            sexTF.font=[UIFont systemFontOfSize:12];
            sexTF.enabled=NO;
            sexTF.text = info.sex == 1 ? @"男" : @"女";
            [btButton addSubview:sexTF];
            
            UIImageView *iconView01=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 130, 12, 20, 20)];
            iconView01.image=[UIImage imageNamed:@"icon_arrow_enter"];
            [btButton addSubview:iconView01];
            [cell addSubview:btButton];
        }
            break;
        case 4:
        {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 60, 40)];
            [label setText:@"血  型："];
            [label setFont:[UIFont systemFontOfSize:12.0f]];
            [cell addSubview:label];
            
            UIButton *btButton = [UIButton buttonWithType:UIButtonTypeCustom];
            btButton.frame = CGRectMake(80, 0, SCREEN_WIDTH - 90, 40);
            [btButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btButton addTarget:self action:@selector(selectBloodType) forControlEvents:UIControlEventTouchUpInside];
            
            btTextField=[[UITextField alloc] init];
            btTextField.frame=CGRectMake(0, 3, SCREEN_WIDTH - 100, 35);
            btTextField.backgroundColor=[UIColor clearColor];
            btTextField.textColor=[UIColor blackColor];
            btTextField.font=[UIFont systemFontOfSize:12];
            btTextField.enabled=NO;
            btTextField.text = info.bloodType;
            [btButton addSubview:btTextField];
            
            UIImageView *iconView01=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 130, 12, 20, 20)];
            iconView01.image=[UIImage imageNamed:@"icon_arrow_enter"];
            [btButton addSubview:iconView01];
            [cell addSubview:btButton];
        }
            break;
        case 5:
        {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 60, 40)];
            [label setText:@"籍  贯："];
            [label setFont:[UIFont systemFontOfSize:12.0f]];
            [cell addSubview:label];
            
            UIButton *btButton = [UIButton buttonWithType:UIButtonTypeCustom];
            btButton.frame = CGRectMake(80, 0, SCREEN_WIDTH - 90, 40);
            [btButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btButton addTarget:self action:@selector(selectArea) forControlEvents:UIControlEventTouchUpInside];
            
            areaTF=[[UITextField alloc] init];
            areaTF.frame=CGRectMake(0, 3, SCREEN_WIDTH - 100, 35);
            areaTF.backgroundColor=[UIColor clearColor];
            areaTF.textColor=[UIColor blackColor];
            areaTF.font=[UIFont systemFontOfSize:12];
            areaTF.enabled=NO;
            areaTF.text = [[NSString alloc]initWithFormat:@"%@ %@ %@", info.province, info.city, info.country];
            [btButton addSubview:areaTF];
            
            UIImageView *iconView01=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 130, 12, 20, 20)];
            iconView01.image=[UIImage imageNamed:@"icon_arrow_enter"];
            [btButton addSubview:iconView01];
            [cell addSubview:btButton];

        }
            break;

        default:
            break;
    }
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

//
//- (void) changeBirthday :(UIDatePicker *)sender {
//    NSDate *selectedDate = sender.date;
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = @"yyyy-MM-dd";
//    NSString *dateString = [formatter stringFromDate:selectedDate];
//    birthdayTF.text = dateString;
//}

#pragma mark 回调函数

-(void) getBabyInfoCallBack:(APIResult *)result
{
    if (result.statusCode == 200) {
        info = [BabyInfoModel getModelFromJson:[result.data objectForKey:@"UserInfo"]];
    }
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
