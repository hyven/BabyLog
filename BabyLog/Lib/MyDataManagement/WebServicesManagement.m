//
//  WebServicesManagement.m
//  SYHHIDCMall
//
//  Created by 李梓楠 on 14-6-5.
//  Copyright (c) 2014年 syhhidc. All rights reserved.
//

#import "WebServicesManagement.h"
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "ASIFormDataRequest.h"
#import "Reachability.h"


#define DOWNLOADTIMEOUT 15

@interface WebServicesManagement ()
@property (nonatomic, strong) ASINetworkQueue *networkQueue;
@end

@implementation WebServicesManagement

- (void)initNetworkQueue
{
    [self.networkQueue cancelAllOperations];
	
	self.networkQueue = [ASINetworkQueue queue];
	[self.networkQueue setDelegate:self];
    [self.networkQueue setMaxConcurrentOperationCount:3];
	[self.networkQueue setRequestDidFinishSelector:@selector(requestFinished:)];
	[self.networkQueue setRequestDidFailSelector:@selector(requestFailed:)];
	[self.networkQueue setQueueDidFinishSelector:@selector(queueFinished:)];
    [self.networkQueue setShowAccurateProgress:NO];
    [self.networkQueue setShouldCancelAllRequestsOnFailure:YES];
    [self.networkQueue setSuspended:NO];
}

-(void)startConnection:(NSString *)connectionStr
{
    
    ASIHTTPRequest *request;
    request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:connectionStr]];
    [request setTimeOutSeconds:DOWNLOADTIMEOUT];
    request.shouldAttemptPersistentConnection = NO;
    [self.networkQueue addOperation:request];
}

-(void)startPostConnection:(NSString *)connectionStr withParamsDic:(NSDictionary *)paramsDic
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:connectionStr]];
    NSArray *keysArr = [paramsDic allKeys];
    for (NSString *key in keysArr) {
        [request setPostValue:[paramsDic valueForKey:key] forKey:key];
    }
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:DOWNLOADTIMEOUT];
    request.shouldAttemptPersistentConnection = NO;
    [self.networkQueue addOperation:request];
}

- (BOOL)isNetworkAvaliable
{
    BOOL isReachable;
    Reachability* reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    if ([reach currentReachabilityStatus] == NotReachable) {
        isReachable = NO;
    }else {
        isReachable = YES;
    }
    return isReachable;
}

#pragma mark - ASIHttpRequest methods

-(void)requestFinished:(ASIHTTPRequest *)request{


    //返回Json
//    if (_delegate&&[_delegate respondsToSelector:@selector(connectionFinished:)]) {
//        [_delegate connectionFinished:[NSArray array]]
//    }
    
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    
}
#pragma mark - QueueFinished

- (void)queueFinished:(ASINetworkQueue *)queue{
    
}

- (void)clear
{
    [self.networkQueue cancelAllOperations];
}

@end
