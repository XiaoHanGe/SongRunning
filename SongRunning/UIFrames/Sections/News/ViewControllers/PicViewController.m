//
//  PicViewController.m
//  Everyday
//
//  Created by lz on 15/10/12.
//  Copyright (c) 2015年 lz. All rights reserved.
//

#import "PicViewController.h"

@interface PicViewController ()<UIWebViewDelegate,UMSocialUIDelegate,UIActionSheetDelegate>



@property(nonatomic,retain)MBProgressHUD *hud;//创建辅助视图

@end


@implementation PicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"推荐";
    
    [self loadData];
    
    //右button
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(handleSave:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //添加菊花效果
    [self addProgressHub];
}

//添加菊花效果
- (void)addProgressHub{
    //创建一个进度辅助视图
    //初始化
    self.hud = [[MBProgressHUD alloc]init];
    //给它一个大小，一般设置为和屏幕大小一致
    self.hud.frame = CGRectMake(-80, kScreenH / 8, 500, 500);
    
    //设置菊花视图的大小
    self.hud.minSize = CGSizeMake(0, 0);
    
    //设置菊花视图的样式
    self.hud.mode = MBProgressHUDModeIndeterminate;
    //添加到父视图
    [self.view addSubview:self.hud];
    //让菊花显示到屏幕上
    [self.hud show:YES];
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];//显示透明指示层
    
    
}

//收藏分享的实现
- (void)handleSave:(UIBarButtonItem *)rightIten{
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:APPKEY
                                      shareText: @"爱音乐,爱旅游.欢迎使用SongRunning应用,我们以最好的视听体验展现给您!"
                                     shareImage: [UIImage imageNamed:@"sharing"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToLine,UMShareToDouban,nil]
                                       delegate:self];
    
    
}



//第三方分享调用方法
-(BOOL)isDirectShareInIconActionSheet
{
    return YES;
}
//回调方法
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        //        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}


- (void)loadData
{
    self.myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -84, self.view.frame.size.width, self.view.frame.size.height + 84)];
    self.contentid = [self.url substringFromIndex:17];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http:pianke.me/posts/%@?f=appshare",self.contentid]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.myWebView loadRequest:request];
    self.myWebView.delegate = self;
    [self.view addSubview:self.myWebView];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSMutableString *js = [NSMutableString string];
    [js appendString:@"var sslogan = document.getElementsByClassName('slogan')[0];"];
    [js appendString:@"sslogan.parentNode.removeChild(sslogan);"];
    [js appendString:@"var footers = document.getElementsByClassName('footer')[0];"];
    [js appendString:@"footers.parentNode.removeChild(footers);"];
    [self.hud hide:YES];
    [self.myWebView stringByEvaluatingJavaScriptFromString:js];
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
