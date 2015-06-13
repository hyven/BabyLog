//
//  OperationContainer.h
//  BabyLog
//
//  Created by 恒昊 on 15-5-31.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIService.h"
#import "MethodBase.h"

@interface OperationContainer : NSObject


+(OperationContainer *) shareOperationContainer;

-(void) addOperationObject:(id<BabyLogAPIServiceDelegate>) delegate withMethod:(MethodBase *) method;


@end
