//
//  MusicTableViewCell.h
//  SoulSounds
//
//  Created by 韩俊强 on 15-10-12.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MusicModel;

@interface MusicTableViewCell : UITableViewCell

- (void)initWithModel:(MusicModel *)model;

@end
