//
//  MusicModel.h
//  SoulSounds
//
//  Created by 韩俊强 on 15-10-10.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicModel : NSObject

// 图片
@property (nonatomic , copy) NSString *cover_url;

// 类别名称
@property (nonatomic , copy) NSString *name;

// 类别ID
@property (nonatomic , strong) NSNumber *countId;

@end
