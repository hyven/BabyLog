//
//  SelectDateViewController.h
//  BabyLog
//
//  Created by jiangbin on 15/6/20.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSCalendar.h"

@interface SelectDateViewController : UIViewController<FSCalendarDataSource, FSCalendarDelegate>

@property(nonatomic, retain) FSCalendar *calendar;

@end
