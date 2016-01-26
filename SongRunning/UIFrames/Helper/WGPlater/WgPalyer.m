//
//  WgPalyer.m
//  RaySound
//
//  Created by 韩俊强 on 15/8/13.
//  Copyright (c) 2015年 梁成友. All rights reserved.
//

#import "WgPalyer.h"

@implementation WgPalyer

+(WgPalyer *)sharedPlayer
{
    static WgPalyer *player = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        player = [[WgPalyer alloc] init];
    });
    return player;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.player = [[AVQueuePlayer alloc] init];
    }
    return self;
}


@end
