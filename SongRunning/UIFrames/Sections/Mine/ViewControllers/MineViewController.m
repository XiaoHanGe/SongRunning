//
//  MineViewController.m
//  NeteaseNews
//
//  Created by 韩俊强 on 15/10/25.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()<UMSocialUIDelegate,MPMediaPickerControllerDelegate,UIActionSheetDelegate>

@property (nonatomic,retain)UIView *headerView;

@property (nonatomic, strong) NSMutableArray *imagesArray;//雪花

@property (nonatomic,retain)UIImageView *image;

@property (nonatomic,retain)NSMutableArray *dataSourceArray;

@property(nonatomic,retain)UIAlertView *alter;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 雪花
    [self addSnow];
    self.tableView.autoresizesSubviews = NO;
    
    
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"type_bg"]];
    
    self.tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    self.image = [[UIImageView alloc]initWithFrame:CGRectMake(- 264, 0, kScreenW, 264)];
    
    self.image.image = [UIImage imageNamed:@"Mineback"];
    [self.view addSubview:self.image];
    
    //注册
    [self.tableView registerClass:[MineViewCell class] forCellReuseIdentifier:kMineCell];
    
    self.dataSourceArray = [NSMutableArray array];
    
    for (int i = 0; i < 7; i++) {
        MineModel *model = [[MineModel alloc]init];
        model.isShow = NO;
        [self.dataSourceArray addObject:model];
    }
    
    self.tableView.tableFooterView = [[UIView alloc]init];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSourceArray.count;
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMineCell forIndexPath:indexPath];
    
    MineModel *model = [[MineModel alloc]init];
    cell.cachLabel.hidden = YES;
    [cell hiddenTableView];
    model = self.dataSourceArray[indexPath.row];
    switch (indexPath.row) {
        case 0:
        {
            if (model.isShow) {
                cell.aLabel.text = @"我的最爱";
                [cell showTableView];
            }else{
                cell.aLabel.text = @"我的收藏";
                [cell hiddenTableView];
            }
            cell.photoImage.image = [UIImage imageNamed:@"collect"];
        }
            break;
            case 1:
        {
            [cell hiddenTableView];
            cell.aLabel.text = @"本地音乐";
            cell.photoImage.image = [UIImage imageNamed:@"resizeApi-1.php.png"];
        }
            break;
        case 2:
        {
            [cell hiddenTableView];
            cell.cachLabel.hidden = NO;
            cell.aLabel.text = @"清除缓存";
            cell.photoImage.image = [UIImage imageNamed:@"clear"];
            cell.cachLabel.text = [NSString stringWithFormat:@"%.2f M",[ self filePath ]];
        }
            break;
        case 3:
        {
            [cell hiddenTableView];
            cell.aLabel.text = @"关于作者";
            cell.photoImage.image = [UIImage imageNamed:@"aboutUSs"];
        }
            break;
        case 4:
        {
            [cell hiddenTableView];
            cell.aLabel.text = @"责任声明";
            cell.photoImage.image = [UIImage imageNamed:@"zeren@2x"];
        }
            break;
            case 5:
        {
            [cell hiddenTableView];
            cell.aLabel.text = @"今日天气";
            cell.photoImage.image = [UIImage imageNamed:@"Weather@2x"];
        }
            break;
            case 6:
        {
            [cell hiddenTableView];
            cell.aLabel.text = @"分享应用";
            cell.photoImage.image = [UIImage imageNamed:@"shear@2x"];
        }
            break;
//            case 7:
//        {
//            cell.textLabel.text = @"夜间模式";
//            UISwitch *swicth = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 60, 5, 40, 20)];
//            
//            [swicth addTarget:self action:@selector(swicthAction:) forControlEvents:UIControlEventValueChanged];
//            
//            [cell.contentView addSubview:swicth];
//    }
//            break;
    
          default:
            break;
    }
    return cell;
}

