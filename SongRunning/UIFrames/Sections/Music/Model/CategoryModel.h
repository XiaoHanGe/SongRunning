//
//  CategoryModel.h
//  SoulSounds
//
//  Created by 韩俊强 on 15-10-10.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryModel : NSObject

// 图片
@property (nonatomic , copy) NSString *cover_url;

// 类别名称
@property (nonatomic , copy) NSString *title;

// ID
@property (nonatomic , strong) NSString *countId;

// 播放量
@property (nonatomic , strong) NSNumber *count_play;

// 更新时间
@property (nonatomic , copy) NSString *update_time;

// 歌曲数量
@property (nonatomic , strong) NSNumber *count_sound;

@end
