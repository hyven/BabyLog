//
//  BabyInfo.h
//  BabyLog
//
//  Created by jiangbin on 15/6/13.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import "MethodBase.h"

@interface BabyInfo : MethodBase

@end

@interface GetBabyInfo : MethodBase

@end

@interface UpdateBabyInfo : MethodBase

@property(nonatomic, retain)BabyInfoModel* babyInfo;

@end

@interface BabyInfoUpdatePhoto : MethodBase

@property(nonatomic,retain) NSString * base64;

@end