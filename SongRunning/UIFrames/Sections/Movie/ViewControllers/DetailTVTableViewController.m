//
//  DetailTVTableViewController.m
//  SongRunning
//
//  Created by 韩俊强 on 15-10-10.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//

#import "DetailTVTableViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "TVmodel.h"
#import "UIImageView+WebCache.h"
#import "DetailCell.h"
#import "RecommendCell.h"
#import "CommentCell.h"
#import "CommentModel.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"

@interface DetailTVTableViewController ()<UMSocialUIDelegate>

// 头分区视频属性
@property (nonatomic , strong) NSString *videoPath;
@property (nonatomic , strong) MPMoviePlayerController *player;
@property (nonatomic , strong) UIImageView *imageView;

// 评论cell属性
@property (nonatomic , strong) NSMutableArray *dataArray;


// 推荐cell属性
@property (nonatomic , strong) UIScrollView *scroller;
@property (nonatomic , strong) NSMutableArray *recommendArray;


@end

@implementation DetailTVTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    
    
    // 初始化数组
    self.dataArray = [NSMutableArray array];
    
    self.recommendArray = [NSMutableArray array];
    
    [self.tableView headerBeginRefreshing];
    // 刷新
//    [self.tableView addHeaderWithTarget:self action:@selector(downRefresh)];
    

    // 头分区
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    
    self.tableView.tableHeaderView = headView;
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"10271149,1920,1080" ofType:@"png"];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.tableHeaderView.frame.size.width, self.tableView.tableHeaderView.frame.size.height)];
    
    [self.tableView.tableHeaderView addSubview:self.imageView];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.model.thumbnailV2] placeholderImage:[UIImage imageNamed:imagePath]];
    
    // 添加button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    CGRect frame = button.frame;
    frame = CGRectMake(0, 0, 80, 80);
    button.frame = frame;
    button.center = CGPointMake(self.tableView.tableHeaderView.center.x, self.tableView.tableHeaderView.center.y);
    
    [button setBackgroundImage:[UIImage imageNamed:@"iconfont-bofang.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageView addSubview:button];
    self.imageView.userInteractionEnabled = YES;
    
    
    
    // 创建scrollerView
    self.scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 140)];
    self.scroller.contentSize = CGSizeMake(1610, 140);
    self.scroller.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i < 10; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * 160 + 10, 10, 150, 120)];
        
        imageView.tag = 100 + i;
        
        imageView.image = [UIImage imageNamed:@"10271149,1920,1080.png"];
        
        imageView.userInteractionEnabled = YES;
        
        // 添加轻拍手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapAction:)];
        [imageView addGestureRecognizer:tap];
        
        [self.scroller addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.frame.size.height - 20, imageView.frame.size.width, 20)];
        label.backgroundColor = [UIColor whiteColor];
        label.alpha = 0.5;
        label.font = [UIFont fontWithName:@"Helvetica" size:14.f];
        [imageView addSubview:label];
        
    }
    
    // 解析推荐cell数据
    [self parserRecommendData];
    
    // 解析评论数据
    [self parserCommentData];
    

    
}


// 轻拍手势事件
- (void)imageViewTapAction:(UITapGestureRecognizer *)sender
{
    if (self.recommendArray.count != 0) {
        [self.player pause];
        
        UIImageView *imageView = (UIImageView *)sender.view;
        
        NSInteger n = imageView.tag - 100;
        
        TVmodel *model = self.recommendArray[n];
        
        self.model = model;
        
        [self viewDidLoad];
    }
    
}



// 解析推荐数据
- (void)parserRecommendData
{
    
    NSURL *url = [NSURL URLWithString:@"http://115.28.54.40:8080/beautyideaInterface/api/v1/resources/recommend_res?albumId=&deviceModel=MI+2S&username=&plamformVersion=4.1.1&deviceName=Xiaomi&plamform=Android&modulesId=1&imieId=1D975AB95DCAC407C992D49FA9F160C0"];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
       
        if (data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            if (dic) {
                NSArray *arr = dic[@"resources"];
                
                for (NSDictionary *minDic in arr) {
                    TVmodel *model = [[TVmodel alloc] init];
                    
                    [model setValuesForKeysWithDictionary:minDic];
                    
                    [self.recommendArray addObject:model];
                }
                
                for (int i = 0; i < self.recommendArray.count; i++) {
                    TVmodel *model = self.recommendArray[i];
                    UIImageView *imageView = self.scroller.subviews[i];
                    [imageView sd_setImageWithURL:[NSURL URLWithString:model.thumbnailV2]];
                 
                    UILabel *label = imageView.subviews[0];
                    
                    label.text = model.title;
                    
                }
            }
        }
    }];
}




