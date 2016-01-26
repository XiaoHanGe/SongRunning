//
//  PlaySingleton.m
//  SongRunning
//
//  Created by 韩俊强 on 15-10-9.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//

#import "PlaySingleton.h"

@implementation PlaySingleton

+(PlaySingleton *)defaultSingleton
{
    static PlaySingleton *singleton = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        singleton = [[PlaySingleton alloc] init];
    });
    return singleton;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.player = [[AVQueuePlayer alloc] init];
    }
    
    return self;
}






@end
