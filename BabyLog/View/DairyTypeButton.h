//
//  DairyTypeButton.h
//  BabyLog
//
//  Created by jiangbin on 15/6/28.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DairyTypeButton : UIButton

@property (nonatomic, retain)NSString *dairyTypeId;
@property (nonatomic ,retain)NSString *diaryTypeName;

-(void)loadData;

@end
