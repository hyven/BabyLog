//
//  SelectDairyTypeViewController.h
//  BabyLog
//
//  Created by jiangbin on 15/6/28.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DairyTypeButton.h"

@interface SelectDairyTypeViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, retain)NSArray *dairyType;

@end
