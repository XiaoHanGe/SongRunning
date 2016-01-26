//
//  ReadDetailCell.h
//  Everyday
//
//  Created by lz on 15/10/12.
//  Copyright (c) 2015年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ReadDetailModel;

@interface ReadDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel1;
@property (weak, nonatomic) IBOutlet UILabel *subLabel1;
@property (nonatomic, strong) ReadDetailModel *model;

@end
