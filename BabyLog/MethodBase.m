//
//  MethodBase.m
//  BabyLog
//
//  Created by 恒昊 on 15-5-31.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import "MethodBase.h"

@implementation MethodBase

-(id) init
{
    self = [super init];
    if (self) {
        self.methodName = @"empty";
        self.apiResult = [[APIResult alloc] init];
        
    }
    return self;
}

-(void) initWithJson:(NSDictionary *) dic
{
    //    NSLog(@"%@",dic);
    self.apiResult.data = dic;
    self.apiResult.statusCode=[[dic objectForKey:@"StatusCode"] integerValue];
    self.apiResult.token=[dic objectForKey:@"Token"];
    self.apiResult.formId=[dic objectForKey:@"OrderCode"];
    self.apiResult.cartId=[dic objectForKey:@"Id"];
    self.apiResult.message=[dic objectForKey:@"msg"];
    self.apiResult.error=[dic objectForKey:@"Error"];
    //    NSLog(@"购物车id%d",self.apiResult.cartId);
    [self resultWithJson:dic];
}

-(void) resultWithJson:(NSDictionary *) dic
{
    
}

-(void) global
{
    
}

-(void) saveToDB
{
    
}

-(void) trigger
{
}

-(void) methodCallBack
{
    
}

-(NSDictionary *) getRequestParams
{
    return nil;
}


@end
