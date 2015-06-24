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

@interface DiaryViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,BabyLogAPIServiceDelegate, NavBarDelegate>
{
    UITableView * dataTable;
    NSMutableArray * sections;
    NSMutableArray * dataArray;
//    UIColor * headerViewBg;
}

@property (nonatomic ,assign)NSString *day;


@end
