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
#import "BabyInfoModel.h"

@interface APIService : NSObject

@property(nonatomic,assign) id<BabyLogAPIServiceDelegate> delegate;


#pragma mark - User

-(void) userLoginWithUserName:(NSString *)userName password:(NSString *) pass;

-(void) userRegisterWithUserName:(NSString *) userName password:(NSString *)pass email:(NSString *)email shenfen:(NSString *)shenfen;

-(void) userChangeUserPassword:(NSString *) oldPass WithNewPassword:(NSString *) newPass;

#pragma mark - BabyInfo

-(void) getBabyInfo;

-(void) updateBabyInfo:(BabyInfoModel *)info;

-(void) babyInfoUpdatePhotoWithBase64String:(NSString *)base64;

#pragma mark - Diary

-(void) getDiaryList:(NSString *)day;

-(void) deleteDiary:(NSString *)diaryId;

@end



@protocol BabyLogAPIServiceDelegate <NSObject>

@optional

#pragma mark - UserCallBack

-(void) userLoginCallBack:(APIResult *) result;

-(void) userRegisterCallBack:(APIResult *) result;

-(void) userChangePassWordCallBack:(APIResult *) result;

#pragma mark - BabyInfoCallBack

-(void) getBabyInfoCallBack:(APIResult *) result;

-(void) updateBabyInfoCallBack:(APIResult *) result;

-(void) babyInfoUpdatePhotoCallBack:(APIResult *) result;


#pragma mark - DairyCallBack

-(void)getDiaryListCallBack:(APIResult*) result;

-(void)deleteDiaryCallBack:(APIResult*) result;


@end