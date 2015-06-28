//
//  DairyTypeButton.m
//  BabyLog
//
//  Created by jiangbin on 15/6/28.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import "DairyTypeButton.h"

@implementation DairyTypeButton
{
    UILabel *diaryTypeNameLable;
    UIImageView * diaryTypeImgView;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        diaryTypeImgView = [[UIImageView alloc]init];
        diaryTypeImgView.frame = CGRectMake(20, 5, 60, 60);
        
        diaryTypeNameLable = [[UILabel alloc]init];
        diaryTypeNameLable.frame = CGRectMake(0, 65, 100, 20);
        [diaryTypeNameLable setTextAlignment:NSTextAlignmentCenter];
        diaryTypeNameLable.font = [UIFont systemFontOfSize:12.0f];
        
        [self addSubview:diaryTypeNameLable];
        [self addSubview:diaryTypeImgView];
    }
    return self;
}

-(void)loadData
{
    UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"diary_%@", self.dairyTypeId]];
    diaryTypeImgView.image = img;
    
    diaryTypeNameLable.text = self.diaryTypeName;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
