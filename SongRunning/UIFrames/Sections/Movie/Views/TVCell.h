//
//  TVCell.h
//  SongRunning
//
//  Created by 韩俊强 on 15-10-9.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TVCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;



@property (weak, nonatomic) IBOutlet UILabel *ciShuLabel;

@property (weak, nonatomic) IBOutlet UILabel *pingLunLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end
