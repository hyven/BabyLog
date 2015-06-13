//
//  OperationObject.m
//  BabyLog
//
//  Created by 恒昊 on 15-5-31.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import "OperationObject.h"
#import "ConstantDefine.h"
#import "ASIHTTPRequest.h"
#import "AppDelegate.h"

@implementation OperationObject

-(id) init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void) request
{
    NSString *URL = [NSString stringWithFormat:MallAPI_URL,self.method.methodName];
    
    ASIHTTPRequest * request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:URL]];
    request.delegate=self;
    
    
    NSDictionary *dic = [self.method getRequestParams];
    
    if(dic !=nil){
        if ([NSJSONSerialization isValidJSONObject:dic]) {
            
            NSData * jsonData=[NSJSONSerialization dataWithJSONObject:dic options: NSJSONWritingPrettyPrinted error:nil];
            NSMutableData * tempJsonData=[NSMutableData dataWithData:jsonData];
            [request setPostBody:tempJsonData];
        }
    }
    
    NSString * token=[[NSUserDefaults standardUserDefaults] valueForKey:@"userToken"];
    
    if (token !=nil) {
        [request addRequestHeader:@"Token" value:token];
    }
    
    [request setRequestMethod:@"POST"];
    [request startSynchronous];
}



-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *data=request.responseData;
    NSDictionary * dataDic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    [self.method initWithJson:dataDic];
    [self.method methodCallBack];
}

@end
