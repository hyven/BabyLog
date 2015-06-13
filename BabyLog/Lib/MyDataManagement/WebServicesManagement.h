//
//  WebServicesManagement.h
//  SYHHIDCMall
//
//  Created by 李梓楠 on 14-6-5.
//  Copyright (c) 2014年 syhhidc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WebServicesManagementDelegate <NSObject>

@optional

- (void) connectionFinished:(NSArray *)responseArr;
- (void) connectionFailed:(NSError *)error;

@end

@interface WebServicesManagement : NSObject

@property (nonatomic ,assign)id<WebServicesManagementDelegate>delegate;

- (void) clear;
- (void) initNetworkQueue;
- (void) startConnection:(NSString *)connectionStr;
- (void) startPostConnection:(NSString *)connectionStr withParamsDic:(NSDictionary *)paramsDic;
- (BOOL)isNetworkAvaliable;

@end
