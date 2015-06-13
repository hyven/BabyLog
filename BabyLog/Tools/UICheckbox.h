//
//  UICheckbox.h
//  BabyLog
//
//  Created by 恒昊 on 15-6-2.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICheckbox : UIButton
//@property BOOL isSelected;

-(id)initWithTitle:(NSString*)title ischecked:(BOOL) checked;
-(void)setChecked:(BOOL)flag;
-(void)checked;

@end
