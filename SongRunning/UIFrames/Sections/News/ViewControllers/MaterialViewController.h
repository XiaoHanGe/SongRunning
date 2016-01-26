//
//  MaterialViewController.h
//  Everyday
//
//  Created by lz on 15/10/7.
//  Copyright (c) 2015年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaterialViewController : UIViewController

@property (nonatomic, copy) NSString *aId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property(nonatomic,retain)MBProgressHUD *hud;//创建辅助视图
@end
