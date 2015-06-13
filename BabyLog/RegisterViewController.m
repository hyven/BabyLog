//
//  RegisterViewController.m
//  BabyLog
//
//  Created by 恒昊 on 15-6-1.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import "RegisterViewController.h"
#import "ConstantDefine.h"

@interface RegisterViewController ()

@property (nonatomic ,retain)UITextField *userTextField;
@property (nonatomic ,retain)UITextField *passwordTextField;
@property (nonatomic ,retain)UITextField *confirmPasswordTF;
@property (nonatomic ,retain)UITextField *emailTextField;
@property (nonatomic ,retain)UISwitch *userTypeSwitch;
@property (nonatomic ,retain)UILabel *switchLabel;
@property (nonatomic ,retain)WebServicesManagement * webService;
@property (nonatomic ,retain)MBProgressHUD * hud;

@end

@implementation RegisterViewController

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
   
    
    UIImageView *backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Default"]];
    backImage.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:backImage];
    
    _userTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 104, 280, 35)];
    _userTextField.borderStyle = UITextBorderStyleRoundedRect;
    _userTextField.placeholder = @"请输入用户名";
    _userTextField.autocapitalizationType = UITextAutocapitalizationTypeNone; 
    [self.view addSubview:_userTextField];
    
    _passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 144, 280, 35)];
    _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    _passwordTextField.placeholder = @"请输入密码";
    _passwordTextField.secureTextEntry = YES;
    [self.view addSubview:_passwordTextField];
    
    _confirmPasswordTF = [[UITextField alloc]initWithFrame:CGRectMake(20, 184, 280, 35)];
    _confirmPasswordTF.borderStyle = UITextBorderStyleRoundedRect;
    _confirmPasswordTF.placeholder = @"请再次确认密码";
    _confirmPasswordTF.secureTextEntry = YES;
    [self.view addSubview:_confirmPasswordTF];
    
    _emailTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 224, 280, 35)];
    _emailTextField.borderStyle = UITextBorderStyleRoundedRect;
    _emailTextField.placeholder = @"请输入邮箱";
    _emailTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
    [self.view addSubview:_emailTextField];
    
    _userTypeSwitch = [[UISwitch alloc]init];
    _userTypeSwitch.frame = CGRectMake(20, 294, 40, 20);
    _userTypeSwitch.on = NO;
    [_userTypeSwitch addTarget:self action:@selector(changeUserType) forControlEvents:UIControlEventTouchUpInside];
    
    _switchLabel = [[UILabel alloc]init];
    _switchLabel.text = @"家长账户";
    _switchLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
    _switchLabel.frame = CGRectMake(80, 294, 100, 30);
    [self.view addSubview:_switchLabel];
    
    [self.view addSubview:_userTypeSwitch];
    
    //按钮
    UIButton *regBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    regBtn.frame = CGRectMake(20, 344, 280, 40);
    [regBtn setBackgroundImage:[UIImage imageNamed:@"regist_save"] forState:UIControlStateNormal];
//    [regBtn setBackgroundImage:[UIImage imageNamed:@"login_bg_big_on"] forState:UIControlStateHighlighted];
//    [regBtn setTitle:@"创建新用户" forState:UIControlStateNormal];
    
    [regBtn addTarget:self action:@selector(registerUser) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:regBtn];
    
    UISwipeGestureRecognizer * rightSwipeGestureRecognizer=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe)];
    rightSwipeGestureRecognizer.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipeGestureRecognizer];

}

#pragma mark - Initialization

-(WebServicesManagement *)webService
{
    if (!_webService) {
        _webService = [[WebServicesManagement alloc] init];
        [_webService initNetworkQueue];
        _webService.delegate = self;
    }
    return _webService;
    
}

- (MBProgressHUD *)hud
{
    if (!_hud) {
        _hud = [[MBProgressHUD alloc] initWithView:self.view];
        _hud.minSize = CGSizeMake(10.0f, 120.0f);
    }
    return _hud;
}

#pragma mark 注册方法

