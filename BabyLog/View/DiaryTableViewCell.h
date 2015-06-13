//
//  DiaryTableViewCell.h
//  BabyLog
//
//  Created by jiangbin on 15/6/6.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiaryTableViewCell : UITableViewCell

@property (nonatomic ,retain)UILabel *timeLable;
@property (nonatomic ,retain)UILabel *nameLable;
@property (nonatomic ,retain)UIImageView * diaryTypeImgView;
@property (nonatomic ,retain)UIImageView * rankImgView;
@property (nonatomic ,retain)UIImageView * delImgView;
@property (nonatomic, retain)UILabel * picCountLabel;

@end
