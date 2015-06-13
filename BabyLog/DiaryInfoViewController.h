//
//  DiaryInfoViewController.h
//  BabyLog
//
//  Created by jiangbin on 15/6/7.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIService.h"

@interface DiaryInfoViewController : UIViewController<UIScrollViewDelegate,BabyLogAPIServiceDelegate>

@property (nonatomic ,retain) UIScrollView *scrollView;
@property (retain, nonatomic) UIPageControl *pageControl;

@property (nonatomic ,assign) int diaryId;
@property (nonatomic ,retain) NSMutableArray *picList;

@end