#pragma mark switch 的关联事件
- (void)handleSwitch: (UISwitch *)aswitch{
    //首先应该或许开关控件当前的状态
    switch ((int)aswitch.on) {
        case YES:
            self.tableView.window.alpha = 0.5;
            break;
        case NO:
            self.tableView.window.alpha = 1.0;
            break;
        default:
            break;
    }
}

//返回高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MineModel *model = [[MineModel alloc]init];
    
    model = self.dataSourceArray[indexPath.row];
    
    if (model.isShow && indexPath.row == 0) {
        
        MineViewCell *cell = [[MineViewCell alloc]init];
        
        return (cell.dataArray.count + 1) * 44;
    }else {
        
        return 44;
    }
    
}
//点击cell会走的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MineModel *model = [[MineModel alloc]init];
    
    model = self.dataSourceArray[indexPath.row];
    model.isShow = !model.isShow;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationAutomatic)];
    
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
 
// 事件
    if (indexPath.row == 0) {
 
        
    }else if(indexPath.row == 1){
      
        [self playLocalMusic];
        
    }else if (indexPath.row == 2){
       
        [self beginClearFile];
        
    }else if (indexPath.row == 3){
        
        OursViewController *ourVC = [[OursViewController alloc]init];
        ourVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ourVC animated:YES];
        

    }else if (indexPath.row == 4){
        
        FreeViewController *freeVC = [[FreeViewController alloc]init];
        freeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:freeVC animated:YES];
        
    }else if (indexPath.row == 5){
        
        WeatherController *webVC = [[WeatherController alloc]init];
        webVC.hidesBottomBarWhenPushed = YES;
        webVC.urlString = @"http://weather1.sina.cn/?&vt=4";
        UINavigationController *weaNC = [[UINavigationController alloc]initWithRootViewController:webVC];
        [self presentViewController:weaNC animated:YES completion:nil];
        
    }else if (indexPath.row == 6){
        
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:APPKEY
                                          shareText: @"爱音乐,爱旅游.欢迎使用SongRunning应用,我们以最好的视听体验展现给您!"
                                         shareImage: [UIImage imageNamed:@"sharing"]
                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToLine,UMShareToDouban,nil]
                                           delegate:self];
    }

}

#pragma mark - 获取本地音乐
- (void)playLocalMusic
{
    MPMediaPickerController *meduaPC = [[MPMediaPickerController alloc]initWithMediaTypes:(MPMediaTypeMovie)];
[meduaPC.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg"] forBarMetrics:UIBarMetricsDefault];
    
    if (meduaPC != nil) {
        NSLog(@"Successfully instantiated a media picker");
        
        // 遵循代理
        meduaPC.delegate = self;
        // 提示文字
        meduaPC.prompt = @"请选择要播放的音乐";
        // 是否允许一次选择多个
        meduaPC.allowsPickingMultipleItems = YES;
        
        [self presentViewController:meduaPC animated:YES completion:nil];
        
    }else{
        NSLog(@"Could not instantiate a media picker");
    }
    
}

// 通过代理方法来获取选中的歌曲
// MPMediaItemCollection  多媒体项集合
// MPMediaItem 单个多媒体项，如一首歌曲
// collection是一组有序的item集合
- (void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection
{
    NSLog(@"%@",mediaItemCollection);
    
    /**
         MPMusicPlayerController类可以播放音乐库中的音乐
         MPMusicPlayerController提供两种播放器类型，一种是applicationMusicPlayer，一种是iPodMusicPlayer，这里用iPodMusicPlayer。前者在应用退出后音乐播放会自动停止，后者在应用停止后不会退出播放状态。
     */
    
    MPMusicPlayerController *musicPC = [[MPMusicPlayerController alloc]init];
    
    /**
     *  MPMusicPlayerController加载音乐不同于前面的AVAudioPlayer,AVAudioPlayer是通过一个文件路径来加载,而MPMusicPlayerController需要一个播放队列,正是由于它的播放音频来源是一个队列，因此MPMusicPlayerController支持上一曲、下一曲等操作。
     *
     */
    [musicPC setQueueWithItemCollection:mediaItemCollection];
    [musicPC play];
}

/**
 *  选择后取消动作
 *
 */
- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker
{
    NSLog(@"Media Picker was cancelled");
    [mediaPicker dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - 清理缓存


- (long long) fileSizeAtPath:( NSString *) filePath{
    NSFileManager * manager = [ NSFileManager defaultManager ];
    if ([manager fileExistsAtPath :filePath]){
        return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize ];
    }
    return 0 ;
}
//遍历文件夹获得文件夹大小，返回多少 M（提示：你可以在工程界设置（ m）
- (float)folderSizeAtPath:(NSString *)folderPath{
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator ];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject ]) != nil ){
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
    }
    return folderSize/( 1024.0 * 1024.0 );
}
//显示缓存大小
- (float)filePath{
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
    return [self folderSizeAtPath :cachPath];
}
//清理缓存

