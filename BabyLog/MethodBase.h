//
//  MethodBase.h
//  BabyLog
//
//  Created by 恒昊 on 15-5-31.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIService.h"
#import "APIResult.h"

@interface MethodBase : NSObject

@property(nonatomic,retain) NSString* methodName;
@property(nonatomic,retain) id<BabyLogAPIServiceDelegate> delegate;
@property(nonatomic,retain) APIResult *apiResult;


-(void) initWithJson:(NSDictionary *) dic;
-(void) resultWithJson:(NSDictionary *) dic;
-(void) global;
-(void) trigger;
-(void) methodCallBack;
-(void) saveToDB;
-(NSDictionary *) getRequestParams;

@end
