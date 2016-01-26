//
//  JourDetailView.m
//  SongRunning
//
//  Created by 韩俊强 on 15/12/8.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//

#import "JourDetailView.h"

@interface JourDetailView ()<UIActionSheetDelegate,UMSocialUIDelegate>


@property (nonatomic , strong) NSMutableArray *dataSourceArray;

@property (nonatomic ,copy)NSString *title;

@property (nonatomic, retain)MBProgressHUD *hud;//创建辅助视图

@end

@implementation JourDetailView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.title = @"游记详情";
    self.dataSourceArray = [NSMutableArray array];
    
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewData)];
    [self loadDataAndeShow];
    [self addtitleView];
    //添加菊花效果
    [self addProgressHub];
    
    // 隐藏table线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //右button
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(handleSave:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    
    
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
            [self collectionJour];
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
- (void)collectionJour{
    //定义一个flag用来判断是否收藏过
    NSMutableArray *arr = [[DataBaseHandle shareDataBaseHandle]selectAllJour];
    BOOL collect = NO;
    for (JourNotes *model in arr) {
        if ([model.name isEqualToString:self.name]) {
            collect = YES;
            
        }
    }
    if (collect) {
        //已经收藏过了
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"亲,您已经收藏过了!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        
    }else{
        JourNotes *model = [[JourNotes alloc]init];
        model.name = self.name;
        model.ID = self.deatilID;
        model.nickname = self.nickname;
        model.start_date = self.start_date;
        model.avatar = self.avatar;
        model.photo_number = self.photo_number;
        model.total_days = self.total_days;
        model.cover = self.cover;
        
        [[DataBaseHandle shareDataBaseHandle]insertJour:model];
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"收藏成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alertView show];
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
        
//        NSLog(@"%@",NSHomeDirectory());
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


-(void)loadNewData
{
    [self loadDataAndeShow];
    [self.tableView headerEndRefreshing];
}
-(void)addtitleView
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 255)];
    UIImageView *mainimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 170)];
    UILabel *coverLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 170, kScreenW, 20)];
    coverLabel.backgroundColor = [UIColor colorWithRed:0.4902 green:0.4902 blue:0.4902 alpha:0.5];
    coverLabel.textColor = [UIColor whiteColor];
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(10, 150, 40, 40)];
    logo.layer.cornerRadius =20;
    logo.layer.masksToBounds = YES;
    UILabel *titleLabel = [[UILabel alloc ] initWithFrame:CGRectMake(10, CGRectGetMaxY(coverLabel.frame)+5, kScreenW - 20, 30)];
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLabel.frame)+5, kScreenW - 20, 20)];
    titleLabel.font = [UIFont systemFontOfSize:18];
    dateLabel.font = [UIFont systemFontOfSize:14];
    dateLabel.textColor = [UIColor colorWithRed:0.4902 green:0.4902 blue:0.4902 alpha:1.0];
    
    
    
    if (self.travelNotes != nil ) {
        
        [mainimageView sd_setImageWithURL:[NSURL URLWithString:self.travelNotes.cover]placeholderImage:[UIImage imageNamed:@"trarl.png"]];
        [logo sd_setImageWithURL:[NSURL URLWithString:self.travelNotes.avatar]placeholderImage:[UIImage imageNamed:@"photo.png"]];
        coverLabel.text = [NSString stringWithFormat:@"            %@",self.travelNotes.nickname];
        titleLabel.text = self.travelNotes.name;
        dateLabel.text = [NSString stringWithFormat:@" %@,%@天,%@图  点图查看详情",self.travelNotes.start_date,self.travelNotes.total_days,self.travelNotes.photo_number];
        self.cover = self.travelNotes.cover;
        self.avatar = self.travelNotes.avatar;
        self.start_date = self.travelNotes.start_date;
        self.total_days = self.travelNotes.total_days;
        self.photo_number = self.travelNotes.photo_number;
        self.nickname = self.travelNotes.nickname;
    }
    
    [titleView addSubview:titleLabel];
    [titleView addSubview:dateLabel];
    [titleView addSubview:mainimageView];
    [titleView addSubview:coverLabel];
    [titleView addSubview:logo];
    //    [self.view addSubview:titleView];
    self.tableView.tableHeaderView = titleView;
    
}
-(void)loadDataAndeShow
{
    NSString *url = [NSString stringWithFormat:@"http://tubu.ibuzhai.com/rest/v2/travelog/%@?&api_version=1&app_version=3.9.4&device_type=2&travelog_id=%@",self.deatilID,self.deatilID];
    NSURL *urlstring = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlstring];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data != nil) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *dic2 = [dic objectForKey:@"log"];
            self.title = dic2[@"name"];
            self.name = self.title;
            NSArray *array1 = [dic2 objectForKey:@"posts"];
            for (NSDictionary *dic4 in array1) {
                
                NSArray *array2 = [dic4 objectForKey:@"pictures"];
                NSDictionary *dic5 = array2[0];
                
                TracelDeatil *travelDeatil = [TracelDeatil new];
                [travelDeatil setValuesForKeysWithDictionary:dic5 ];
                travelDeatil.travDescription = [dic4 objectForKey:@"description"];
                travelDeatil.travCreated_date = [dic4 objectForKey:@"day"];
                
                
                [self.dataSourceArray addObject:travelDeatil];
                
            }
            
            [self.tableView reloadData];
            [self.hud hide:YES];
            
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
    
    return self.dataSourceArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * str = @"cess";
    DeatilCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if (!cell) {
        cell = [[DeatilCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    TracelDeatil *tra = self.dataSourceArray[indexPath.row];
    cell.travelDeatil  = tra;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [DeatilCell cellHeight:self.dataSourceArray[indexPath.row]];
}

/*
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Photo *photoVC = [Photo new];
    photoVC.contentStr = indexPath.row;
    photoVC.travelArray = self.dataSourceArray;
    photoVC.title = self.title;
    photoVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:photoVC animated:YES completion:^{
        
    }];
}
 
 */

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
