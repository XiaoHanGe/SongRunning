//
//  MineViewCell.h
//  ZYTD
//
//  Created by 韩俊强 on 15/11/8.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineViewCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UILabel *aLabel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *photoImage;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic,retain)UILabel *cachLabel;
- (void)showTableView;
- (void)hiddenTableView;

@end
