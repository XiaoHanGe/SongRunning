//
//  ReadCollectionViewController.m
//  SongRunning
//
//  Created by 韩俊强 on 15/12/3.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//

#import "ReadCollectionViewController.h"

@interface ReadCollectionViewController ()<SDCycleScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NetWorkEngineBlock *netWork;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSMutableArray *carouselArray;

@property (nonatomic, strong) NSMutableArray *urlArray;

@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ReadCollectionViewController

- (NSMutableDictionary *)dataDic
{
    if (!_dataDic) {
        self.dataDic = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    return _dataDic;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)carouselArray
{
    if (!_carouselArray) {
        self.carouselArray = [NSMutableArray array];
    }
    return _carouselArray;
}

- (NSMutableArray *)urlArray
{
    if (!_urlArray) {
        self.urlArray = [NSMutableArray array];
    }
    return _urlArray;
}

- (NSMutableArray *)imageArray
{
    if (!_imageArray) {
        self.imageArray = [NSMutableArray array];
    }
    return _imageArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -200, kScreenW, 200)];
    
    [self.collectionView addSubview:self.scrollView];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.contentInset = UIEdgeInsetsMake(200, 1, 1, 1);
    
   
    // 加载数据
    [self loadData];
    
    // 代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;

    // 注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"ReadCell" bundle:nil] forCellWithReuseIdentifier:kReadCell];
    
    //注册header
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"cell_id_header"];
    

  self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ReadBack"]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

// 加载数据
- (void)loadData
{
    __block ReadCollectionViewController *readVC = self;
    readVC.netWork = [[NetWorkEngineBlock alloc]initWithSuccessfulBlock:^(NSDictionary *dic) {
        
        NSArray *listArr = [[dic objectForKey:@"data"] objectForKey:@"list"];
        
        for (NSDictionary *dic  in listArr) {
            ReadModel *model = [[ReadModel alloc]initWithDictionary:dic];
            [self.dataArray addObject:model];
            
        }
        [SVProgressHUD dismiss];
        [self.collectionView reloadData];
        [self addPictures];
        
    } failBlock:^BOOL(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"获取数据失败"];
        return YES;
    }];
    
    [readVC.netWork  post:@"http://api2.pianke.me/read/columns" params:@"client=2"];
    [SVProgressHUD showSuccessWithStatus:@"正在加载..."];
}

#pragma mark - 头部轮播图
- (void)addPictures
{
    __block ReadCollectionViewController *readVC = self;
    NSURL *url = [NSURL URLWithString:@"http://api2.pianke.me/read/columns"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data != nil) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
            self.dataDic = dic[@"data"];
            [readVC findPic:dic];
            
        }
        
        
    }];
}

- (void)findPic : (NSDictionary *)dic
{
    self.carouselArray = self.dataDic[@"carousel"];
    for (NSDictionary *dic in self.carouselArray) {
        
        NSString *img = dic[@"img"];
        NSString *url = dic[@"url"];
        
        [self.imageArray addObject:img];
        [self.urlArray addObject:url];
    }
    
    NSMutableArray *imageUrlString = [NSMutableArray array];
    for (int i = 0; i < self.urlArray.count; i++) {
        NSString *imageString = self.carouselArray[i][@"img"];
        [imageUrlString addObject:imageString];
        

    }
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 200)];
    SDCycleScrollView *cyclesScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenW, 200) imageURLStringsGroup:imageUrlString];
    
    cyclesScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cyclesScrollView2.delegate = self;
    cyclesScrollView2.dotColor = [UIColor whiteColor];
    view = cyclesScrollView2;
    [self.scrollView addSubview:view];
    
    
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    PicViewController *picVC = [[PicViewController alloc]init];
    picVC.url = self.urlArray[index];
    picVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:picVC animated:YES];
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kScreenW / 3.3,  kScreenW / 3.3);
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

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    ReadHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kReadHeader forIndexPath:indexPath];
    
    return headerView;
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataArray.count;
}




- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ReadCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReadCell forIndexPath:indexPath];

    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ReadModel *model = self.dataArray[indexPath.row];
    ReadDetailTableViewController *readDetailVC = [[ReadDetailTableViewController alloc]init];
    readDetailVC.aId = model.type;
    readDetailVC.title = model.name;
    readDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:readDetailVC animated:YES];
    
    
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