-(void)registerUser
{
    if ([self.webService isNetworkAvaliable]) {
        if ([self.userTextField.text isEqualToString:@""]||[self.passwordTextField.text isEqualToString:@""]||[self.confirmPasswordTF.text isEqualToString:@""]) {
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"您有未填写的信息，请重试"];
        }
        else{
            //用户名长度限制
            NSString *str = self.userTextField.text;
            NSInteger length = 0;
            for(int i=0; i< [str length];i++){
                int a = [str characterAtIndex:i];
                if( a >= 0x4e00 && a <= 0x9fff)
                    length += 2;
                else length += 1;
            }
            if (length < 6) {
                [[TKAlertCenter defaultCenter] postAlertWithMessage:@"用户名过短(6-20个英文字符或3-10中文字符)"];
                return;
            }
            if (length > 20) {
                [[TKAlertCenter defaultCenter] postAlertWithMessage:@"用户名超出字数限制(6-20个英文字符或3-x`中文字符)"];
                return;
            }
            //用户名不包括特殊字符
            NSRange urgentRange = [str rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @" ~￥#&*<>《》-()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€;,.，。:：、？?!！\"“”'%"]];
            if (urgentRange.location != NSNotFound)
            {
                [[TKAlertCenter defaultCenter] postAlertWithMessage:@"用户名只包含字符、数字、下划线"];
                return;
            }
            
            //密码长度在6-20
            if (self.passwordTextField.text.length < 6 || self.passwordTextField.text.length > 20) {
                [[TKAlertCenter defaultCenter] postAlertWithMessage:@"密码长度为6~20个字符"];
                return;
            }
            
            //密码两次输入一致
            if (![self.passwordTextField.text isEqualToString:self.confirmPasswordTF.text]) {
                [[TKAlertCenter defaultCenter] postAlertWithMessage:@"两次输入的密码不一致，请重试"];
                return;
            }
            
            APIService * service=[[APIService alloc]init];
            service.delegate=self;
            [service userRegisterWithUserName:self.userTextField.text password:self.passwordTextField.text email:self.emailTextField.text shenfen:(self.userTypeSwitch.on ? @"2" : @"1")];
            
        }
        
        if ((self.view.frame.origin.y < 0)&&(SCREEN_HEIGHT==480))
        {
            [UIView animateWithDuration:0.3f animations:^{
                
                self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+70, self.view.frame.size.width, self.view.frame.size.height);
            }];
        }
        [self.confirmPasswordTF resignFirstResponder];
        [self.userTextField resignFirstResponder];
        [self.passwordTextField resignFirstResponder];
        [self.emailTextField resignFirstResponder];
    }
    else {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"网络连接已断开"];
    }
    
}

#pragma mark 回调函数

-(void) userRegisterCallBack:(APIResult *)result
{
    if (result.statusCode == 200) {
        self.hud=[[MBProgressHUD alloc]initWithView:self.view];
        [self.hud show:YES];
        [self.view addSubview:self.hud];
        self.hud.labelText=@"注册成功,请登录";
        self.hud.mode=MBProgressHUDModeCustomView;
        self.hud.customView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"finish_bg"]];
        [self.hud showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
        MBProgressHUD * objectProgressHud=self.hud;
        
        //通知中心NSNotificationCenter
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RegistSuccess" object:objectProgressHud];
        [[self navigationController] popViewControllerAnimated:YES];
    }
    else if (result.statusCode == 1003)
    {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:result.error];
    }
    else
    {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"注册失败,请重试"];
    }
}

-(void)myTask
{
    sleep(1);
}

#pragma mark 页面效果

-(void)changeUserType
{
    if(_userTypeSwitch.on)
    {
        _switchLabel.text = @"教师账户";
    }
    else
    {
        _switchLabel.text = @"家长账户";
    }
}

// touch事件  点击屏幕键盘收回
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.confirmPasswordTF resignFirstResponder];
    [self.userTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];

}

//右划返回上级页面
-(void)rightSwipe
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.navigationItem setTitle: @"用户注册"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"regist_nav_bg"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                    [UIColor whiteColor],
                    NSForegroundColorAttributeName,nil]];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 39, 39)];
    [backButton setImage:[UIImage imageNamed:@"regist_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backPop) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backBarButton;

    
//    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, 320, 20)];
//    statusBarView.backgroundColor=[UIColor whiteColor];
//    [self.navigationController.navigationBar addSubview:statusBarView];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

-(void)backPop
{
    [self.navigationController popViewControllerAnimated:YES];
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
