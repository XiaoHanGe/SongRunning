//
//  ReadCell.m
//  SongRunning
//
//  Created by 韩俊强 on 15/12/3.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//

#import "ReadCell.h"
#import "ReadModel.h"

@implementation ReadCell

- (void)setModel:(ReadModel *)model
{
    _model = model;
    [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.coverimg]] placeholderImage:[UIImage imageNamed:@"aboutUs.png"]];

    self.titleLabel.text = [NSString stringWithFormat:@"%@%@",model.name,model.enname];
    self.titleLabel.backgroundColor = [UIColor lightGrayColor];
    self.titleLabel.alpha = 0.5;
}



- (void)awakeFromNib {
    // Initialization code
}

@end