- (void)beginClearFile{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否清除缓存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self clearFile];
    }
}

- (void)clearFile{
    
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    NSArray * files = [[ NSFileManager defaultManager ] subpathsAtPath :cachPath];
    for ( NSString * p in files) {
        NSError * error = nil ;
        NSString * path = [cachPath stringByAppendingPathComponent :p];
        if ([[ NSFileManager defaultManager ] fileExistsAtPath :path]) {
            [[ NSFileManager defaultManager ] removeItemAtPath :path error :&error];
        }
    }
    [self performSelectorOnMainThread : @selector (clearCachSuccess) withObject : nil waitUntilDone : YES ];
}
- (void)clearCachSuccess{
    [SVProgressHUD showSuccessWithStatus:@"清除成功"];
    [self.tableView reloadData];
}




- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y <= -264) {
        self.image.frame = CGRectMake((scrollView.contentOffset.y/264+1)*kScreenW/2, scrollView.contentOffset.y, -scrollView.contentOffset.y/264*kScreenW, -scrollView.contentOffset.y);
    }
    self.navigationController.navigationBar.alpha = (scrollView.contentOffset.y+334)/100.0;
}
/*
#pragma mark - 夜间模式
- (void)swicthAction:(UISwitch *)sender
{
    if ([sender isOn]) {
        UIWindow *window = ((AppDelegate *)[UIApplication sharedApplication].delegate).window;
        window.alpha = 0.5;
    }else {
        UIWindow *window = ((AppDelegate *)[UIApplication sharedApplication].delegate).window;
        window.alpha = 1.0;
    }
}

*/

// ==================================================================
// 雪花效果

- (void)addSnow
{
    _imagesArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 20; ++ i) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:IMAGENAMED(SNOW_IMAGENAME)];
        float x = IMAGE_WIDTH;
        imageView.frame = CGRectMake(kIMAGE_X, -30, x, x);
        imageView.alpha = IMAGE_ALPHA;
        [self.view addSubview:imageView];
        [_imagesArray addObject:imageView];
    }
    [NSTimer scheduledTimerWithTimeInterval:.3 target:self selector:@selector(makeSnow) userInfo:nil repeats:YES];

}

static int i = 0;
- (void)makeSnow
{
    i = i + 1;
    if ([_imagesArray count] > 0) {
        UIImageView *imageView = [_imagesArray objectAtIndex:0];
        imageView.tag = i;
        [_imagesArray removeObjectAtIndex:0];
        [self snowFall:imageView];
    }
}

- (void)snowFall:(UIImageView *)aImageView
{
    [UIView beginAnimations:[NSString stringWithFormat:@"%ld",(long)aImageView.tag] context:nil];
    [UIView setAnimationDuration:6];
    [UIView setAnimationDelegate:self];
    aImageView.frame = CGRectMake(aImageView.frame.origin.x, kScreenH, aImageView.frame.size.width, aImageView.frame.size.height);
    [UIView commitAnimations];
}


- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    UIImageView *imageView = (UIImageView *)[self.view viewWithTag:[animationID intValue]];
    float x = IMAGE_WIDTH;
    imageView.frame = CGRectMake(kIMAGE_X, -30, x, x);
    [_imagesArray addObject:imageView];
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
