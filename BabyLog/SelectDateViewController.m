//
//  SelectDateViewController.m
//  BabyLog
//
//  Created by jiangbin on 15/6/20.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import "SelectDateViewController.h"
#import "NSDate+FSExtension.h"
#import "NSCalendar+FSExtension.h"
#import "ConstantDefine.h"
#import "ImageTool.h"

#define kPink [UIColor colorWithRed:198/255.0 green:51/255.0 blue:42/255.0 alpha:1.0]
#define kBlue [UIColor colorWithRed:71/255.0 green:167/255.0 blue:252/255.0 alpha:1.0]
#define kBlueText [UIColor colorWithRed:115/255.0 green:194/255.0 blue:225/255.0 alpha:1.0]

@interface SelectDateViewController ()
{
    NSString *selDate;
}

@end

@implementation SelectDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 30, 320, 280)];
    _calendar.dataSource = self;
    _calendar.delegate = self;
    [self.view addSubview:_calendar];
    self.calendar = _calendar;
    
    [_calendar setWeekdayTextColor:kBlueText];
    [_calendar setHeaderTitleColor:kBlueText];
    [_calendar setEventColor:[kBlueText colorWithAlphaComponent:0.75]];
    [_calendar setSelectionColor:kBlue];
    [_calendar setHeaderDateFormat:@"yyyy年MM月"];
    [_calendar setMinDissolvedAlpha:0.2];
    [_calendar setTodayColor:kPink];
    [_calendar setCellStyle:FSCalendarCellStyleCircle];
    
    UIImage *bgImg=[ImageTool createImageWithColor:[UIColor colorWithRed:51.0/255.0 green:172.0/255.0 blue:236.0/255.0 alpha:0.9] rect:CGRectMake(0, 0, 9, 9)];
    UIButton * okBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame=CGRectMake(25, _calendar.frame.origin.y+_calendar.frame.size.height+25, SCREEN_WIDTH/2-35, 35);
    [okBtn setBackgroundImage:bgImg forState:UIControlStateNormal];
    okBtn.layer.cornerRadius=2;
    okBtn.layer.masksToBounds=YES;
    [okBtn setTitle:@"选择" forState:UIControlStateNormal];
    
    [okBtn addTarget:self action:@selector(selectDate) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:okBtn];
    
    UIButton * cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame=CGRectMake(SCREEN_WIDTH/2+10, _calendar.frame.origin.y+_calendar.frame.size.height+25, SCREEN_WIDTH/2-35, 35);
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

#pragma mark - 选择

- (void)selectDate
{    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectDate" object: selDate];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 取消

- (void)exit
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - FSCalendarDataSource
//
//- (NSString *)calendar:(FSCalendar *)calendarView subtitleForDate:(NSDate *)date
//{
//    if (!_lunar) {
//        return nil;
//    }
//    _lunarDate = [[SSLunarDate alloc] initWithDate:date calendar:_currentCalendar];
//    return _lunarDate.dayString;
//}
//
//- (BOOL)calendar:(FSCalendar *)calendarView hasEventForDate:(NSDate *)date
//{
//    return date.fs_day == 3;
//}

//- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
//{
//    return [NSDate fs_dateWithYear:2015 month:3 day:1];
//}
//
//- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
//{
//    return [NSDate fs_dateWithYear:2015 month:7 day:30];
//}

#pragma mark - FSCalendarDelegate
//
//- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date
//{
//    BOOL shouldSelect = date.fs_day != 7;
//    if (!shouldSelect) {
//        [[[UIAlertView alloc] initWithTitle:@"FSCalendar"
//                                    message:[NSString stringWithFormat:@"FSCalendar delegate forbid %@  to be selected",[date fs_stringWithFormat:@"yyyy/MM/dd"]]
//                                   delegate:nil
//                          cancelButtonTitle:@"OK"
//                          otherButtonTitles:nil, nil] show];
//    }
//    return shouldSelect;
//}
//
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date
{
    selDate = [date fs_stringWithFormat:@"yyyy-MM-dd"];
}
//
//- (void)calendarCurrentMonthDidChange:(FSCalendar *)calendar
//{
//    NSLog(@"did change to month %@",[calendar.currentMonth fs_stringWithFormat:@"MMMM yyyy"]);
//}

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
