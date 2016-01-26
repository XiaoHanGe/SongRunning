//
//  MusicTableViewCell.m
//  SoulSounds
//
//  Created by 韩俊强 on 15-10-12.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//

#import "MusicTableViewCell.h"


@interface MusicTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation MusicTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initWithModel:(MusicModel *)model
{
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_url]placeholderImage:[UIImage imageNamed:@"musicDetail"]];
    self.titleLabel.text = model.name;
}

@end
