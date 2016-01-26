//
//  CategoryCell.m
//  SoulSounds
//
//  Created by 韩俊强 on 15-10-12.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//

#import "CategoryCell.h"


@interface CategoryCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;
@property (weak, nonatomic) IBOutlet UILabel *updataTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;


@end

@implementation CategoryCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initWithModel:(CategoryModel *)model
{
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_url]placeholderImage:[UIImage imageNamed:@"typee"]];
    self.introduceLabel.text = model.title;
    self.updataTimeLabel.text = model.update_time;
    self.playCountLabel.text = [NSString stringWithFormat:@"播放%@次" , model.count_play];
}

@end
