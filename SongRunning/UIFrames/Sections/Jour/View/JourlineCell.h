//
//  JourlineCell.h
//  Hiking
//
//  Created by 韩俊强 on 15/8/18.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JourNotes;
@interface JourlineCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mainImageVie;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel1;
@property (weak, nonatomic) IBOutlet UIImageView *logo1;
@property (nonatomic ,strong) UILabel *hehelabel;
@property (nonatomic ,strong) JourNotes *journote;
@property (weak, nonatomic) IBOutlet UILabel *heheLabel1;

@end
