//
//  BabyInfoModel.m
//  BabyLog
//
//  Created by jiangbin on 15/6/13.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import "BabyInfoModel.h"

@implementation BabyInfoModel

+ (BabyInfoModel *) getModelFromJson:(NSDictionary *) dic
{
    BabyInfoModel *model = [[BabyInfoModel alloc] init];
    
    model.name = [dic objectForKey:@"BabyName"];
    model.nickName = [dic objectForKey:@"Nickname"];
    model.birthday = [dic objectForKey:@"Birthday"];
    model.province = [dic objectForKey:@"Province"];
    model.city = [dic objectForKey:@"City"];
    model.country = [dic objectForKey:@"Country"];
    model.bloodType = [dic objectForKey:@"BloodType"];
    model.introduction = [dic objectForKey:@"Introduction"];
    model.headImg = [dic objectForKey:@"HeadImg"];
    model.sex = [[dic objectForKey:@"Sex"] intValue];

    return model;
}

+ (NSMutableArray *) getModelsFromJson:(NSArray *) list
{
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for(int i=0;i<list.count;i++)
    {
        BabyInfoModel *model = [BabyInfoModel getModelFromJson:[list objectAtIndex:i]];
        [array addObject:model];
    }
    
    return array;
    
}
@end

