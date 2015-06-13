//
//  LoginViewController.m
//  BabyLog
//
//  Created by 恒昊 on 15-5-27.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"
#import "ConstantDefine.h"

@interface LoginViewController ()

@property (nonatomic ,retain)UITextField *userTextField;
@property (nonatomic ,retain)UITextField *passwordTextField;
@property (nonatomic ,retain)UICheckbox *rememberme;

@property (nonatomic ,retain)RegisterViewController *registerVC;

@end

@implementation LoginViewController
{
    MainViewController *mainViewController;
    NSString *passwordStr;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        mainViewController = [MainViewController shareMainContainer];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Default"]]];
    UIImageView *backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_bg"]];
    backImage.frame = CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:backImage];
    
    userNameStr = [[NSUserDefaults standardUserDefaults]valueForKey:@"userName"];
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"remember"] boolValue]) {
        passwordStr = [[NSUserDefaults standardUserDefaults]valueForKey:@"password"];
    }
    else
    {
        passwordStr = @"";
    }
    
    NSInteger wucha = 0;
    if (SCREEN_HEIGHT==480) {
    }
    else
    {
        wucha = 46;
    }
    
    _userTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 210 + wucha, 280, 35)];
    _userTextField.borderStyle = UITextBorderStyleRoundedRect;
    _userTextField.placeholder = @"请输入用户名";
    _userTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    if (![userNameStr isEqual:@""]) {
        _userTextField.text = userNameStr;
    }
    [self.view addSubview:_userTextField];
    
    _passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 250 + wucha, 280, 35)];
    _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    _passwordTextField.placeholder = @"请输入密码";
    _passwordTextField.secureTextEntry = YES;
    if (![passwordStr isEqual:@""]) {
        _passwordTextField.text = passwordStr;
    }
    [self.view addSubview:_passwordTextField];
    
    _rememberme = [[UICheckbox alloc]initWithTitle:@"记住密码" ischecked:YES];
    _rememberme.frame = CGRectMake(20, 295 + wucha, 280, 30);
    [self.view addSubview:_rememberme];
    
    //按钮
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(20, 330 + wucha, 280, 40);
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"login_button"] forState:UIControlStateNormal];
//    [loginBtn setBackgroundImage:[UIImage imageNamed:@"login_bg_big_on"] forState:UIControlStateHighlighted];
//    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    
    [loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(20, 375 + wucha, 280, 40);
    [registerBtn setBackgroundImage:[UIImage imageNamed:@"regist_save"] forState:UIControlStateNormal];
//    [registerBtn setBackgroundImage:[UIImage imageNamed:@"login_bg_big_on"] forState:UIControlStateHighlighted];
//    [registerBtn setTitle:@"注册新用户" forState:UIControlStateNormal];
    
    [registerBtn addTarget:self action:@selector(registerNew) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    
    UIButton *helpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    helpBtn.frame = CGRectMake(20, 420+wucha, 280, 30);
    [helpBtn setImage:[UIImage imageNamed:@"help01"] forState:UIControlStateNormal];
    [helpBtn setTitle:@"儿童急救知识" forState:UIControlStateNormal];
    [helpBtn setTintColor:[UIColor whiteColor]];
    [helpBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15.0f]];
    
    [self.view addSubview:helpBtn];
     
}

#pragma mark 响应通知中心NSNotificationCenter

// touch事件  点击屏幕键盘收回
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.userTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

//登录按钮事件
- (void)login
{
    
    [self.passwordTextField resignFirstResponder];
    [self.userTextField resignFirstResponder];
    
    if (![ReachTool checkReachable]) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"请检查您的网络连接"];
        return;
    }
        
    APIService * service = [[APIService alloc] init];
    service.delegate = self;
    [service userLoginWithUserName:self.userTextField.text password:self.passwordTextField.text];
}

//注册按钮事件 - 跳转到注册页面
-(void) registerNew
{
    _registerVC = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:_registerVC animated:YES];
}

#pragma mark 回调函数

//登录接口回调函数
-(void) userLoginCallBack:(APIResult *)result
{
    if (result.statusCode == 200) {
        tokenStr=result.token;
        userNameStr=self.userTextField.text;
        [[NSUserDefaults standardUserDefaults] setValue:tokenStr forKey:@"userToken"];
        [[NSUserDefaults standardUserDefaults] setValue:userNameStr forKey:@"userName"];
        [[NSUserDefaults standardUserDefaults] setValue:self.passwordTextField.text forKey:@"password"];
        [[NSUserDefaults standardUserDefaults] setValue:
                    [NSString stringWithFormat:@"%d", self.rememberme.selected] forKey:@"remember"];

        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccess" object:nil];
        
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"登陆成功"];
        [self.navigationController pushViewController:mainViewController animated:YES];
    }
    else
    {   tokenStr=@"";
        userNameStr=@"";
        [[TKAlertCenter defaultCenter] postAlertWithMessage:result.error];
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
