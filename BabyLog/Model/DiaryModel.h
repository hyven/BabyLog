//
//  DiaryModel.h
//  BabyLog
//
//  Created by jiangbin on 15/6/6.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiaryModel : NSObject

@property (nonatomic, retain)NSString *entryTime;
@property (nonatomic, retain)NSString *diaryTypeName;
@property (nonatomic, retain)NSString *Title;
@property (nonatomic, assign)int diaryTypeId;
@property (nonatomic, assign)int rank;
@property (nonatomic, assign)int diaryId;
@property (nonatomic, assign)int picCount;
@property (nonatomic, retain)NSString *Content;
@property (nonatomic, retain)NSMutableArray *picList;

+ (DiaryModel *) getModelFromJson:(NSDictionary *) dic;
+ (NSMutableArray *) getModelsFromJson:(NSArray *) list;

@end

//"Id":1136,
//"DiaryDate":"2015-06-06",
//"Title":"",
//"EntryTime":"22:28",
//"Content":"",
//"StartTime":"22:28",
//"EndTime":"22:28",
//"Rank":4,
//"PicCount":2,
//"DiaryTypeName":"起床",
//"DiaryTypeImg":"~/content/diaryimg/bianbian.jpg",
//"DiaryTypeId":13,
//"PicList":["~/Uploads/000014FilePath/9cd92844-8266-4882-96b5-1442ff7b7493.jpg","~/Uploads/000014FilePath/c07d7413-edd3-41b2-8020-b0d323f0cb6e.jpg"]


