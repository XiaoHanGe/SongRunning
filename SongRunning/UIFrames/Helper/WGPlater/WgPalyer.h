//
//  WgPalyer.h
//  RaySound
//
//  Created by 韩俊强 on 15/8/13.
//  Copyright (c) 2015年 梁成友. All rights reserved.
//  播放器单例

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface WgPalyer : NSObject

@property (nonatomic , strong)AVPlayer *player;

+(WgPalyer *)sharedPlayer;

@end
