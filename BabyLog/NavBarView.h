//
//  NavBarView.h
//  BabyLog
//
//  Created by jiangbin on 15/6/22.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

@protocol NavBarDelegate;

#import <UIKit/UIKit.h>

@interface NavBarView : UIView

@property(nonatomic, retain)UINavigationController *navController;
@property(nonatomic,assign) id<NavBarDelegate> delegate;

-(void)setDateStr:(NSString*)dateStr;

@end


@protocol NavBarDelegate <NSObject>

@optional

-(UINavigationController *)setSuperViewNavigationController;
-(void)TouchRightButton;

@end