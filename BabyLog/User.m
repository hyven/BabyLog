//
//  User.m
//  BabyLog
//
//  Created by 恒昊 on 15-5-31.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import "User.h"
#import "DiaryListResult.h"

@implementation User

@end

@implementation UserLogin

-(id) init
{
    self = [super init];
    if (self) {
        self.methodName = @"user.login";
        
    }
    return self;
}

-(void) resultWithJson:(NSDictionary *) dic
{
    
}

-(void) methodCallBack
{
    if ([self.delegate respondsToSelector:@selector(userLoginCallBack:)]) {
        [self.delegate userLoginCallBack:self.apiResult];
    }
}

-(NSDictionary *) getRequestParams
{
    NSDictionary * dic=[[NSDictionary alloc]initWithObjects:@[self.username,self.password]forKeys:@[@"Username",@"Password"]];

    return dic;
}

@end

@implementation UserRegister

-(id) init
{
    self = [super init];
    if (self) {
        self.methodName = @"user.register";
        
    }
    return self;
}

-(void) resultWithJson:(NSDictionary *) dic
{
    
}

-(void) methodCallBack
{
    if ([self.delegate respondsToSelector:@selector(userRegisterCallBack:)]) {
        [self.delegate userRegisterCallBack:self.apiResult];
    }
}

-(NSDictionary *) getRequestParams
{
    NSDictionary * dic=[[NSDictionary alloc]initWithObjects:@[self.username,self.password,self.email,self.shenfen]forKeys:@[@"Username",@"Password",@"Email",@"ShenFen"]];
    return dic;
}

@end

@implementation UserChangePassword


-(id) init
{
    self = [super init];
    if (self) {
        self.methodName = @"user.changepassword";
        
    }
    return self;
}

-(void) resultWithJson:(NSDictionary *) dic
{
}

-(NSDictionary *) getRequestParams
{
    NSDictionary * userInfo=[NSDictionary dictionaryWithObjects:@[self.oldPassword,self.rePassword] forKeys:@[@"OldPassword",@"NewPassword"]];
    return userInfo;
}

-(void) methodCallBack
{
    if ([self.delegate respondsToSelector:@selector(userChangePassWordCallBack:)]) {
        [self.delegate userChangePassWordCallBack:self.apiResult];
    }
}

@end