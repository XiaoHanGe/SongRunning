//
//  LibraryViewController.m
//  SongRunning
//
//  Created by 韩俊强 on 15/12/8.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//

#import "LibraryViewController.h"

@interface LibraryViewController ()<UIScrollViewDelegate>

@end

@implementation LibraryViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self layoutSubviews];
    
    
}

// 布局
- (void)layoutSubviews
{
    [self layoutScrollView];
}

// scrollView
- (void)layoutScrollView
{
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    // 设置页面内容的大小
    scroll.contentSize = CGSizeMake(kImageCount *kScreenW, kScreenH);
    // 关闭水平滑动指示器
    scroll.showsHorizontalScrollIndicator = NO;
    // 设置整屏滑动
    scroll.pagingEnabled = YES;
    scroll.tag = kScrollViewTag;
    
    // 给scrollView设置代理
    scroll.delegate = self;
    
    [self.view addSubview:scroll];
    
    for (int i = 0; i < kImageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenW * i, 0, kScreenW, kScreenH)];
        
        NSString *imageName = [NSString stringWithFormat:@"scr%d",i + 1];
        
        imageView.image = [UIImage imageNamed:imageName];
        [scroll addSubview:imageView];
        
        if (i == kImageCount - 1) {
            // 如果是最后一张图片名,则添加轻拍手势
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap : )];
            [imageView addGestureRecognizer:tap];
            
            // 打开imageView用户交互
            imageView.userInteractionEnabled = YES;
            
        }
        
    }
    
}

- (void)handleTap : (UIGestureRecognizer *)tap
{
    // 最后一张图片时,意味着用户引导图界面启动结束,将内容储存到NSUserdefaults中
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setBool:YES forKey:@"xiaohange"];
    // 进入主程序
    MainTabbarController *mainVC = [[MainTabbarController alloc]init];
    
    // 立即同步
    [user synchronize];
    // 更新window的根视图控制器为主界面控制器对象
    [UIApplication sharedApplication].keyWindow.rootViewController = mainVC;
}


- (void)layoutPageControl
{
    CGRect frame = CGRectMake((kScreenW - 200) / 2, kScreenH - 50, 200, 40);
    UIPageControl *page = [[UIPageControl alloc]initWithFrame:frame];
    // 设置pageController总页数
    page.numberOfPages = kImageCount;
    page.currentPageIndicatorTintColor = [UIColor redColor];
    page.tag = kPageControlTag;
    
    // 添加事件
    [page addTarget:self action:@selector(handlePage : ) forControlEvents:(UIControlEventValueChanged) ];
    
    [self.view addSubview:page];
}
     

- (void)handlePage : (UIPageControl *)page
{
    // 获取UIScrollView
    UIScrollView *scroll = (UIScrollView *)[self.view viewWithTag:kScrollViewTag];
    
    // 根据分页索引修改scrollView的偏移量
    [scroll setContentOffset:CGPointMake(page.currentPage * kScreenW, 0)animated:YES];
 
}
#pragma mark - UIScrollViewDelegate
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    // 获取scrollowView的偏移量
//    NSUInteger index = scrollView.contentOffset.x / kScreenW;
//    
//    // 获取到UIPageController
//    UIPageControl *page = (UIPageControl *)[self.view viewWithTag:kScrollViewTag];
//    
//    // 设置pageControl当前页
////    page.currentPage = index;
//    
//    
//}


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
