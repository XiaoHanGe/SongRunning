//
//  JourController.m
//  Hiking
//
//  Created by 韩俊强 on 15/8/11.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//
#import "MJRefresh.h"
#import "JourController.h"
#import "JourNotes.h"
#import "JourlineCell.h"
#import "JourDetailController.h"
@interface JourController ()
@property (nonatomic ,strong) NSMutableArray *dataArray;
@property (nonatomic ,assign ) int page;
@property (nonatomic ,assign) BOOL isDownRefresh;
@property(nonatomic,retain)MBProgressHUD *hud;//创建辅助视图
@end

@implementation JourController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.dataArray   = [NSMutableArray array];

    
    [self loadDataShow:self.page];
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewData)];
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreData)];

    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"JourlineCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    //添加菊花效果
    [self addProgressHub];
    
      self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ReadBack"]];
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


-(void)loadDataShow:(int)page
{
    NSString *url = [NSString stringWithFormat:@"http://tubu.ibuzhai.com/rest/v1/travelog/recommends?&app_version=3.9.4&page_size=20&type=19&api_version=1&page=%d&device_type=2",page];
    NSURL *urlString = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlString];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *array = [dic objectForKey:@"logs"];
            for (NSDictionary *newdic in array) {
                JourNotes *jourLine  = [JourNotes new];
                [jourLine setValuesForKeysWithDictionary:newdic];
                jourLine.photo_number = [newdic[@"photo_number"] stringValue];
                jourLine.ID = newdic[@"id"];
                NSDictionary *dic2 = newdic[@"created_by"];
                [jourLine setValuesForKeysWithDictionary:dic2];
                jourLine.name = newdic[@"name"];
                [self.dataArray addObject:jourLine];
                
            }
            [self.tableView reloadData];
            //隐藏菊花
            [self.hud hide:YES];
        }
        
        
    }];
}
//下拉加载更多
-(void)loadMoreData
{
    self.isDownRefresh = NO;
    [self loadDataShow:++self.page];
    [self.tableView footerEndRefreshing];
}
//上拉 刷新 
-(void)loadNewData
{
    self.isDownRefresh = YES;
    [self loadDataShow:1];
    [self.tableView headerEndRefreshing];
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


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    JourlineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
    JourNotes *journote = self.dataArray[indexPath.row];

    cell.journote = journote;
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JourDetailController *jourDeatilVC = [JourDetailController new];
    JourNotes *jounote = self.dataArray[indexPath.row];
    jourDeatilVC.travelNotes = jounote;
    jourDeatilVC.deatilID = jounote.ID;
    jourDeatilVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:jourDeatilVC animated:YES];
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
