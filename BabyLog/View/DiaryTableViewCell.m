//
//  DiaryTableViewCell.m
//  BabyLog
//
//  Created by jiangbin on 15/6/6.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import "DiaryTableViewCell.h"
#import "ConstantDefine.h"

@implementation DiaryTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    // Initialization code
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.timeLable = [[UILabel alloc]initWithFrame:CGRectMake(69, 7, 80, 14)];
        self.timeLable.font = [UIFont systemFontOfSize:14.0f];
        [self.timeLable setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:self.timeLable];
        
        self.nameLable = [[UILabel alloc]initWithFrame:CGRectMake(69, 26, 140, 14)];
        self.nameLable.font = [UIFont systemFontOfSize:14.0f];
        [self.nameLable setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:self.nameLable];
        
        self.diaryTypeImgView = [[UIImageView alloc]initWithFrame:CGRectMake(7, 7, 55, 55)];
        [self.diaryTypeImgView setImage:[UIImage imageNamed:@""]];
        [self.contentView addSubview:self.diaryTypeImgView];
        
        self.rankImgView = [[UIImageView alloc]initWithFrame:CGRectMake(205, 7, 110, 20)];
        [self.rankImgView setImage:[UIImage imageNamed:@"start_5"]];
        [self.contentView addSubview:self.rankImgView];
    
        self.delImgView = [UIButton buttonWithType:UIButtonTypeCustom];
        self.delImgView.frame =CGRectMake(290, 38, 16, 18);
        [self.delImgView setImage:[UIImage imageNamed:@"Shancu"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.delImgView];
        
        self.picCountImgView = [[UIImageView alloc]init];
        self.picCountImgView.frame =CGRectMake(240, 37, 25, 20);
        [self.picCountImgView setImage:[UIImage imageNamed:@"Tupian-Blue"]];
        [self.contentView addSubview:self.picCountImgView];
//        
//        self.picCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(282, 37, 25, 25)];
//        [self.picCountLabel setTextColor:[UIColor blackColor]];
//        [self.picCountLabel setTextAlignment:NSTextAlignmentCenter];
//        self.picCountLabel.font = [UIFont systemFontOfSize:14.0f];
//        [self.contentView addSubview:self.picCountLabel];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
