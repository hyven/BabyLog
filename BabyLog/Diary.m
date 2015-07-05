//
//  Diary.m
//  BabyLog
//
//  Created by jiangbin on 15/6/6.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import "Diary.h"

@class DiaryListResult;

@implementation Diary

-(id) init
{
    self = [super init];
    if (self) {
        self.methodName = @"diary.daydiary";
        
    }
    return self;
}

-(void) resultWithJson:(NSDictionary *) dic
{
    
}

-(void) methodCallBack
{
    if ([self.delegate respondsToSelector:@selector(getDiaryListCallBack:)]) {
        [self.delegate getDiaryListCallBack:(APIResult *)self.apiResult];
    }
}

-(NSDictionary *) getRequestParams
{
    NSDictionary * dic=[[NSDictionary alloc]initWithObjects:@[self.day] forKeys:@[@"day"]];
    
    return dic;
}

@end

@implementation DiaryDelete

-(id) init
{
    self = [super init];
    if (self) {
        self.methodName = @"diary.deletediary";
        
    }
    return self;
}

-(void) resultWithJson:(NSDictionary *) dic
{
    
}

-(void) methodCallBack
{
    if ([self.delegate respondsToSelector:@selector(deleteDiaryCallBack:)]) {
        [self.delegate deleteDiaryCallBack:(APIResult *)self.apiResult];
    }
}

-(NSDictionary *) getRequestParams
{
    NSDictionary * dic=[[NSDictionary alloc]initWithObjects:@[self.diaryId] forKeys:@[@"id"]];
    
    return dic;
}

@end
