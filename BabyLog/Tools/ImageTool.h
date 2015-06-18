//
//  ImageTool.h
//  QQChat
//
//  Created by 沈志强 on 14-7-28.
//  Copyright (c) 2014年 沈志强. All rights reserved.
// 

#import <UIKit/UIKit.h>

@interface ImageTool : NSObject

+ (UIImage *) createImageWithColor: (UIColor*) color rect:(CGRect)rect;
+ (UIImage *) createImageWithFrontImage: (UIImage *) frontImage backgroundImage:(UIImage *)backgroundImage;
+ (UIColor *) createColor:(NSString*)hexColor;

@end
