//
//  BabyInfoModel.h
//  BabyLog
//
//  Created by jiangbin on 15/6/13.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BabyInfoModel : NSObject


@property (nonatomic, retain)NSString *name;
@property (nonatomic, retain)NSString *nickName;
@property (nonatomic, retain)NSString *birthday;
@property (nonatomic, retain)NSString *province;
@property (nonatomic, retain)NSString *city;
@property (nonatomic, retain)NSString *country;
@property (nonatomic, retain)NSString *bloodType;
@property (nonatomic, retain)NSString *introduction;
@property (nonatomic, assign)int sex;
@property (nonatomic, retain)NSString *headImg;

+ (BabyInfoModel *) getModelFromJson:(NSDictionary *) dic;
+ (NSMutableArray *) getModelsFromJson:(NSArray *) list;

@end


