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
        
        self.timeLable = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 80, 20)];
        self.timeLable.font = [UIFont systemFontOfSize:14.0f];
        [self.timeLable setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:self.timeLable];
        
        self.nameLable = [[UILabel alloc]initWithFrame:CGRectMake(90, 0, 140, 20)];
        self.nameLable.font = [UIFont systemFontOfSize:14.0f];
        [self.nameLable setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:self.nameLable];
        
        self.diaryTypeImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 25, 45, 45)];
        [self.diaryTypeImgView setImage:[UIImage imageNamed:@""]];
        [self.contentView addSubview:self.diaryTypeImgView];
        
        self.rankImgView = [[UIImageView alloc]initWithFrame:CGRectMake(230, 5, 80, 16)];
        [self.rankImgView setImage:[UIImage imageNamed:@"start_5"]];
        [self.contentView addSubview:self.rankImgView];
    
        self.delImgView = [[UIImageView alloc]initWithFrame:CGRectMake(244, 32, 35, 35)];
        [self.delImgView setImage:[UIImage imageNamed:@"system_del"]];
        [self.contentView addSubview:self.delImgView];
        
        UIImageView *picCountImgView = [[UIImageView alloc]initWithFrame:CGRectMake(282, 37, 25, 25)];
        [picCountImgView setImage:[UIImage imageNamed:@"pic_count"]];
        [self.contentView addSubview:picCountImgView];
        
        self.picCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(282, 37, 25, 25)];
        [self.picCountLabel setTextColor:[UIColor blackColor]];
        [self.picCountLabel setTextAlignment:NSTextAlignmentCenter];
        self.picCountLabel.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:self.picCountLabel];

        
        UIImageView *spview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH, 5)];
        spview.backgroundColor = TABLEVIEWCELL_BACKGROUN_COLOR;
        [self.contentView addSubview:spview];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
