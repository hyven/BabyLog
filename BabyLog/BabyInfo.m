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
