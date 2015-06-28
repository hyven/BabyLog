//
//  DairyCreateViewController.m
//  BabyLog
//
//  Created by 恒昊 on 15-6-10.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import "DiaryCreateViewController.h"
#import "ConstantDefine.h"
#import "SelectDateViewController.h"
#import "SelectDairyTypeViewController.h"

@interface DiaryCreateViewController ()

@end

@implementation DiaryCreateViewController
{
    APIService *service;
    NSString *userid;
    UITableView *formTV;
    UITextField *dayTF;
    UITextField *startTF;
    UITextField *endTF;
    UITextField *typeTF;
    UIImageView *typeImage;
    UILabel *typeName;
    RatingBar *bar;
    //    NSMutableArray *itemsArray;
    UITextField *desTF;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1]];

    service = [[APIService alloc] init];
    service.delegate = self;
    
    formTV = [[UITableView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20,SCREEN_HEIGHT) style:UITableViewStylePlain];
    formTV.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    formTV.tableFooterView = [[UIView alloc] init];
    formTV.delegate=self;
    formTV.dataSource=self;
    formTV.showsVerticalScrollIndicator=NO;
    formTV.tag = 9001;
    [self.view addSubview:formTV];
    
    UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(10, 500, 300, 40);
    [button setTitle:@"保存作息" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"redbutton"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(saveInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UISwipeGestureRecognizer * rightSwipeGestureRecognizer=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe)];
    rightSwipeGestureRecognizer.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipeGestureRecognizer];
    
}

-(void)saveInfo
{
    
}


#pragma mark - 观察者

- (void)selectDate:(NSNotification *)_notification
{
    dayTF.text = [_notification object];
}

-(void)selectDairyType:(NSNotification *)_notification
{
    NSArray *selectType = [_notification object];;
    typeImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"diary_%@", [selectType objectAtIndex:0]]];
    typeName.text = [selectType objectAtIndex:1];
    [typeTF removeFromSuperview];
}


#pragma mark 页面效果
-(void)rightSwipe
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.navigationItem setTitle: @"添加作息"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"regist_nav_bg"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor whiteColor],
                                                                     NSForegroundColorAttributeName,nil]];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(rightSwipe) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backBarButton;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectDate:) name:@"SelectCreateDiaryDate" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectDairyType:) name:@"SelectCreateDiaryType" object:nil];
}

-(void)backPop
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
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
    
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    
    switch (indexPath.row) {
        case 0:
        {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 60, 40)];
            [label setText:@"日      期："];
            [label setFont:[UIFont systemFontOfSize:12.0f]];
            [cell addSubview:label];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            [dateformatter setDateFormat:@"YYYY-MM-dd"];
            NSString * locationString=[dateformatter stringFromDate:[NSDate date]];
            
            dayTF = [[UITextField alloc]initWithFrame:CGRectMake(80, 0, 100, 40)];
            [dayTF setPlaceholder:@"请选择日期"];
            [dayTF setFont:[UIFont systemFontOfSize:12.0f]];
            dayTF.text = locationString;
            dayTF.enabled = NO;
            [cell addSubview:dayTF];
        }
            break;
        case 1:
        {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 60, 40)];
            [label setText:@"开始时间："];
            [label setFont:[UIFont systemFontOfSize:12.0f]];
            [cell addSubview:label];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            [dateformatter setDateFormat:@"HH:mm"];
            NSString * time=[dateformatter stringFromDate:[NSDate date]];
            
            startTF = [[UITextField alloc]initWithFrame:CGRectMake(80, 0, 200, 40)];
            [startTF setPlaceholder:@"请选择开始时间"];
            [startTF setFont:[UIFont systemFontOfSize:12.0f]];
            startTF.enabled = NO;
            startTF.text = time;
            [cell addSubview:startTF];
        }
            break;
        case 2:
        {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 60, 40)];
            [label setText:@"结束时间："];
            [label setFont:[UIFont systemFontOfSize:12.0f]];
            [cell addSubview:label];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            [dateformatter setDateFormat:@"HH:mm"];
            NSString * time=[dateformatter stringFromDate:[NSDate date]];
            
            endTF = [[UITextField alloc]initWithFrame:CGRectMake(80, 0, 200, 40)];
            [endTF setPlaceholder:@"请选择结束时间"];
            [endTF setFont:[UIFont systemFontOfSize:12.0f]];
            endTF.enabled = NO;
            endTF.text = time;
            [cell addSubview:endTF];
        }
            break;
        case 3:
        {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 60, 40)];
            [label setText:@"作      息："];
            [label setFont:[UIFont systemFontOfSize:12.0f]];
            [cell addSubview:label];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            typeImage=[[UIImageView alloc] init];
            typeImage.frame=CGRectMake(80, 5, 30, 30);
            [cell addSubview:typeImage];

            typeName = [[UILabel alloc]init];
            typeName.font=[UIFont systemFontOfSize:12];
            typeName.frame=CGRectMake(115, 10, 100, 20);
            [cell addSubview:typeName];
            
            typeTF = [[UITextField alloc]init];
            typeTF.placeholder = @"请选择作息";
            typeTF.enabled = NO;
            typeTF.font = [UIFont systemFontOfSize:12.0f];
            typeTF.frame =CGRectMake(80, 0, 200, 40);
            [cell addSubview:typeTF];

        }
            break;
        case 4:
        {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 60, 40)];
            [label setText:@"表      现："];
            [label setFont:[UIFont systemFontOfSize:12.0f]];
            [cell addSubview:label];
            
            bar = [[RatingBar alloc] initWithFrame:CGRectMake(80, 0, 160, 40)];
            bar.starNumber = 5;
            [cell addSubview:bar];

        }
            break;
        case 5:
        {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 60, 40)];
            [label setText:@"内      容："];
            [label setFont:[UIFont systemFontOfSize:12.0f]];
            [cell addSubview:label];
            
            desTF=[[UITextField alloc] init];
            desTF.frame=CGRectMake(80, 10, 200, 80);
            [desTF setBorderStyle:UITextBorderStyleRoundedRect];
            desTF.font=[UIFont systemFontOfSize:12];
            desTF.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
            [cell addSubview:desTF];
        }
            break;
        case 6:
        {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 60, 40)];
            [label setText:@"上传图片："];
            [label setFont:[UIFont systemFontOfSize:12.0f]];
            [cell addSubview:label];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }
            break;
        default:
            break;
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self selectDate];
            break;
        case 1:
            [self selectTime];
            break;
        case 2:
            [self selectTime];
            break;
        case 3:
            [self selectType];
            break;
        case 5:
            [self updateImage];
            break;
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 6 || indexPath.row == 5) {
        return 100;
    }
    return 40;
}

#pragma mark goto

-(void) selectDate
{
    SelectDateViewController *sdvc = [[SelectDateViewController alloc]init];
    sdvc.notificationName=@"SelectCreateDiaryDate";
    [self.navigationController pushViewController:sdvc animated:YES];
}

-(void) selectTime
{
    
}

-(void) selectType
{
    SelectDairyTypeViewController *dtVC = [[SelectDairyTypeViewController alloc]init];
    [self.navigationController pushViewController:dtVC animated:YES];
}

-(void) updateImage
{
    
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
