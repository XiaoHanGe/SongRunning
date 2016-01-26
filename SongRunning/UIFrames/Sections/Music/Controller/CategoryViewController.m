//
//  CategoryViewController.m
//  SoulSounds
//
//  Created by 韩俊强 on 15-10-12.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//

#import "CategoryViewController.h"


@interface CategoryViewController ()<UITableViewDataSource , UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *showTableView;

@property (nonatomic , strong) UISegmentedControl *segment;
@property (nonatomic , strong) NSMutableArray *dataArray;
@property (nonatomic , strong) BlockHelper *blockHelper;
@property (nonatomic , assign) NSInteger pageNumber;
@property (nonatomic , assign) BOOL isDownRefresh;
@property(nonatomic,retain)MBProgressHUD *hud;//创建辅助视图

@end

@implementation CategoryViewController

static NSString * const reuseIdentifier = @"categoryCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageNumber = 1;
    self.navigationItem.titleView = self.segment;
    [self getDataFromServerWithSort:0 andCategory:self.countId andPage:self.pageNumber];
    
    self.showTableView.delegate = self;
    self.showTableView.dataSource = self;
    [self.showTableView registerNib:[UINib nibWithNibName:@"CategoryCell" bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    
//    [self.showTableView addHeaderWithTarget:self action:@selector(loadNewData)];
//    [self.showTableView addFooterWithTarget:self action:@selector(loadMoreData)];
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

#pragma mark - 更新数据
//- (void)loadNewData
//{
//    self.isDownRefresh = YES;
//    [self getDataFromServerWithSort:self.segment.selectedSegmentIndex andCategory:self.countId andPage:self.pageNumber];
//}
//
//- (void)loadMoreData
//{
//    self.isDownRefresh = NO;
//    [self getDataFromServerWithSort:self.segment.selectedSegmentIndex andCategory:self.countId andPage:self.pageNumber];
//}

#pragma mark - 懒加载
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        self.dataArray = [@[] mutableCopy];
    }
    return _dataArray;
}
- (UISegmentedControl *)segment
{
    if (!_segment) {
        NSArray *titleArray = @[@"经典排序" , @"最近更新" , @"最火排序"];
        self.segment = [[UISegmentedControl alloc] initWithItems:titleArray];
        self.segment.frame = CGRectMake(50, 20, 150, 40);
        self.segment.selectedSegmentIndex = 0;
        [self.segment addTarget:self action:@selector(changeWay:) forControlEvents:UIControlEventValueChanged];
    }
    return _segment;
}

// 选择不同的排序方式
- (void)changeWay:(UISegmentedControl *)sender
{
    if (self.dataArray.count != 0) {
        [self.dataArray removeAllObjects];
    }
    self.pageNumber = 1;
    [self getDataFromServerWithSort:sender.selectedSegmentIndex andCategory:self.countId andPage:self.pageNumber];
}

#pragma maek - 服务器交互
- (void)getDataFromServerWithSort:(NSInteger)segmentPage andCategory:(NSNumber *)categoryId andPage:(NSInteger)page
{
    NSString *urlString = [NSString stringWithFormat:@"http://www.duole.fm/api/category/get_collect_list?category_id=%@&visitor_uid=(null)&sort=%ld&sublayer=0&rm_empty=1&finish=0&page=%d&limit=20&device=iphone" , categoryId , (long)segmentPage , 1];
    self.blockHelper = [[BlockHelper alloc] init];
    __block CategoryViewController *blockSelf = self;
    [self.blockHelper blockHelperBeginRequestWithUrlString:urlString success:^(NSData *data) {
        [blockSelf parseDataWithData:data];
    } fail:^(NSError *error) {
        
    }];
}

// 数据解析
- (void)parseDataWithData:(NSData *)data
{
    if (self.dataArray.count != 0 && self.isDownRefresh) {
        [self.dataArray removeAllObjects];
    }
    NSDictionary *dicData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *dataArr = dicData[@"data"];
    for (NSDictionary *dict in dataArr) {
        CategoryModel *model = [[CategoryModel alloc] init];
        model.title = dict[@"title"];
        model.cover_url = dict[@"cover_url"];
        model.count_play = dict[@"count_play"];
        NSString *str = [dict[@"update_time"] stringValue];
        model.update_time = [self stringFromDate:str];
        model.count_sound = dict[@"count_sound"];
        model.countId = dict[@"id"];
        [self.dataArray addObject:model];
    }
    [self.hud hide:YES];
    [self.showTableView reloadData];
    [self.showTableView headerEndRefreshing];
    [self.showTableView footerEndRefreshing];
}

// 时间转换
- (NSString *)stringFromDate:(NSString *)string
{
    NSDateFormatter *dateFormat = [NSDateFormatter new];
    [dateFormat setDateStyle:NSDateFormatterMediumStyle];
    [dateFormat setTimeStyle:NSDateFormatterShortStyle];
    [dateFormat setDateFormat:@"yyyy-MM-dd H:mm:ss"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[string intValue]];
    NSString *str = [dateFormat stringFromDate:date];
    return str;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    CategoryModel *model = self.dataArray[indexPath.row];
    [cell initWithModel:model];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
//    cell.accessoryView.backgroundColor = WEIBOColor(254, 231, 231);
    cell.backgroundColor = WEIBOColor(254, 231, 231);
    return cell;
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MusicPlayViewController *musicPlayVC = [[MusicPlayViewController alloc] initWithNibName:@"MusicPlayViewController" bundle:nil];

    musicPlayVC.hidesBottomBarWhenPushed = YES;
    CategoryModel *model = self.dataArray[indexPath.row];
    musicPlayVC.count_sound = model.count_sound;
    musicPlayVC.musicId = model.countId;
    [self.navigationController pushViewController:musicPlayVC animated:YES];
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
