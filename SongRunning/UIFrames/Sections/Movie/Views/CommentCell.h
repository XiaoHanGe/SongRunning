//
//  CommentCell.h
//  SongRunning
//
//  Created by 韩俊强 on 15-10-10.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@property (weak, nonatomic) IBOutlet UILabel *publishDateLabel;



@end
