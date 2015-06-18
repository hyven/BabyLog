//
//  ImageTool.m
//  QQChat
//
//  Created by 沈志强 on 14-7-28.
//  Copyright (c) 2014年 沈志强. All rights reserved.
// 

#import "ImageTool.h"

@implementation ImageTool

+ (UIImage *) createImageWithColor: (UIColor *) color rect:(CGRect)rect
{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *) createImageWithFrontImage: (UIImage *) frontImage backgroundImage:(UIImage *)backgroundImage
{
    CGSize backgroundSize = [backgroundImage size];
    CGSize frontSize = [frontImage size];
    if (frontSize.width>backgroundSize.width || frontSize.height>backgroundSize.height) {
        return  frontImage;
    }
    // 创建graphics context
    UIGraphicsBeginImageContext(backgroundSize);
    [backgroundImage drawInRect:CGRectMake(0,0,backgroundSize.width,backgroundSize.height)];
    [frontImage drawInRect:CGRectMake((backgroundSize.width-frontSize.width)/2,(backgroundSize.height-frontSize.height)/2,frontSize.width,frontSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭graphics context
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIColor *)createColor:(NSString*)hexColor
{
    unsigned int transparent,red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&transparent];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
    
    range.location = 6;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:(float)(transparent / 255.0f)];
}

@end
