//
//  NavBarView.m
//  BabyLog
//
//  Created by jiangbin on 15/6/22.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import "NavBarView.h"
#import "ConstantDefine.h"
#import "BabyConfigViewController.h"

@implementation NavBarView
{
    UIButton *right;
    UIButton *left;
}

-(id)init
{
    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"regist_nav_bg"]]];
        
        /*左边按钮*/
        left = [UIButton buttonWithType:UIButtonTypeCustom];
        [left setFrame:CGRectMake(0, 6, 160, 30)];
        
//        NSString *headImgStr = [[NSUserDefaults standardUserDefaults] valueForKey: @"HeadImg"];
//        NSString *rurl = [headImgStr stringByReplacingOccurrencesOfString:@"~/" withString:HTTP_HEADER];
//        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:rurl]];
//        UIImage *headImg =[UIImage imageWithData:data];
//        [left setImage:headImg forState:UIControlStateNormal];
        left.imageEdgeInsets = UIEdgeInsetsMake(0,10,0,120);
//
//        NSString *nickName = [[NSUserDefaults standardUserDefaults] valueForKey:@"nickName"];
//        [left setTitle:[NSString stringWithFormat:@"宝贝：%@", nickName] forState:UIControlStateNormal];
        [left.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        left.titleEdgeInsets = UIEdgeInsetsMake(0, -115, 0, 0);
        
        [left addTarget:self action:@selector(leftto) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:left];
        
        /*右边按钮*/
        NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"YYYY-MM-dd"];
        NSString * locationString=[dateformatter stringFromDate:[NSDate date]];
        
        right = [UIButton buttonWithType:UIButtonTypeCustom];
        [right setFrame:CGRectMake(180, 6, 140, 30)];
        [right.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [right setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [right setTitle:locationString forState:UIControlStateNormal];
        right.titleEdgeInsets = UIEdgeInsetsMake(0, -60, 0, 0);
        
        [right setImage:[UIImage imageNamed:@"diarylist_date"] forState:UIControlStateNormal];
        right.imageEdgeInsets = UIEdgeInsetsMake(0,100,0,10);
        [right addTarget:self action:@selector(rigthto) forControlEvents:UIControlEventTouchUpInside];

        
        [self addSubview:right];

    }
    return self;
}

-(void)leftto
{
    self.navController = [self.delegate setSuperViewNavigationController];
    BabyConfigViewController *bivc = [[BabyConfigViewController alloc]init];
    [self.navController pushViewController:bivc animated:YES];
}

-(void)rigthto
{
    [self.delegate TouchRightButton];
}

-(void)setDateStr:(NSString*)dateStr
{
    [right setTitle:dateStr forState:UIControlStateNormal];
}

-(void)reloadBabyInfo
{
    NSString *nickName = [[NSUserDefaults standardUserDefaults] valueForKey:@"nickName"];
    [left setTitle:[NSString stringWithFormat:@"宝贝：%@", nickName] forState:UIControlStateNormal];
    
    NSString *headImgStr = [[NSUserDefaults standardUserDefaults] valueForKey: @"HeadImg"];
    NSString *rurl = [headImgStr stringByReplacingOccurrencesOfString:@"~/" withString:HTTP_HEADER];
    NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:rurl]];
    UIImage *headImg =[UIImage imageWithData:data];
    [left setImage:headImg forState:UIControlStateNormal];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
