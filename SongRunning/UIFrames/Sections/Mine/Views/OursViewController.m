//
//  OursViewController.m
//  LetUsGo
//
//  Created by 韩俊强 on 15/11/6.
//  Copyright (c) 2015年 jinngwei. All rights reserved.
//

#import "OursViewController.h"

@interface OursViewController ()
@property (nonatomic,retain)UIImageView *photoView;
@property (nonatomic,retain)UILabel *label;
@property (nonatomic,retain)UILabel *textLabel;
@property (nonatomic,copy)NSString *contentStr;
@property (nonatomic,retain)UILabel *textLabel1;
@end

@implementation OursViewController
//- (void)viewWillAppear:(BOOL)animated{
//    
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"关于作者";
    
     [self setupview];
    self.contentStr = @"    本app由iOS开发者:韩俊强独立制作,  欢迎各位下载使用,  在使用中如果发现什么问题或者有什么好的建议请发至我的邮箱,  您的支持是我最大的动力!  邮箱:hjq99@qq.com";
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(animationLabel) object:nil];
    
    [thread start];
    
}
- (void)animationLabel{
    
    for (NSInteger i = 0; i < self.contentStr.length; i++) {
        [self performSelectorOnMainThread:@selector(refreshUIWithContentStr:) withObject:[self.contentStr substringWithRange:NSMakeRange(0, i+1)] waitUntilDone:YES];
        
        [NSThread sleepForTimeInterval:0.1];
    }
}
- (void)refreshUIWithContentStr:(NSString *)contentStr
{
    self.label.text = contentStr;
}


- (void)setupview{
    
    self.photoView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    
    self.photoView.image = [UIImage imageNamed:@"bg-sunny"];
    [self.view addSubview:self.photoView];
    
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(20, kScreenH/3, kScreenW - 40, 200)];

    self.label.numberOfLines = 7;
    [self.photoView addSubview:self.label];
    
    
    self.textLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 100, kScreenW - 60, 50)];
    self.textLabel.text = @"每一次邂逅都是一种缘分";
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.textColor = [UIColor brownColor];
    self.textLabel.font = [UIFont boldSystemFontOfSize:24];
    [self.photoView addSubview:self.textLabel];
    
    
    self.textLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(30, 150, kScreenW - 60, 50)];
    self.textLabel1.text = @"Good Luck!";
    self.textLabel1.textColor = [UIColor whiteColor];
    self.textLabel1.font = [UIFont boldSystemFontOfSize:25];
    self.textLabel1.textAlignment = NSTextAlignmentCenter;
    [self.photoView addSubview:self.textLabel1];
    
    
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
