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
    UITextField *desTF;
    NSString *sp, *sc, *sa;
}


@end

@implementation BabyConfigViewController

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
    
    UIImageView *profileImg = [[UIImageView alloc]init];
    profileImg.frame = CGRectMake(130, 80, 60, 60);
    profileImg.layer.cornerRadius = profileImg.frame.size.width / 2;
    profileImg.clipsToBounds = YES;
    [profileImg setImage:[UIImage imageWithData:data]];
    [self.view addSubview:profileImg];
    
    formTV = [[UITableView alloc]initWithFrame:CGRectMake(10, 150, SCREEN_WIDTH-20,SCREEN_HEIGHT) style:UITableViewStylePlain];
    formTV.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    formTV.tableFooterView = [[UIView alloc] init];
    formTV.delegate=self;
    formTV.dataSource=self;
    formTV.showsVerticalScrollIndicator=NO;
    formTV.tag = 9001;
    [self.view addSubview:formTV];
    
    UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(10, 500, 300, 40);
    [button setTitle:@"保存宝贝信息" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"redbutton"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(saveInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    
    itemsArray = [NSMutableArray arrayWithObjects:@"O",@"A",@"B",@"AB", nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectBloodType:) name:@"SelectBloodType" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectSex:) name:@"SelectSex" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectArea:) name:@"SelectArea" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectDate:) name:@"SelectBabyConfigDate" object:nil];
    
    UISwipeGestureRecognizer * rightSwipeGestureRecognizer=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe)];
    rightSwipeGestureRecognizer.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipeGestureRecognizer];

}

+(NSString *)PostImagesToServer:(NSString *) strUrl dicPostParams:(NSMutableDictionary *)params dicImages:(NSMutableDictionary *) dicImages{
    
    NSString * res;
//    
    //分界线的标识符
    NSString *TWITTERFON_FORM_BOUNDARY = @"D7uw9H2YbhRuVF60E9mEOJmEncb6QMjRx0T0j";
    //根据url初始化request
    //NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    
    NSURL *url = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //要上传的图片
    UIImage *image;//=[params objectForKey:@"pic"];
    //得到图片的data
    //NSData* data = UIImagePNGRepresentation(image);
    //http body的字符串
    NSMutableString *body=[[NSMutableString alloc]init];
    //参数的集合的所有key的集合
    NSArray *keys= [params allKeys];
    
    //遍历keys
    for(int i=0;i<[keys count];i++) {
        //得到当前key
        NSString *key=[keys objectAtIndex:i];
        //如果key不是pic，说明value是字符类型，比如name：Boris
        //if(![key isEqualToString:@"pic"]) {
        //添加字段的值
        [body appendFormat:@"%@\r\n",[params objectForKey:key]];
        //添加分界线，换行
        [body appendFormat:@"%@\r\n",MPboundary];
        //添加字段名称，换2行
        [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n",key];
        [body appendFormat:@"Content-Type: text/plain; charset=utf-8\r\n"];
        [body appendString:@"Content-Transfer-Encoding: 8bit\r\n\r\n"];
        //}
    }
    ////添加分界线，换行
    //[body appendFormat:@"%@\r\n",MPboundary];
    
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[NSMutableData data];
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    //循环加入上传图片
    keys = [dicImages allKeys];
    for(int i = 0; i< [keys count] ; i++){
        //要上传的图片
        image = [dicImages objectForKey:[keys objectAtIndex:i ]];
        //得到图片的data
        NSData* data =  UIImageJPEGRepresentation(image, 0.0);
        NSMutableString *imgbody = [[NSMutableString alloc] init];
        //此处循环添加图片文件
        //添加图片信息字段
        //声明pic字段，文件名为boris.png
        //[body appendFormat:[NSString stringWithFormat: @"Content-Disposition: form-data; name=\"File\"; filename=\"%@\"\r\n", [keys objectAtIndex:i]]];
        
        ////添加分界线，换行
        [imgbody appendFormat:@"%@\r\n",MPboundary];
        [imgbody appendFormat:@"Content-Disposition: form-data; name=\"File%d\"; filename=\"%@.jpg\"\r\n", i, [keys objectAtIndex:i]];
        //声明上传文件的格式
        [imgbody appendFormat:@"Content-Type: application/octet-stream; charset=utf-8\r\n\r\n"];
        
        NSLog(@"上传的图片：%d  %@", i, [keys objectAtIndex:i]);
        
        //将body字符串转化为UTF8格式的二进制
        //[myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
        [myRequestData appendData:[imgbody dataUsingEncoding:NSUTF8StringEncoding]];
        //将image的data加入
        [myRequestData appendData:data];
        [myRequestData appendData:[ @"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"%@\r\n",endMPboundary];
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //[request setValue:@"keep-alive" forHTTPHeaderField:@"connection"];
    //[request setValue:@"UTF-8" forHTTPHeaderField:@"Charsert"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    //http method
    [request setHTTPMethod:@"POST"];
    
    //建立连接，设置代理
    //NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    //设置接受response的data
    NSData *mResponseData;
    NSError *err = nil;
    mResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&err];
    
    if(mResponseData == nil){
        NSLog(@"err code : %@", [err localizedDescription]);
    }
    res = [[NSString alloc] initWithData:mResponseData encoding:NSUTF8StringEncoding];
    /*
     if (conn) {
     mResponseData = [NSMutableData data];
     mResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&err];
     
     if(mResponseData == nil){
     NSLog(@"err code : %@", [err localizedDescription]);
     }
     res = [[NSString alloc] initWithData:mResponseData encoding:NSUTF8StringEncoding];
     }else{
     res = [[NSString alloc] init];
     }*/
    NSLog(@"服务器返回：%@", res);
    return res;
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
