//
//  RefreshTableViewController.h
//  Everyday
//
//  Created by lz on 15/10/7.
//  Copyright (c) 2015年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RefreshTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger pageNumber;

@property (nonatomic, assign) BOOL isPullRefresh;

- (void)loadNewData;

- (void)loadMoreData;

- (void)loadDataWithPage:(NSInteger)pageNumber;

@end
