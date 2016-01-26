//
//  ReadDetailTableViewController.h
//  Everyday
//
//  Created by lz on 15/10/12.
//  Copyright (c) 2015年 lz. All rights reserved.
//

#import "RefreshTableViewController.h"

#import <UIKit/UIKit.h>

@interface ReadDetailTableViewController : RefreshTableViewController

@property (nonatomic, assign) NSInteger aId;
@property (nonatomic, copy) NSString *title;

@end
