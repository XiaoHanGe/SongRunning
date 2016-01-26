//
//  ReadDetailCell.m
//  Everyday
//
//  Created by lz on 15/10/12.
//  Copyright (c) 2015年 lz. All rights reserved.
//

#import "ReadDetailCell.h"

#import "ReadDetailModel.h"

@implementation ReadDetailCell

- (void)setModel:(ReadDetailModel *)model
{
    _model = model;
    [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:model.coverimg] placeholderImage:[UIImage imageNamed:@"aboutUs.png"]];
    self.titlelabel1.text = model.title;
    self.subLabel1.text = model.content;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
