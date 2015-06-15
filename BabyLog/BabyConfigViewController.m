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


@interface BabyConfigViewController ()
{
    APIService *service;
    NSString *userid;
    BabyInfoModel *info;
    UITableView *formTV;
    UITextField *nameTF;
    UITextField *nicknameTF;
    UITextField *birthdayTF;
    LMComBoxView *comBox;
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
    
    comBox = [[LMComBoxView alloc]init];
    comBox.backgroundColor = [UIColor whiteColor];
    comBox.arrowImgName = @"down_dark0.png";
    comBox.titlesList = itemsArray;
    comBox.delegate = self;
    comBox.tableHeight = 160;
    comBox.listTable.tag = 9002;
    
    service = [[APIService alloc] init];
    service.delegate = self;
    [service getBabyInfo];
    
}

#pragma mark 页面效果

-(void)rightSwipe
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)selectAtIndex:(int)index inCombox:(LMComBoxView *)_combox
{
    
}


-(void)closeAllTheComBoxView
{
    if(comBox.isOpen)
    {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = comBox.listTable.frame;
            frame.size.height = 0;
            [comBox.listTable setFrame:frame];
        } completion:^(BOOL finished){
            [comBox.listTable removeFromSuperview];
            comBox.isOpen = NO;
            comBox.arrow.transform = CGAffineTransformRotate(comBox.arrow.transform, DEGREES_TO_RADIANS(180));
        }];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [self closeAllTheComBoxView];
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
            
        }
            break;
        case 4:
        {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 60, 40)];
            [label setText:@"血  型："];
            [label setFont:[UIFont systemFontOfSize:12.0f]];
            [cell addSubview:label];
            
            comBox.frame = CGRectMake(80, 10, 100, 20);
            comBox.supView = cell;
            comBox.defaultIndex = [itemsArray indexOfObject:info.bloodType];
            [comBox defaultSettings];
            comBox.tag = 2001;
            [cell addSubview:comBox];

        }
            break;
        case 5:
        {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 60, 40)];
            [label setText:@"籍  贯："];
            [label setFont:[UIFont systemFontOfSize:12.0f]];
            [cell addSubview:label];        }
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
