//
//  DiaryListResult.h
//  BabyLog
//
//  Created by jiangbin on 15/6/6.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import "APIResult.h"

@interface DiaryListResult : APIResult

@property (nonatomic, retain)id Diary;

+ (DiaryListResult *) getModelFromJson:(NSDictionary *) dic;

@end
