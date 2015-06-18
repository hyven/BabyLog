//
//  SelectBloodTypeViewController.m
//  BabyLog
//
//  Created by jiangbin on 15/6/16.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import "SelectBloodTypeViewController.h"
#import "ConstantDefine.h"
#import "ImageTool.h"

@interface SelectBloodTypeViewController ()
{
    UIPickerView *btPicker;
    NSMutableArray *itemsArray;

}

@end

@implementation SelectBloodTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    itemsArray = [NSMutableArray arrayWithObjects:@"O",@"A",@"B",@"AB", nil];

    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(25, 30, SCREEN_WIDTH/2, 30)];
    label.backgroundColor=[UIColor clearColor];
    label.font=[UIFont boldSystemFontOfSize:16];
    label.text=@"请选择血型";
    [self.view addSubview:label];
    
    btPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(25,80,SCREEN_WIDTH-50,100)];
    btPicker.dataSource=self;
    btPicker.delegate=self;
    btPicker.layer.borderColor=[[UIColor colorWithWhite:0.6 alpha:1.0] CGColor];
    btPicker.layer.borderWidth=0.5;
    btPicker.layer.cornerRadius=2;
    btPicker.layer.masksToBounds=YES;
    [self.view addSubview:btPicker];
    
    UIImage *bgImg=[ImageTool createImageWithColor:[UIColor colorWithRed:51.0/255.0 green:172.0/255.0 blue:236.0/255.0 alpha:0.9] rect:CGRectMake(0, 0, 9, 9)];
    
    UIButton * okBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame=CGRectMake(25, btPicker.frame.origin.y+btPicker.frame.size.height+25, SCREEN_WIDTH/2-35, 35);
    [okBtn setBackgroundImage:bgImg forState:UIControlStateNormal];
    okBtn.layer.cornerRadius=2;
    okBtn.layer.masksToBounds=YES;
    [okBtn setTitle:@"选择" forState:UIControlStateNormal];
    
    [okBtn addTarget:self action:@selector(selectBloodType) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:okBtn];
    
    UIButton * cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame=CGRectMake(SCREEN_WIDTH/2+10, btPicker.frame.origin.y+btPicker.frame.size.height+25, SCREEN_WIDTH/2-35, 35);
    cancelBtn.backgroundColor=[ImageTool createColor:@"ffb2e7ed"];
    cancelBtn.layer.cornerRadius=2;
    cancelBtn.layer.masksToBounds=YES;
    [cancelBtn addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    
    UILabel *cancelLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2-35, 35)];
    cancelLabel.backgroundColor=[UIColor clearColor];
    cancelLabel.textColor=[ImageTool createColor:@"ff0b6fa5"];
    cancelLabel.font=[UIFont boldSystemFontOfSize:17];
    cancelLabel.text=@"取消";
    
    cancelLabel.textAlignment=NSTextAlignmentCenter;
    [cancelBtn addSubview:cancelLabel];

}


#pragma mark - Delegate协议的方法

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [itemsArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
}

#pragma mark - DataSource协议的方法

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [itemsArray count];
}

#pragma mark - 选择

- (void)selectBloodType
{
    int row=(int)[btPicker selectedRowInComponent:0];
    NSString *bt=[NSString stringWithFormat:@"%i",row];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectBloodType" object: bt];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 取消

- (void)exit
{
    [self.navigationController popViewControllerAnimated:YES];
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
