//
//  BabyInfo.m
//  BabyLog
//
//  Created by jiangbin on 15/6/13.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import "BabyInfo.h"

@implementation BabyInfo

@end

@implementation GetBabyInfo

-(id) init
{
    self = [super init];
    if (self) {
        self.methodName = @"user.GetUserInfo";
        
    }
    return self;
}

-(void) resultWithJson:(NSDictionary *) dic
{
    
}

-(void) methodCallBack
{
    if ([self.delegate respondsToSelector:@selector(getBabyInfoCallBack:)]) {
        [self.delegate getBabyInfoCallBack:self.apiResult];
    }
}

-(NSDictionary *) getRequestParams
{    
    NSDictionary * dic = NULL;
    return dic;
}

@end

@implementation UpdateBabyInfo

-(id) init
{
    self = [super init];
    if (self) {
        self.methodName = @"user.IOSUpdateUserInfoMethod";
        
    }
    return self;
}

-(void) resultWithJson:(NSDictionary *) dic
{
    
}

-(void) methodCallBack
{
    if ([self.delegate respondsToSelector:@selector(updateBabyInfoCallBack:)]) {
        [self.delegate updateBabyInfoCallBack:self.apiResult];
    }
}

-(NSDictionary *) getRequestParams
{
    NSDictionary * dic=[[NSDictionary alloc]
        initWithObjects:@[self.babyInfo.name, self.babyInfo.nickName,self.babyInfo.birthday,
                          self.babyInfo.province,self.babyInfo.city, self.babyInfo.country,
                          self.babyInfo.bloodType, self.babyInfo.introduction,
                          [NSString stringWithFormat:@"%d", self.babyInfo.sex],self.babyInfo.headImg]
        forKeys:@[@"BabyName",@"Nickname",@"Birthday",@"Province",@"City",@"Country"
                  ,@"BloodType",@"Introduction",@"Sex",@"HeadImg"]];
    
    return dic;
}

@end
