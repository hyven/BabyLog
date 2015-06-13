//
//  DiaryListResult.m
//  BabyLog
//
//  Created by jiangbin on 15/6/6.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import "DiaryListResult.h"
#import "DiaryModel.h"

@implementation DiaryListResult

+ (DiaryListResult *) getModelFromJson:(NSDictionary *) dic
{
    DiaryListResult *result = [[DiaryListResult alloc]init];
    result.Diary = [DiaryModel getModelsFromJson:[dic objectForKey:@"Diary"]];
    return result;
}

@end
