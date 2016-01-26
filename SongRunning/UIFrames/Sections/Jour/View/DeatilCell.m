//
//  DeatilCell.m
//  WonderfulLife
//
//  Created by 韩俊强 on 15/7/10.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//
#import "MJRefresh.h"

@implementation DeatilCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addAllsubViews];
    }
    return self;
}


-(void)addAllsubViews
{
    
    self.traImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 30)];
    self.traImageView.backgroundColor = [UIColor colorWithRed:0.4902 green:0.4902 blue:0.4902 alpha:1.0];
    
     self.traContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _traImageView.frame.origin.y, kScreenW, 25)];
    self.traContentLabel.font = [UIFont systemFontOfSize:17];
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.traContentLabel.frame.origin.y + self.traContentLabel.frame.size.height, self.frame.size.width, 30)];
   
   
    [self addSubview:self.traImageView];
    [self addSubview:self.traContentLabel];
    [self addSubview:self.timeLabel];

    
}




#pragma mark - setterTravelDeatil

-(void)setTravelDeatil:(TracelDeatil *)travelDeatil
{
    if (_travelDeatil != travelDeatil) {
        _travelDeatil = travelDeatil ;
    }
    [self.traImageView  sd_setImageWithURL:[NSURL URLWithString:self.travelDeatil.picture]];
    
    CGFloat height1 = [travelDeatil.height integerValue];
    self.traImageView.frame = CGRectMake(0, 0, kScreenW, height1/3);
    
    self.traContentLabel.text = _travelDeatil.travDescription;
    self.traContentLabel.numberOfLines = 0;
//    self.traContentLabel.textColor = [UIColor orangeColor];
    
    NSString *str  = [self stringFromDate:_travelDeatil.travCreated_date];
    self.timeLabel.text = str;
    self.timeLabel.font = [UIFont systemFontOfSize:15];
    self.timeLabel.textColor = [UIColor colorWithRed:0.4902 green:0.4902 blue:0.4902 alpha:1.0];
    
    CGRect rect = [travelDeatil.travDescription boundingRectWithSize:CGSizeMake(kScreenW, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    self.traContentLabel.frame = CGRectMake(10, CGRectGetMaxY(self.traImageView.frame), kScreenW - 20, rect.size.height);
    
    self.timeLabel.frame = CGRectMake(20, CGRectGetMaxY(self.traContentLabel.frame), kScreenH , 30);
    

    
    
}

+(CGFloat)cellHeight:(TracelDeatil *)tracelDeatil
{
    
    CGRect rect = [tracelDeatil.travDescription boundingRectWithSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width, 0) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    
    CGFloat height2 = [tracelDeatil.height integerValue];
    return (30 + height2/3 + rect.size.height);
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
