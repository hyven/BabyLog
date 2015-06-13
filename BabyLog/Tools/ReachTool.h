//
//  ReachTool.h
//
//  Created by apple on 13-12-9.
//  Copyright (c) 2013年 net.syhhidc. All rights reserved.
//  检查网络连接是否畅通

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface ReachTool : NSObject

+ (BOOL) checkReachable;

@end
