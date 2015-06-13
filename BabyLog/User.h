//
//  User.h
//  BabyLog
//
//  Created by 恒昊 on 15-5-31.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import "MethodBase.h"

@interface User : MethodBase

@end

@interface UserLogin : MethodBase

@property (nonatomic ,retain) NSString * username;
@property (nonatomic ,retain) NSString * password;

@end

@interface UserRegister : MethodBase

@property (nonatomic ,retain) NSString * username;
@property (nonatomic ,retain) NSString * password;
@property (nonatomic ,retain) NSString * email;
@property (nonatomic ,retain) NSString * shenfen;

@end

@interface UserChangePassword : MethodBase

@property (nonatomic ,retain) NSString * oldPassword;
@property (nonatomic ,retain) NSString * rePassword;

@end
