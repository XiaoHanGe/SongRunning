//
//  DeatilCell.h
//  WonderfulLife
//
//  Created by 韩俊强 on 15/7/10.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TracelDeatil.h"
@interface DeatilCell : UITableViewCell

@property (nonatomic  , strong )UIImageView *traImageView;
@property (nonatomic , strong) UILabel *traContentLabel;
@property (nonatomic , strong) TracelDeatil *travelDeatil;
@property (nonatomic , strong) UILabel *timeLabel;
//返回cell的高度
+(CGFloat)cellHeight:(TracelDeatil *)tracelDeatil;

@end
