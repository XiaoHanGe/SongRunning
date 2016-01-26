//
//  PlaySingleton.h
//  SongRunning
//
//  Created by 韩俊强 on 15-10-9.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface PlaySingleton : NSObject

@property (nonatomic, strong) AVQueuePlayer *player;

+(PlaySingleton *)defaultSingleton;


@end
