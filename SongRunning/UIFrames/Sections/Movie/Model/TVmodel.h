//
//  TVmodel.h
//  SongRunning
//
//  Created by 韩俊强 on 15-10-9.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TVmodel : NSObject

@property (nonatomic , assign) NSInteger commentcount;
@property (nonatomic , strong) NSString *duration;
@property (nonatomic , strong) NSString *rsId;
@property (nonatomic , strong) NSString *thumbnailV2;
@property (nonatomic , strong) NSString *title;
@property (nonatomic , assign) NSInteger viewCount;
@property (nonatomic , strong) NSString *link;
@property (nonatomic , strong) NSString *published;

@end
