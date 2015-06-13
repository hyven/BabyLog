//
//  ImageModel.h
//  BabyLog
//
//  Created by jiangbin on 15/6/6.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageModel : NSObject

@property(nonatomic,retain)NSString *imagePath;

+ (ImageModel *) getModelFromJson:(NSDictionary *) dic;
+ (NSMutableArray *) getModelsFromJson:(NSArray *) list;

@end
