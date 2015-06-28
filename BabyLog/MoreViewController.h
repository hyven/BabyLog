//
//  MoreViewController.h
//  BabyLog
//
//  Created by 恒昊 on 15-5-28.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIService.h"
#import "AppDelegate.h"
#import "NavBarView.h"
#import "BaseViewController.h"

@interface MoreViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,BabyLogAPIServiceDelegate, NavBarDelegate>

@end
