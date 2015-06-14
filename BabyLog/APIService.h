//
//  APIService.h
//  BabyLog
//
//  Created by 恒昊 on 15-5-31.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

@class APIResult;
@class DiaryListResult;
@protocol BabyLogAPIServiceDelegate;

#import <Foundation/Foundation.h>

@interface APIService : NSObject

@property(nonatomic,assign) id<BabyLogAPIServiceDelegate> delegate;


#pragma mark - User

-(void) userLoginWithUserName:(NSString *)userName password:(NSString *) pass;

-(void) userRegisterWithUserName:(NSString *) userName password:(NSString *)pass email:(NSString *)email shenfen:(NSString *)shenfen;

-(void) userChangeUserPassword:(NSString *) oldPass WithNewPassword:(NSString *) newPass;

#pragma mark - BabyInfo

-(void) getBabyInfo;

#pragma mark - Diary

-(void) getDiaryList:(NSString *)day;

@end



@protocol BabyLogAPIServiceDelegate <NSObject>

@optional

#pragma mark - UserCallBack

-(void) userLoginCallBack:(APIResult *) result;

-(void) userRegisterCallBack:(APIResult *) result;

-(void) userChangePassWordCallBack:(APIResult *) result;

#pragma mark - BabyInfoCallBack

-(void) getBabyInfoCallBack:(APIResult *) result;

#pragma mark - DairyCallBack

-(void)getDiaryListCallBack:(APIResult*) result;



@end