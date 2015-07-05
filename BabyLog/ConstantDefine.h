//
//  ConstantDefine.h
//  BabyLog
//
//  Created by zhanghong on 15-5-27.
//  Copyright (c) 2014年 syhhidc. All rights reserved.
//

#ifndef BabyLog_ConstantDefine_h
#define BabyLog_ConstantDefine_h

#define KChangeHeaderViewColor @"KChangeHeaderViewColor"

#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define ISIOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7
#define ISIOS6_OR_EARLY [[[UIDevice currentDevice] systemVersion] floatValue] < 7
#define NAVIGATION_BACKGROUND_COLOR [UIColor colorWithRed:244/255.0 green:97/255.0 blue:37/255.0 alpha:1]

#define TABLEVIEWCELL_BACKGROUN_COLOR [UIColor colorWithRed:151/255.0 green:151/255.0 blue:151/255.0 alpha:1]

#define HEADER_VIEW_BACKGROUD_COLOR_1 [UIColor colorWithRed:255/255.0 green:247/255.0 blue:224/255.0 alpha:1];
#define HEADER_VIEW_BACKGROUD_COLOR_2 [UIColor colorWithRed:207/255.0 green:239/255.0 blue:255/255.0 alpha:1];
#define HEADER_VIEW_BACKGROUD_COLOR_3 [UIColor colorWithRed:225/255.0 green:240/255.0 blue:255/255.0 alpha:1];
#define HEADER_VIEW_BACKGROUD_COLOR_4 [UIColor colorWithRed:213/255.0 green:253/255.0 blue:251/255.0 alpha:1];
#define HEADER_VIEW_BACKGROUD_COLOR_5 [UIColor colorWithRed:255/255.0 green:225/255.0 blue:232/255.0 alpha:1];
#define HEADER_VIEW_BACKGROUD_COLOR_6 [UIColor colorWithRed:255/255.0 green:223/255.0 blue:223/255.0 alpha:1];
//
#define HTTP_HEADER @"http://www.babysaga.cn/"
#define HTTP_WEB @"http://m.bxcxt.com/"
#define Service_Method @"service?method="
#define MallAPI_URL @"http://www.babysaga.cn/app/service?method=%@"
#define PAYMENT_URL @"http://api.bxcxt.com/payment/ccb/%@?token=%@"

// 首页 *
#define Home @"home/index"
// 联系客服
#define ContactService @"helper/app/20"
// 服务协议
#define Agreement @"helper/app/25"
// 关于我们
#define AboutUs @"helper/app/17"

#endif
