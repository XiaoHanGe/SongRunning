//
//  JourDetailView.h
//  SongRunning
//
//  Created by 韩俊强 on 15/12/8.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JourNotes;

@interface JourDetailView : UITableViewController

@property (nonatomic , retain)  JourNotes *travelNotes;

@property (nonatomic , copy ) NSString *deatilID;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, copy) NSString *comment_count;//评论数

@property (nonatomic ,copy) NSString *cover;//图片

@property (nonatomic ,copy) NSString *avatar;//logo

@property (nonatomic ,copy) NSString *nickname;//昵称

@property (nonatomic ,copy) NSString *start_date;//日期

@property (nonatomic ,copy) NSString *photo_number;//图数

@property (nonatomic ,copy) NSString *fav_count;//点赞数

@property (nonatomic ,copy) NSString *total_days;//天数

@property (nonatomic ,copy) NSString *view_count;//观看数
@end
