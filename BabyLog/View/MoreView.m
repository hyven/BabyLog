//
//  MoreView.m
//  common
//
//  Created by 沈志强 on 14/12/31.
//  Copyright (c) 2014年 沈志强. All rights reserved.
// 

#import "MoreView.h"

#import "AppDelegate.h"

@implementation MoreView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor=COMMON_WHITE_COLOR;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // 拍摄按钮
    UIButton *cameraBtn=[[UIButton alloc] init];
    cameraBtn.frame=CGRectMake(15, 25, WIDTH-30, 40);
    UILabel *cameraLbl=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH-30, 40)];
    cameraLbl.textAlignment=NSTextAlignmentCenter;
    cameraLbl.backgroundColor=[UIColor clearColor];
    cameraLbl.textColor=COMMON_BLUE_COLOR;
    cameraLbl.font=[UIFont boldSystemFontOfSize:17.0];
    cameraLbl.text=@"拍摄新照片";
    [cameraBtn addSubview:cameraLbl];
    [cameraBtn addTarget:self action:@selector(camera) forControlEvents:UIControlEventTouchUpInside];
    
    CALayer *layer=[cameraBtn layer];
    [layer setBorderWidth:0.5];
    [layer setBorderColor:[(COMMON_BLUE_COLOR) CGColor]];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:5.0];
    
    [self addSubview:cameraBtn];
    
    // 照片按钮
    UIButton *photoBtn=[[UIButton alloc] init];
    photoBtn.frame=CGRectMake(15, 80, WIDTH-30, 40);
    UILabel *photoLbl=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH-30, 40)];
    photoLbl.textAlignment=NSTextAlignmentCenter;
    photoLbl.backgroundColor=[UIColor clearColor];
    photoLbl.textColor=COMMON_BLUE_COLOR;
    photoLbl.font=[UIFont boldSystemFontOfSize:17.0];
    photoLbl.text=@"使用相册图片";
    [photoBtn addSubview:photoLbl];
    [photoBtn addTarget:self action:@selector(photo) forControlEvents:UIControlEventTouchUpInside];
    
    CALayer *layer02=[photoBtn layer];
    [layer02 setBorderWidth:0.5];
    [layer02 setBorderColor:[(COMMON_BLUE_COLOR) CGColor]];
    [layer02 setMasksToBounds:YES];
    [layer02 setCornerRadius:5.0];
    
    [self addSubview:photoBtn];
    
    // 取消按钮
    UIButton *cancelBtn=[[UIButton alloc] init];
    cancelBtn.frame=CGRectMake(15, 135, WIDTH-30, 40);
    UILabel *cancelLbl=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH-30, 40)];
    cancelLbl.textAlignment=NSTextAlignmentCenter;
    cancelLbl.backgroundColor=[UIColor clearColor];
    cancelLbl.textColor=COMMON_BLUE_COLOR;
    cancelLbl.font=[UIFont boldSystemFontOfSize:17.0];
    cancelLbl.text=@"取      消";
    [cancelBtn addSubview:cancelLbl];
    [cancelBtn addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
    
    CALayer *layer03=[cancelBtn layer];
    [layer03 setBorderWidth:0.5];
    [layer03 setBorderColor:[(COMMON_BLUE_COLOR) CGColor]];
    [layer03 setMasksToBounds:YES];
    [layer03 setCornerRadius:5.0];
    
    [self addSubview:cancelBtn];
}

// 打开相机
- (void)camera
{
    [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"Camera%@",tag] object:nil];
    [self.superview.superview removeFromSuperview];
}

// 打开相册
- (void)photo
{
    [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"Photo%@",tag] object:nil];
    [self.superview.superview removeFromSuperview];
}

// 取消
- (void)exit
{
    [self.superview.superview removeFromSuperview];
}

@end
