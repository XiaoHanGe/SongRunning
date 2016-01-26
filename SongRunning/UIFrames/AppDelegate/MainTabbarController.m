//
//  MainTabbarController.m
//  Hjq二维码
//
//  Created by 韩俊强 on 15/11/30.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//

#import "MainTabbarController.h"
#import "TVTableViewController.h"
@interface MainTabbarController ()


@end

@implementation MainTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];

   // 旅行
    JourController *movieVC = [[JourController alloc] initWithStyle:(UITableViewStylePlain)];
    UINavigationController *movieNC = [[UINavigationController alloc]initWithRootViewController:movieVC];
    movieVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_index"];
    [self addNavigationController:movieNC];
    movieVC.title = @"爱旅行";
    
    // 音乐
    MusicViewController *mVC = [[MusicViewController alloc]init];
    UINavigationController *mNC = [[UINavigationController alloc]initWithRootViewController:mVC];
    mNC.tabBarItem.image = [UIImage imageNamed:@"music"];
    [self addNavigationController:mNC];
    mVC.title = @"爱音乐";
    
    // 视频
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TVTableViewController *tvVC = [storyboard instantiateViewControllerWithIdentifier:@"movie"];
    UINavigationController *tvNC = [[UINavigationController alloc]initWithRootViewController:tvVC];
    tvNC.tabBarItem.image = [UIImage imageNamed:@"iconfont-shipin(1)"];
    [self addNavigationController:tvNC];

    tvVC.title = @"视频";
    
    // 阅读
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
     // 设置分区缩进量
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 0, 0, 0);
    
    ReadCollectionViewController *songVC = [[ReadCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
    UINavigationController *songNC = [[UINavigationController alloc]initWithRootViewController:songVC];
    songNC.tabBarItem.image = [UIImage imageNamed:@"tabbar_icon_reader_normal@2x"];
    [self addNavigationController:songNC];
    songVC.title = @"阅读";
    
    
    // 我的
    MineViewController  *mineVC = [[MineViewController alloc]init];
    UINavigationController *mineNC = [[UINavigationController alloc]initWithRootViewController:mineVC];
    mineNC.tabBarItem.image = [UIImage imageNamed:@"tabbar_my"];
    [self addNavigationController:mineNC];
    mineVC.title = @"我的";
    


//    [self addNavigationController:mineNC];
    
    // 添加到tabBar
   NSArray *viewControllers = @[movieNC,mNC,tvNC,songNC,mineNC];
    self.viewControllers = viewControllers;
    
    self.tabBarController.tabBar.tintColor = WEIBOColor(255, 145, 181);
    
    self.tabBar.tintColor = WEIBOColor(255, 145, 181);
    
    
    
    
}

// 设置导航栏
- (void)addNavigationController : (UINavigationController *)table
{
    table.navigationBar.tintColor = WEIBOColor(255, 145, 181);
    table.navigationBar.tintColor = [UIColor whiteColor];
    table.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    table.navigationBar.barTintColor = [UIColor colorWithRed:255/255.0 green:145/255.0 blue:181/255.0 alpha:1];
   
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
