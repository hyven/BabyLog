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
#import "SelectDateViewController.h"
#import "TKAlertCenter.h"
#import "ReachTool.h"
#import "NavBarView.h"
#import "UzysAssetsPickerController.h"
#import "MoreView.h"
#import "SGActionView.h"

@interface BabyConfigViewController ()
{
    APIService *service;
    NSString *userid;
    BabyInfoModel *info;
    UIButton *logoButton;
    UIImageView *logoView;
    UITableView *formTV;
    UITextField *nameTF;
    UITextField *nicknameTF;
    UITextField *birthdayTF;
    UITextField *sexTF;
    UITextField *btTextField;
    UITextField *areaTF;
    NSMutableArray *itemsArray;
    UITextField *desTF;
    NSString *sp, *sc, *sa;
    NSString *vcTag;

}

@end

@implementation BabyConfigViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        vcTag=@"BabyConfig";
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(camera) name:[NSString stringWithFormat:@"Camera%@",vcTag] object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(photo) name:[NSString stringWithFormat:@"Photo%@",vcTag] object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectBloodType:) name:@"SelectBloodType" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectSex:) name:@"SelectSex" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectArea:) name:@"SelectArea" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectDate:) name:@"SelectBabyConfigDate" object:nil];    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[NSString stringWithFormat:@"Camera%@",vcTag] object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[NSString stringWithFormat:@"Photo%@",vcTag] object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SelectBloodType" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SelectSex" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SelectArea" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SelectBabyConfigDate" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    service = [[APIService alloc] init];
    service.delegate = self;
    [service getBabyInfo];

    [self.view setBackgroundColor:[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1]];
    
    userid = tokenStr;
    
    NSString *rurl = [info.headImg stringByReplacingOccurrencesOfString:@"~/" withString:HTTP_HEADER];
    NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:rurl]];
    
    logoButton=[[UIButton alloc] initWithFrame:CGRectMake(130, 10, 60, 60)];
    logoButton.backgroundColor=[UIColor clearColor];
    logoButton.layer.cornerRadius = logoButton.frame.size.width / 2;
    logoButton.layer.masksToBounds=YES;
    [logoButton addTarget:self action:@selector(selectLogo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoButton];
    
    logoView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    logoView.contentMode=UIViewContentModeScaleAspectFill;
    if (data.length == 0) {
        logoView.image=[UIImage imageNamed:@"KidDefault"];
    }
    else
    {
        [logoView setImage:[UIImage imageWithData:data]];
    }
    [logoButton addSubview:logoView];
    
    formTV = [[UITableView alloc]initWithFrame:CGRectMake(10, logoButton.frame.size.height + 20, SCREEN_WIDTH-20,SCREEN_HEIGHT) style:UITableViewStylePlain];
    formTV.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    formTV.tableFooterView = [[UIView alloc] init];
    formTV.delegate=self;
    formTV.dataSource=self;
    formTV.showsVerticalScrollIndicator=NO;
    formTV.tag = 9001;
    [self.view addSubview:formTV];
    
    UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(10, 430, 300, 40);
    [button setTitle:@"保存宝贝信息" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"redbutton"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(saveInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    
    itemsArray = [NSMutableArray arrayWithObjects:@"O",@"A",@"B",@"AB", nil];
    
    UISwipeGestureRecognizer * rightSwipeGestureRecognizer=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe)];
    rightSwipeGestureRecognizer.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipeGestureRecognizer];

}

#pragma mark 头像上传

//选取头像
- (void)selectLogo
{
    [formTV endEditing:YES];
    
    MoreView *moreView=[[MoreView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    int height=200;
    [SGActionView showCommonWithContentView:moreView height:height];
    tag=vcTag;
}

//打开相机
- (void)camera
{
    // UIImagePickerControllerCameraDeviceRear 后置摄像头
    // UIImagePickerControllerCameraDeviceFront 前置摄像头
    BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    if (!isCamera) {
        NSLog(@"没有摄像头");
        return ;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES; // 编辑模式
    
    [self  presentViewController:imagePicker animated:YES completion:^{
    }];
}

//打开相册
- (void)photo
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES; // 编辑模式
    
    [self  presentViewController:imagePicker animated:YES completion:^{
    }];
}

//选中照片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)pinfo
{
    // UIImagePickerControllerOriginalImage 原始图片
    // UIImagePickerControllerEditedImage 编辑后图片
    UIImage *image = [pinfo objectForKey:UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    // 压缩照片
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    UIImage *tempImage = [UIImage imageWithData: imageData];
    logoView.image=tempImage;
    
    [[logoButton layer] setBorderColor:[[UIColor colorWithWhite:1.0 alpha:1.0] CGColor]];
    [[logoButton layer] setBorderWidth:1.5];
    
    NSString *encodedImageStr = [imageData base64Encoding];
    NSLog(@"%@",encodedImageStr);
    [service babyInfoUpdatePhotoWithBase64String:encodedImageStr];
}

//取消相册

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark 回调函数

-(void) getBabyInfoCallBack:(APIResult *)result
{
    if (result.statusCode == 200) {
        info = [BabyInfoModel getModelFromJson:[result.data objectForKey:@"UserInfo"]];
    }
}

- (void)saveInfo
{
    if (![ReachTool checkReachable]) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"请检查您的网络连接"];
        return;
    }
    info.name = nameTF.text;
    info.nickName = nicknameTF.text;
    info.birthday = birthdayTF.text;
    info.province = sp;
    info.city = sc;
    info.country = sa;
    info.bloodType = btTextField.text;
    info.introduction = desTF.text;
    if ([sexTF.text isEqual: @"女"]) {
        info.sex = 0;
    }
    else
    {
        info.sex = 1;
    }
    info.headImg = @"";
    
    [service updateBabyInfo:info];
}

-(void)updateBabyInfoCallBack:(APIResult *)result
{
    if (result.statusCode == 200) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"信息保存成功"];
        
        [[NSUserDefaults standardUserDefaults] setValue:info.headImg forKey:@"HeadImg"];
        [[NSUserDefaults standardUserDefaults] setValue:info.nickName forKey:@"nickName"];
        
        
    }
    else
    {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:[NSString stringWithFormat:@"信息保存失败：%@", result.error]];
    }
}

