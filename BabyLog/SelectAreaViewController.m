//
//  SelectAreaViewController.m
//  BabyLog
//
//  Created by jiangbin on 15/6/18.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import "SelectAreaViewController.h"
#import "ConstantDefine.h"
#import "ImageTool.h"

@interface SelectAreaViewController ()
{
    UIPickerView *btPicker;
    NSArray *provinces, *cities, *areas;
    NSString *sp, *sc, *sa;
    
}

@end

@implementation SelectAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(25, 30, SCREEN_WIDTH/2, 30)];
    label.backgroundColor=[UIColor clearColor];
    label.font=[UIFont boldSystemFontOfSize:16];
    label.text=@"请选择地区";
    [self.view addSubview:label];
    
    btPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(25,80,SCREEN_WIDTH-50,100)];
    btPicker.dataSource=self;
    btPicker.delegate=self;
    btPicker.layer.borderColor=[[UIColor colorWithWhite:0.6 alpha:1.0] CGColor];
    btPicker.layer.borderWidth=0.5;
    btPicker.layer.cornerRadius=2;
    btPicker.layer.masksToBounds=YES;
    [self.view addSubview:btPicker];
    /*加载数据*/
    provinces = [[NSArray alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil]];
    cities = [[provinces objectAtIndex:0] objectForKey:@"cities"];
    areas = [[cities objectAtIndex:0] objectForKey:@"areas"];
    
    UIImage *bgImg=[ImageTool createImageWithColor:[UIColor colorWithRed:51.0/255.0 green:172.0/255.0 blue:236.0/255.0 alpha:0.9] rect:CGRectMake(0, 0, 9, 9)];
    
    UIButton * okBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame=CGRectMake(25, btPicker.frame.origin.y+btPicker.frame.size.height+25, SCREEN_WIDTH/2-35, 35);
    [okBtn setBackgroundImage:bgImg forState:UIControlStateNormal];
    okBtn.layer.cornerRadius=2;
    okBtn.layer.masksToBounds=YES;
    [okBtn setTitle:@"选择" forState:UIControlStateNormal];
    
    [okBtn addTarget:self action:@selector(selectArea) forControlEvents:UIControlEventTouchUpInside];
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
    switch (component) {
        case 0:
            return [[provinces objectAtIndex:row] objectForKey:@"state"];
            break;
        case 1:
            return [[cities objectAtIndex:row] objectForKey:@"city"];
            break;
        case 2:
            if ([areas count] > 0) {
                return [areas objectAtIndex:row];
                break;
            }
        default:
            return  @"";
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            cities = [[provinces objectAtIndex:row] objectForKey:@"cities"];
            [btPicker selectRow:0 inComponent:1 animated:YES];
            [btPicker reloadComponent:1];
            
            areas = [[cities objectAtIndex:0] objectForKey:@"areas"];
            [btPicker selectRow:0 inComponent:2 animated:YES];
            [btPicker reloadComponent:2];
            
            sp = [[provinces objectAtIndex:row] objectForKey:@"state"];
            sc = [[cities objectAtIndex:0] objectForKey:@"city"];
            if ([areas count] > 0) {
                sa = [areas objectAtIndex:0];
            } else{
                sa = @"";
            }
            break;
        case 1:
            areas = [[cities objectAtIndex:row] objectForKey:@"areas"];
            [btPicker selectRow:0 inComponent:2 animated:YES];
            [btPicker reloadComponent:2];
            
            sc = [[cities objectAtIndex:0] objectForKey:@"city"];
            if ([areas count] > 0) {
                sa = [areas objectAtIndex:0];
            } else{
                sa = @"";
            }
            break;
        case 2:
            if ([areas count] > 0) {
                sa = [areas objectAtIndex:0];
            } else{
                sa = @"";
            }
            break;
        default:
            break;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
          forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = view ? (UILabel *) view : [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, (SCREEN_WIDTH-50)/3,20.0f)];
    
    NSString *title = [self pickerView:pickerView titleForRow:row forComponent:component];
    label.text = title;
    [label setFont:[UIFont systemFontOfSize: 18]];
    label.backgroundColor = [UIColor clearColor];
    
    return label;
}


#pragma mark - DataSource协议的方法

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    switch (component) {
        case 0:
            return [provinces count];
            break;
        case 1:
            return [cities count];
            break;
        case 2:
            return [areas count];
            break;
        default:
            return 0;
            break;
    }
}

#pragma mark - 选择

- (void)selectArea
{
    NSArray *area = [[NSArray alloc]initWithObjects:sp, sc, sa, nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectArea" object: area];
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
