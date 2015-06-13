//
//  OperationContainer.m
//  BabyLog
//
//  Created by 恒昊 on 15-5-31.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import "OperationContainer.h"
#import "OperationObject.h"

@implementation OperationContainer

static OperationContainer *cIOperationContainer = nil;


+(OperationContainer *) shareOperationContainer
{
    @synchronized(self){
        if (cIOperationContainer == nil) {
            cIOperationContainer = [[OperationContainer alloc] init];
            
        }
    }
    
    return cIOperationContainer;
}


-(void) addOperationObject:(id<BabyLogAPIServiceDelegate>) delegate withMethod:(MethodBase *) method
{
    OperationObject *operationObject = [[OperationObject alloc] init];
    operationObject.delegate = delegate;
    operationObject.method = method;
    [operationObject request];
}

@end
