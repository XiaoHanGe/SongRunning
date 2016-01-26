//
//  ReadDetailTableViewController.m
//  Everyday
//
//  Created by lz on 15/10/12.
//  Copyright (c) 2015年 lz. All rights reserved.
//

#import "ReadDetailTableViewController.h"

#import "ReadDetailModel.h"
#import "ReadDetailCell.h"
#import "MaterialViewController.h"

@interface ReadDetailTableViewController ()

@property (nonatomic, strong) NetWorkEngineBlock *netWork;

@end

@implementation ReadDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView .rowHeight = 120;
    self.navigationItem.title = self.title;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ReadDetailCell" bundle:nil] forCellReuseIdentifier:kReadCell];
    
    [SVProgressHUD showWithStatus:@"正在加载..."];
    [self loadNewData];
    
    
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)loadNewData{
    self.isPullRefresh = YES;
    self.pageNumber = 0;
    [self loadDataWithPage:self.pageNumber];
}

- (void)loadMoreData{
    self.isPullRefresh = NO;
    self.pageNumber += 10;
    [self loadDataWithPage:self.pageNumber];
}

-(void)loadDataWithPage:(NSInteger)pageNumber
{
    __block ReadDetailTableViewController * readDetailTVC = self;
    readDetailTVC.netWork = [[NetWorkEngineBlock alloc] initWithSuccessfulBlock:^(NSDictionary *dic) {
        NSArray *arr = [[dic objectForKey:@"data"] objectForKey:@"list"];
        if (self.isPullRefresh) {
            [self.dataArray removeAllObjects];
        }
        for (NSDictionary *dic in arr) {
            ReadDetailModel *model = [[ReadDetailModel alloc] initWithDictionary:dic];
            [self.dataArray addObject:model];
        }
        [SVProgressHUD dismiss];
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        [self.tableView reloadData];
    } failBlock:^BOOL(NSError *error) {
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        [SVProgressHUD showErrorWithStatus:@"获取数据失败"];
        return YES;
    }];
    [readDetailTVC.netWork post:@"http://api2.pianke.me/read/columns_detail" params:[NSString stringWithFormat:@"sort=addtime&start=%ld&client=2&typeid=%ld&limit=10", (long)pageNumber, (long)self.aId]];
}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    ReadDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:kReadCell forIndexPath:indexPath];
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

// 动画
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    cell.frame = CGRectMake(-self.view.width, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
//    [UIView animateWithDuration:0.5 animations:^{
//        cell.frame = CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
//    } completion:^(BOOL finished) {
//        
//    }];
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MaterialViewController *materialVC = [[MaterialViewController alloc] init];
    ReadDetailModel *model = self.dataArray[indexPath.row];;
    materialVC.aId = model.aId;
    materialVC.title = model.title;
    materialVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:materialVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
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
