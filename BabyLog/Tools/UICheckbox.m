//
//  UICheckbox.m
//  BabyLog
//
//  Created by 恒昊 on 15-6-2.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import "UICheckbox.h"

@implementation UICheckbox

- (instancetype)initWithTitle:(NSString *)title ischecked:(BOOL)checked
{
    self = [super init];
    if(self){
        [self setTitle:title forState:UIControlStateNormal];
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        self.selected = checked;
        [self setChecked:self.selected];
        [self addTarget:self action:@selector(checked) forControlEvents: UIControlEventTouchUpInside];

    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setChecked:(BOOL)flag
{
    if (flag != self.selected) {
        self.selected = flag;
    }
    if (self.selected) {
        [self setImage:[UIImage imageNamed:@"checkbox_on"] forState:UIControlStateSelected];
    }
    else
    {
        [self setImage:[UIImage imageNamed:@"checkbox_off"] forState:UIControlStateNormal];
    }
}

-(void)checked
{
    [self setChecked: !self.selected];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
