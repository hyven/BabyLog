//
//  ReachTool.m
//
//  Created by apple on 13-12-9.
//  Copyright (c) 2013年 net.syhhidc. All rights reserved.
//

#import "ReachTool.h"

@implementation ReachTool

+ (BOOL) checkReachable
{
//    NSString * plistPath=[[NSBundle mainBundle] pathForResource:@"Url List" ofType:@"plist"];
//    NSMutableDictionary * urlDic=[[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
//    NSString * hostUrl=[urlDic objectForKey:@"HostUrl"];
    
    Reachability * reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    if(![reach isReachable]) {
        return false;
    }
    return true;
}

@end
