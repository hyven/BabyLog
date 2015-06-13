//
//  APIResult.h
//  BabyLog
//
//  Created by 恒昊 on 15-5-31.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIResult : NSObject

@property (nonatomic ,retain) NSMutableArray *models;
@property (nonatomic ,retain) id model;
@property (nonatomic ,retain) NSDictionary *data;
@property (nonatomic ,retain) NSDictionary * speDic;
@property (nonatomic ,assign) int statusCode;
@property (nonatomic ,retain) NSString *error;
@property (nonatomic ,retain) NSString * token;
@property (nonatomic ,retain) NSString * message;
@property (nonatomic ,retain) NSString * formId;
@property (nonatomic ,retain) NSString * cartId;

@end