- (void)babyInfoUpdatePhotoCallBack:(APIResult *)result
{
    if (result.statusCode == 200) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"上传头像成功"];
    } else {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:result.error];
    }
}

#pragma mark 页面效果

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.navigationItem setTitle: @"宝贝信息"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"regist_nav_bg"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor whiteColor],
                                                                     NSForegroundColorAttributeName,nil]];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(rightSwipe) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backBarButton;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

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

- (void)selectDate
{
    SelectDateViewController *sdView = [[SelectDateViewController alloc]init];
    sdView.notificationName = @"SelectBabyConfigDate";
    [self.navigationController pushViewController:sdView animated:YES];
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
    NSArray *area =[_notification object];
    if (area != NULL) {
        areaTF.text = [[NSString alloc]initWithFormat:@"%@ %@ %@", area[0], area[1], area[2]];
        sp = area[0];
        sc = area[1];
        sa = area[2];
    }
}

- (void)selectDate:(NSNotification *)_notification
{
    birthdayTF.text = [_notification object];
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
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            birthdayTF = [[UITextField alloc]initWithFrame:CGRectMake(80, 0, 100, 40)];
            [birthdayTF setPlaceholder:@"请输入出生日期"];
            [birthdayTF setFont:[UIFont systemFontOfSize:12.0f]];
            [cell addSubview:birthdayTF];
            [birthdayTF setText:info.birthday];
            birthdayTF.enabled = NO;
            birthdayTF.tag = 1001;
            [cell addSubview:birthdayTF];
        }
            break;
        case 3:
        {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 60, 40)];
            [label setText:@"性  别："];
            [label setFont:[UIFont systemFontOfSize:12.0f]];
            [cell addSubview:label];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            sexTF=[[UITextField alloc] init];
            sexTF.frame=CGRectMake(80, 0, 100, 40);
            sexTF.backgroundColor=[UIColor clearColor];
            sexTF.textColor=[UIColor blackColor];
            sexTF.font=[UIFont systemFontOfSize:12];
            sexTF.enabled=NO;
            sexTF.text = info.sex == 1 ? @"男" : @"女";
            [cell addSubview:sexTF];
        }
            break;
        case 4:
        {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 60, 40)];
            [label setText:@"血  型："];
            [label setFont:[UIFont systemFontOfSize:12.0f]];
            [cell addSubview:label];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            btTextField=[[UITextField alloc] init];
            btTextField.frame=CGRectMake(80, 0, 100, 40);
            btTextField.backgroundColor=[UIColor clearColor];
            btTextField.textColor=[UIColor blackColor];
            btTextField.font=[UIFont systemFontOfSize:12];
            btTextField.enabled=NO;
            btTextField.text = info.bloodType;
            [cell addSubview:btTextField];
        }
            break;
        case 5:
        {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 60, 40)];
            [label setText:@"籍  贯："];
            [label setFont:[UIFont systemFontOfSize:12.0f]];
            [cell addSubview:label];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            areaTF=[[UITextField alloc] init];
            areaTF.frame=CGRectMake(80, 0, 100, 40);
            areaTF.backgroundColor=[UIColor clearColor];
            areaTF.textColor=[UIColor blackColor];
            areaTF.font=[UIFont systemFontOfSize:12];
            areaTF.enabled=NO;
            areaTF.text = [[NSString alloc]initWithFormat:@"%@ %@ %@", info.province, info.city, info.country];
            sp = info.province;
            sc = info.city;
            sa = info.country;
            
            [cell addSubview:areaTF];
        }
            break;
        case 6:
        {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 60, 40)];
            [label setText:@"宝贝描述："];
            [label setFont:[UIFont systemFontOfSize:12.0f]];
            [cell addSubview:label];
            
            desTF=[[UITextField alloc] init];
            desTF.frame=CGRectMake(80, 10, 200, 80);
            [desTF setBorderStyle:UITextBorderStyleRoundedRect];
            desTF.backgroundColor=[UIColor clearColor];
            desTF.textColor=[UIColor blackColor];
            desTF.font=[UIFont systemFontOfSize:12];
            if (![info.introduction isKindOfClass:[NSNull class]]) {
                desTF.text = info.introduction;
            }
            [cell addSubview:desTF];
        }
        default:
            break;
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 2:
            [self selectDate];
            break;
        case 3:
            [self selectSex];
            break;
        case 4:
            [self selectBloodType];
            break;
        case 5:
            [self selectArea];
            break;
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 6) {
        return 100;
    }
    return 40;
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
