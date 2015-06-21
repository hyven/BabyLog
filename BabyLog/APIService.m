//
//  APIService.m
//  BabyLog
//
//  Created by 恒昊 on 15-5-31.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import "APIService.h"
#import "User.h"
#import "Diary.h"
#import "BabyInfo.h"
#import "OperationContainer.h"

@implementation APIService

#pragma mark - User

-(void) userLoginWithUserName:(NSString *)userName password:(NSString *) pass
{
    UserLogin * userLogin=[[UserLogin alloc]init];
    userLogin.username=userName;
    userLogin.password=pass;
    userLogin.delegate=self.delegate;
    
    [[OperationContainer shareOperationContainer] addOperationObject:self.delegate withMethod:userLogin];
}

-(void) userRegisterWithUserName:(NSString *) userName password:(NSString *)pass email:(NSString *)email shenfen:(NSString *)shenfen
{
    UserRegister * userRegister=[[UserRegister alloc]init];
    userRegister.username=userName;
    userRegister.password=pass;
    userRegister.email = email;
    userRegister.shenfen = shenfen;
    userRegister.delegate=self.delegate;
    
    [[OperationContainer shareOperationContainer] addOperationObject:self.delegate withMethod:userRegister];
}

-(void) userChangeUserPassword:(NSString *) oldPass WithNewPassword:(NSString *) newPass
{
    UserChangePassword * changePassword=[[UserChangePassword alloc]init];
    changePassword.oldPassword=oldPass;
    changePassword.rePassword=newPass;
    changePassword.delegate=self.delegate;
    
    [[OperationContainer shareOperationContainer] addOperationObject:self.delegate withMethod:changePassword];
}

#pragma mark - BabyInfo

-(void) getBabyInfo
{
    GetBabyInfo * info = [[GetBabyInfo alloc]init];
    info.delegate = self.delegate;
    
    [[OperationContainer shareOperationContainer] addOperationObject:self.delegate withMethod:info];
}

-(void) updateBabyInfo:(BabyInfoModel *)info
{
    UpdateBabyInfo *upinfo = [[UpdateBabyInfo alloc]init];
    upinfo.babyInfo = info;
    upinfo.delegate = self.delegate;
    
    [[OperationContainer shareOperationContainer] addOperationObject:self.delegate withMethod:upinfo];
}

#pragma mark - Dairy

-(void) getDiaryList:(NSString *)day
{
    Diary *diary = [[Diary alloc]init];
    diary.day = day;
    diary.delegate = self.delegate;
    
    [[OperationContainer shareOperationContainer] addOperationObject:self.delegate withMethod:diary];
}




@end
