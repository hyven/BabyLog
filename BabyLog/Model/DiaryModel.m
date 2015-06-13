//
//  DiaryModel.m
//  BabyLog
//
//  Created by jiangbin on 15/6/6.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import "DiaryModel.h"
#import "ImageModel.h"

@implementation DiaryModel

+ (DiaryModel *) getModelFromJson:(NSDictionary *) dic
{
    DiaryModel *model = [[DiaryModel alloc] init];
    
    model.entryTime = [dic objectForKey:@"EntryTime"];
    model.diaryTypeName = [dic objectForKey:@"DiaryTypeName"];
    model.Title = [dic objectForKey:@"Title"];
    model.diaryTypeId = [[dic objectForKey:@"DiaryTypeId"] intValue];
    model.rank = [[dic objectForKey:@"Rank"] intValue];
    model.diaryId = [[dic objectForKey:@"Id"] intValue];
    model.picCount = [[dic objectForKey:@"PicCount"] intValue];
    model.Content = [dic objectForKey:@"Content"];
    model.picList = [dic objectForKey:@"PicList"];
    
    return model;
}

+ (NSMutableArray *) getModelsFromJson:(NSArray *) list
{
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for(int i=0;i<list.count;i++)
    {
        DiaryModel *model = [DiaryModel getModelFromJson:[list objectAtIndex:i]];
        [array addObject:model];
    }
    
    return array;
    
}
@end
