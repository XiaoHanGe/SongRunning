//
//  MusicPlayViewController.h
//  SoulSounds
//
//  Created by 韩俊强 on 15-10-12.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicPlayViewController : UIViewController

// 歌曲id
@property (nonatomic , strong) NSString *musicId;

// 歌曲数量
@property (nonatomic , strong) NSNumber *count_sound;

@property (nonatomic, strong) NSString *titles;

@end
