//
//  BaseViewController.h
//  BabyLog
//
//  Created by jiangbin on 15/6/27.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavBarView.h"
#import "ConstantDefine.h"

@interface BaseViewController : UIViewController<NavBarDelegate>

@property(nonatomic, retain) NavBarView *navbar;


@end
