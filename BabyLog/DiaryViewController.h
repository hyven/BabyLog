//
//  LogViewController.h
//  BabyLog
//
//  Created by 恒昊 on 15-5-27.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIService.h"
#import "NavBarView.h"
#import "BaseViewController.h"

@interface DiaryViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,BabyLogAPIServiceDelegate, NavBarDelegate>
{
    UITableView * dataTable;
    NSMutableArray * sections;
    NSMutableArray * dataArray;
}

@property (nonatomic ,assign)NSString *day;


@end
