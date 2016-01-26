//
//  ReadCell.h
//  SongRunning
//
//  Created by 韩俊强 on 15/12/3.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ReadModel;

@interface ReadCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) ReadModel *model;

@end
