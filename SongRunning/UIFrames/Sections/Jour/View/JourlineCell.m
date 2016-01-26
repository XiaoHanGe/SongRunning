//
//  JourlineCell.m
//  Hiking
//
//  Created by 韩俊强 on 15/8/18.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//

#import "JourlineCell.h"

@implementation JourlineCell



-(void)setJournote:(JourNotes *)journote
{
    if (_journote != journote) {
        _journote = journote;
    }
    [self.mainImageVie sd_setImageWithURL:[NSURL URLWithString:_journote.cover]placeholderImage:[UIImage imageNamed:@"trarl.png"]];
    [self.logo1 sd_setImageWithURL:[NSURL URLWithString:_journote.avatar]placeholderImage:[UIImage imageNamed:@"photo.png"]];
    self.logo1.layer.cornerRadius = 25;
    self.logo1.layer.masksToBounds = YES;
    self.messageLabel1.text = [NSString stringWithFormat:@" %@·%@天%@图·by%@",_journote.start_date,_journote.total_days,_journote.photo_number,_journote.nickname];
    self.messageLabel1.font = [UIFont systemFontOfSize:14];
    self.heheLabel1.text = _journote.name;
    //设置高亮状态
    self.heheLabel1.highlighted = YES;
    //加粗
    self.heheLabel1.font = [UIFont boldSystemFontOfSize:18];

    
}
//时间转换
-(NSString *)stringFromDate:(NSString *)string
{
    NSDateFormatter *dateFormat = [NSDateFormatter new];
    [dateFormat setDateStyle:NSDateFormatterMediumStyle];
    [dateFormat setTimeStyle:NSDateFormatterShortStyle];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[string intValue]];
    NSString *stringl = [dateFormat stringFromDate:date];
    return stringl;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
