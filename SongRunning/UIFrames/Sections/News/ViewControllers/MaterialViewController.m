//
//  MaterialViewController.m
//  Everyday
//
//  Created by lz on 15/10/7.
//  Copyright (c) 2015年 lz. All rights reserved.
//

#import "MaterialViewController.h"

@interface MaterialViewController ()<UMSocialUIDelegate,UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *myWebView;

@property (nonatomic, strong) NetWorkEngineBlock *netWork;



@end

@implementation MaterialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.title;
    self.myWebView.scrollView.showsHorizontalScrollIndicator = NO;
    [self loadNetWorkDataWithAID:self.aId];
    
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
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"收藏" otherButtonTitles:@"分享", nil];
    [actionSheet showInView:self.view];
 
    
}
//action的代理实现
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            //调用收藏方法
            [self collectionNews];
            break;
        case 1:
            //调用分享方法
            [self shareNews];
            break;
            
        default:
            break;
    }
    
    
}


//收藏方法的实现
- (void)collectionNews{
    //定义一个flag用来判断是否收藏过
    NSMutableArray *arr = [[DataBaseHandle shareDataBaseHandle]selectAllReadNews];
    BOOL collect = NO;
    for (ReadDetailModel *model in arr) {
        if ([model.title isEqualToString:self.title]) {
            collect = YES;
        }
    }
    if (collect) {
        //已经收藏过了
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"亲,您已经收藏过了!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];

    }else{
        ReadDetailModel *model = [[ReadDetailModel alloc]init];
        model.aId = self.aId;
        model.title = self.title;
        [[DataBaseHandle shareDataBaseHandle]insertReadNews:model];
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"收藏成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alertView show];
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
 
        
    }
    
    
}
 

//分享方法的实现
- (void)shareNews{
    
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





- (void)loadNetWorkDataWithAID:(NSString *)aid
{
    __block MaterialViewController *materialVC = self;
    materialVC.netWork = [[NetWorkEngineBlock alloc] initWithSuccessfulBlock:^(NSDictionary *dic) {
        NSString *htmlStr = [[dic objectForKey:@"data"] objectForKey:@"html"];
        htmlStr = [htmlStr stringByReplacingOccurrencesOfString:@"<img" withString:[NSString stringWithFormat:@"<img style='width:%fpx';",kScreenW * 1- 15]];
        htmlStr = [htmlStr stringByReplacingOccurrencesOfString:@"</pre>" withString:[NSString stringWithFormat:@"<p>"]];
        htmlStr = [htmlStr stringByReplacingOccurrencesOfString:@"</pre>" withString:[NSString stringWithFormat:@"<p>"]];
        htmlStr = [htmlStr stringByReplacingOccurrencesOfString:@"<p>" withString:[NSString stringWithFormat:@"<p style='width:%fpx;'>",kScreenW * 1 - 15]];
        [materialVC.myWebView loadHTMLString:htmlStr baseURL:nil];
            [self.hud hide:YES];
    } failBlock:^BOOL(NSError *error) {
        return YES;
    }];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * Str = [userDefaults objectForKey:@"haveLogin"];
//    Str = [Str stringByReplacingOccurrencesOfString:@"client=" withString:@""];
    [materialVC.netWork post:@"http://api2.pianke.me/article/info" params:[NSString stringWithFormat:@"contentid=%@&client=1&deviceid=BB21CDFA-12A3-4ADB-83D8-682ACAB45952&auth=%@&version=3.0.2",aid,Str]];

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
