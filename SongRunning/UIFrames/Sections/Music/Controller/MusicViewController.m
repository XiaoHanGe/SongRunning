//
//  MusicViewController.m
//  SoulSounds
//
//  Created by 韩俊强 on 15-10-10.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//

#import "MusicViewController.h"

@interface MusicViewController ()

@property (nonatomic , strong) NSMutableArray *dataArray;

@property (nonatomic , strong) BlockHelper *blockHelper;

@property(nonatomic,retain)MBProgressHUD *hud;//创建辅助视图

@end

@implementation MusicViewController

static NSString * const reuseIndentifier = @"musicCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MusicTableViewCell" bundle:nil] forCellReuseIdentifier:reuseIndentifier];
    [self getDataFromServer];
    
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ReadBack"]];
    
    
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


// 懒加载
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        self.dataArray = [@[] mutableCopy];
    }
    return _dataArray;
}

// 与服务器交互
- (void)getDataFromServer
{
    NSString *urlString = @"http://www.duole.fm/api/category/get_list?type=collect&parent_id=27&whole=0&device=iphone";
    self.blockHelper = [[BlockHelper alloc] init];
    __block MusicViewController *block = self;
    [self.blockHelper blockHelperBeginRequestWithUrlString:urlString success:^(NSData *data) {
        [block parseDataWithData:data];
    } fail:^(NSError *error) {
        
    }];
}

// 数据解析
- (void)parseDataWithData:(NSData *)data
{
    NSDictionary *dicData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dict = dicData[@"data"];
    NSArray *arr = dict[@"datalist"];
    for (NSDictionary *aDict in arr) {
        MusicModel *model = [[MusicModel alloc] init];
        model.cover_url = aDict[@"cover_url"];
        model.countId = aDict[@"id"];
        model.name = aDict[@"name"];
        [self.dataArray addObject:model];
    }
    [self.tableView reloadData];
    [self.hud hide:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MusicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIndentifier forIndexPath:indexPath];
    
    MusicModel *model = self.dataArray[indexPath.row];
    [cell initWithModel:model];
    
    // 设置右侧图标
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = WEIBOColor(254, 231, 231);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryViewController *categoryVC = [[CategoryViewController alloc] init];
    MusicModel *model = self.dataArray[indexPath.row];
    categoryVC.countId = model.countId;
    
    categoryVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:categoryVC animated:YES];
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
