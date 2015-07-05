//
//  SelectDairyTypeViewController.m
//  BabyLog
//
//  Created by jiangbin on 15/6/28.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import "SelectDairyTypeViewController.h"
#import "ConstantDefine.h"

@interface SelectDairyTypeViewController ()
@end

@implementation SelectDairyTypeViewController
{
    UITableView *typeTV;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _dairyType = [[NSArray alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"diaryType.plist" ofType:nil]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1]];
    
    typeTV = [[UITableView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20,SCREEN_HEIGHT) style:UITableViewStylePlain];
    typeTV.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    typeTV.tableFooterView = [[UIView alloc] init];
    typeTV.delegate=self;
    typeTV.dataSource=self;
    typeTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    typeTV.showsVerticalScrollIndicator=YES;
    [self.view addSubview:typeTV];
    
}

-(void)selectDairyType:(NSString *)dairyTypeId andName:(NSString *)dairyTypeName
{
    NSArray *selectType = [[NSArray alloc]initWithObjects:dairyTypeId, dairyTypeName, nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectCreateDiaryType" object: selectType];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)selectDairyTypeButton:(id)sender
{
    DairyTypeButton *button = (DairyTypeButton *)sender;
    [self selectDairyType:button.dairyTypeId andName:button.diaryTypeName];
}

#pragma mark tableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger num = (_dairyType.count / 3) + ((_dairyType.count % 3) > 0 ? 1 : 0);
    return num;
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
    
    NSInteger startIndex = indexPath.row * 3;
    for (NSInteger i = 0; i < 3; i++) {
        NSInteger index = i + startIndex;
        if (index < _dairyType.count) {
            DairyTypeButton *tb = [[DairyTypeButton alloc]initWithFrame:CGRectMake(i * 100, 0, 100, 80)];
            tb.dairyTypeId = [[_dairyType objectAtIndex:index]objectForKey:@"key"];
            tb.diaryTypeName =[[_dairyType objectAtIndex:index]objectForKey:@"name"];
            [tb loadData];
            [cell addSubview:tb];
            [tb addTarget:self action:@selector(selectDairyTypeButton:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
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
    [self.navigationItem setTitle: @"选择作息类型"];
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
