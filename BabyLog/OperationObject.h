//
//  OperationObject.h
//  BabyLog
//
//  Created by 恒昊 on 15-5-31.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIService.h"
#import "MethodBase.h"

@interface OperationObject : NSObject

@property(nonatomic,retain) id<BabyLogAPIServiceDelegate> delegate;
@property(nonatomic,retain) MethodBase *method;

-(void) request;

@end
