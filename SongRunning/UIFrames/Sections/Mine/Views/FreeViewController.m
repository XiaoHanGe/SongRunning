//
//  FreeViewController.m
//  LetUsGo
//
//  Created by 韩俊强 on 15/11/6.
//  Copyright (c) 2015年 jinngwei. All rights reserved.
//

#import "FreeViewController.h"

@interface FreeViewController ()
@property (nonatomic,retain)UIImageView *image;
@property (nonatomic,retain)UILabel *label;
@property (nonatomic,retain)UILabel *label1;
@property (nonatomic,retain)UILabel *label2;
@property (nonatomic,retain)UILabel *label3;
@end

@implementation FreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    self.title = @"责任声明";
}
- (void)setupView{
    self.image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    self.image.image = [UIImage imageNamed:@"ReadBack"];
    [self.view addSubview:self.image];
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(30, 70, kScreenW - 60, 40)];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont systemFontOfSize:24];
    self.label.textColor = [UIColor grayColor];
    
    self.label.text = @" 责任声明 ";
    
    [self.image addSubview:self.label];
    
    
    self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.label.frame), kScreenW - 20, 110)];

    self.label1.text = @" 1.本app所有内容,包括文字/图片/音频/视频/软件/程序/以及版式设计等均在网上搜集,均来自于网络仅用于技术学习与交流,发布资源均来源于互联网,版权归原作者所有. ";
    self.label1.numberOfLines = 0;
 

    [self.image addSubview:self.label1];
    
    
    self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.label1.frame), kScreenW - 20, 110)];
    self.label2.numberOfLines = 0;
    self.label2.text = @"2.访问者可将本app提供的内容或服务用于个人学习/研究或欣赏,以及其他商业性或盈利性用途,但同时应遵守著作权法及其它相关法律的规定,不得侵犯本app及相关权利人的合法权利.";
    self.label2.textColor = [UIColor blackColor];
    [self.image addSubview:self.label2];
    
    
    self.label3 = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.label2.frame), kScreenW - 20, 110)];
    self.label3.numberOfLines = 0;
    self.label3.text = @"3.将本app任何内容或者服务用于其他用途时,须征得本app及相关权利人的书面许可,并支付报酬,如本app所包含内容的原作者不愿意在本app刊登内容,请及时通知本app,予以删除.";
    self.label3.textColor = [UIColor blackColor];
    [self.image addSubview:self.label3];
    
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
