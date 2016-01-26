//
//  TVTableViewController.m
//  SongRunning
//
//  Created by 韩俊强 on 15-10-7.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//

#import "TVTableViewController.h"
#import "TVCell.h"
#import "TVmodel.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
#import "DetailTVTableViewController.h"
#import "PlaySingleton.h"

@interface TVTableViewController ()

@property (nonatomic , strong) NSMutableArray *dataArray;
@property (nonatomic , assign) NSInteger pageNumber;
@property (nonatomic , assign) BOOL isDown;



@end

@implementation TVTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
    // 添加刷新/加载
    [self.tableView addHeaderWithTarget:self action:@selector(downRefresh)];
    [self.tableView addFooterWithTarget:self action:@selector(upRefresh)];
    
    [self downRefresh];
    
    
}


// 下拉刷新
- (void)downRefresh
{
    self.isDown = YES;
    self.pageNumber = 0;
    [SVProgressHUD showWithStatus:@"刷新中..." maskType:SVProgressHUDMaskTypeBlack];
    [self parserJsonData];
    
}


// 上拉加载
- (void)upRefresh
{
    self.isDown = NO;
    self.pageNumber++;
    [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeBlack];
    [self parserJsonData];
    
}




// 解析数据
- (void)parserJsonData
{
    
    NSString *urlStr = [NSString stringWithFormat:@"http://115.28.54.40:8080/beautyideaInterface/api/v1/resources/getResources?pageNo=%ld&deviceModel=MI+2S&plamformVersion=4.1.1&deviceName=Xiaomi&plamform=Android&pageSize=10&imieId=1D975AB95DCAC407C992D49FA9F160C0" , self.pageNumber * 10];
    
    NSString *newStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:newStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data != nil) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            if (dic) {
                for (NSString *key in dic) {
                    if ([key isEqualToString:@"resources"]) {
                        NSArray *arr = dic[@"resources"];
                        
                        // 下拉刷新初始化数据源
                        if (self.isDown) {
                            self.dataArray = [NSMutableArray array];
                        }
                        
                        for (NSDictionary *minDic in arr) {
                            
                            TVmodel *model = [[TVmodel alloc] init];
                
                            [model setValuesForKeysWithDictionary:minDic];
                            
                            
                            [self.dataArray addObject:model];
                            
                        }
                        
                        [self.tableView reloadData];
                        [self.tableView headerEndRefreshing];
                        [self.tableView footerEndRefreshing];
                        
                        [SVProgressHUD dismiss];
                        
                    }
                }
            }
        } else {
            [SVProgressHUD dismiss];
            [self.tableView headerEndRefreshing];
            [self.tableView footerEndRefreshing];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"加载失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }
        
    }];
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
    
    return self.dataArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    
    // Configure the cell...
    
    TVmodel *model = self.dataArray[indexPath.row];
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"10271149,1920,1080" ofType:@"png"];
    [cell.mainImageView sd_setImageWithURL:[NSURL URLWithString:model.thumbnailV2] placeholderImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    NSString *ciShuStr = [NSString stringWithFormat:@"%ld" , model.viewCount];
    cell.ciShuLabel.text = ciShuStr;
    
    NSString *huiFuStr = [NSString stringWithFormat:@"%ld" , model.commentcount];
    cell.pingLunLabel.text = huiFuStr;
    
    cell.timeLabel.text = model.duration;
    
    cell.titleLabel.text = model.title;
    
    
    return cell;
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


#pragma mark - Navigation


// 线方法

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    TVmodel *model = self.dataArray[indexPath.row];
    
    DetailTVTableViewController *detailVC = segue.destinationViewController;
    
    detailVC.model = model;
    
    detailVC.hidesBottomBarWhenPushed = YES;
}


@end
