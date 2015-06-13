//
//  ImageModel.m
//  BabyLog
//
//  Created by jiangbin on 15/6/6.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import "ImageModel.h"

@implementation ImageModel

+ (ImageModel *) getModelFromJson:(NSDictionary *) dic
{
    ImageModel * imageModel=[[ImageModel alloc]init];
    imageModel.imagePath=[dic objectForKey:@"ImagePath"];
    
    return imageModel;
}

+ (NSMutableArray *) getModelsFromJson:(NSArray *) list
{
    NSMutableArray * array=[[NSMutableArray alloc]init];
    
    for(int i=0;i<list.count;i++)
    {
        ImageModel * imageModel = [ImageModel getModelFromJson:[list objectAtIndex:i]];
        [array addObject:imageModel];
    }
    return array;
}

@end