//// 下拉刷新
//- (void)downRefresh
//{
//    [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeBlack];
//    [self.player pause];
//    [self.dataArray removeAllObjects];
//    [self.recommendArray removeAllObjects];
//
//    
//}




// button点击事件 视频播放
- (void)buttonAction:(UIButton *)sender
{
    NSString *urlStr = [NSString stringWithFormat:@"http://115.28.54.40:8080/beautyideaInterface/api/v1/resources/getPlayAdressByIdAndLink?deviceModel=MI203W&version=2.0.4&plamformVersion=4.4.4&deviceName=Xiaomi&plamform=Android&rsId=%@&link=%@&imieId=89C08204B262E99BF470D7E34BB7EE4E" , self.model.rsId , self.model.link];
    
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data != nil) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

            self.videoPath = dic[@"player"];
            
            self.player = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:self.videoPath]];
            
            self.player.view.frame = CGRectMake(0, 0, self.tableView.tableHeaderView.frame.size.width, self.tableView.tableHeaderView.frame.size.height);
            [self.tableView.tableHeaderView addSubview:self.player.view];
            
            [self.player play];
        }
    }];
    
}



// 解析评论数据
- (void)parserCommentData
{
    NSString *urlStr = [NSString stringWithFormat:@"http://115.28.54.40:8080/beautyideaInterface/api/v1/comments/getCommentsByRsId?pageNo=0&deviceModel=MI+2S&plamformVersion=4.1.1&deviceName=Xiaomi&plamform=Android&rsId=%@&pageSize=10&imieId=1D975AB95DCAC407C992D49FA9F160C0" , self.model.rsId];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data != nil) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            if (dic != nil) {
                
                NSArray *arr = dic[@"comments"];
                
                for (NSDictionary *minDic in arr) {
                    
                    CommentModel *model = [[CommentModel alloc] init];
                    
                    for (NSString *key in minDic) {
                        if ([key isEqualToString:@"content"]) {
                            model.content = minDic[@"content"];
                        }else if ([key isEqualToString:@"published"]) {
                            model.published = minDic[@"published"];
                        }else if ([key isEqualToString:@"users"]) {
                            
                            NSDictionary *miniDic = minDic[@"users"];
                            
                            for (NSString *key in miniDic) {
                                if ([key isEqualToString:@"nickname"]) {
                                    model.name = miniDic[@"nickname"];
                                }
                            }
                        }
                }
                    
                    [self.dataArray addObject:model];
                
              }
                
                [self.tableView reloadData];
                [self.tableView headerEndRefreshing];
                [self.tableView footerEndRefreshing];
                [SVProgressHUD dismiss];
            }
            
        } else {
            [SVProgressHUD dismiss];
            [self.tableView headerEndRefreshing];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"加载失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }];
    
    
}


// 分享按钮
- (IBAction)ShareAction:(id)sender
{
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count + 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCellId" forIndexPath:indexPath];
        
        cell.titleLabel.text = self.model.title;
        cell.commentLabel.text = [NSString stringWithFormat:@"评论数:%ld" , self.model.commentcount];
        cell.publishedLabel.text = [NSString stringWithFormat:@"发布日期:%@", self.model.published];
        
        return cell;
        
    }else if (indexPath.row == 1) {
        RecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recommendCellId" forIndexPath:indexPath];
        
        [cell.contentView addSubview:self.scroller];
        
        return cell;
        
    }else {
        
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCellId" forIndexPath:indexPath];
        
        CommentModel *model = self.dataArray[indexPath.row - 2];
        
        cell.nameLabel.text = [NSString stringWithFormat:@"%@ :" , model.name];
        cell.commentLabel.text = [NSString stringWithFormat:@"  %@" , model.content];
        cell.publishDateLabel.text = model.published;
        
        return cell;
        
    }
    
}


// 返回各cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 120;
    }else if (indexPath.row == 1) {
        return 140;
    }else {
        return 100;
    }
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
