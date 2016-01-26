//
//  MusicPlayViewController.m
//  SoulSounds
//
//  Created by 韩俊强 on 15-10-12.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//

#import "MusicPlayViewController.h"

@interface MusicPlayViewController ()<UITableViewDataSource , UITableViewDelegate , AVAudioPlayerDelegate,UMSocialUIDelegate,UIActionSheetDelegate>

// 收藏按钮
@property (weak, nonatomic) IBOutlet UIButton *collectionButton;
// 旋转图片
@property (weak, nonatomic) IBOutlet UIImageView *routeImageView;
// 音乐列表
@property (weak, nonatomic) IBOutlet UITableView *musicList;
// 播放方式
@property (weak, nonatomic) IBOutlet UIButton *playWay;
// 播放按钮
@property (weak, nonatomic) IBOutlet UIButton *playButton;
// 播放时间
@property (weak, nonatomic) IBOutlet UILabel *currentLabel;
// 播放进度
@property (weak, nonatomic) IBOutlet UISlider *currentSlider;
// 总时间
@property (weak, nonatomic) IBOutlet UILabel *totleTimeLabel;
// 声音
@property (weak, nonatomic) IBOutlet UIButton *volueButton;
@property (weak, nonatomic) IBOutlet UISlider *volueSlider;
@property (weak, nonatomic) IBOutlet UIImageView *volueImageView;
// 播放背景图片
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@property (nonatomic , strong) NSMutableArray *dataArray;
@property (nonatomic , strong) BlockHelper *blockHelper;
//播放状态
@property (nonatomic , assign) BOOL isPlay;
//定时器
@property (nonatomic , strong) NSTimer *sliderTimer;
//播放器列表数组
@property (nonatomic , strong) NSMutableArray *playItemArray;
//保存当前播放的音乐位置
@property (nonatomic , assign) NSInteger n;
@property (nonatomic , assign) BOOL isMute;
//保存静音前的音量
@property (nonatomic , assign) CGFloat volue;
@property (nonatomic , strong) UIImageView *imag2Views;
 //保存当前播放方式
@property (nonatomic , assign) NSInteger m;
//保存上个播放方式
@property (nonatomic , assign) NSInteger x;
//数据库对象

 //存放查询对象
@property (nonatomic , strong) NSArray *resultArray;
//是否被收藏
@property (nonatomic , assign) BOOL isCollection;
//动画对象
@property (nonatomic , strong) CABasicAnimation *monkeAnimatin;

@property (nonatomic, strong) NSMutableArray *imagesArray;//雪花

@property(nonatomic,retain)MBProgressHUD *hud;//创建辅助视图

@end

@implementation MusicPlayViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 给id赋值
    SounModel *model = [[SounModel alloc]init];
    model.countId = self.musicId;
  
    
    // 雪花
    [self addSnow];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"test3"]];
    
    
    self.sliderTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeValueSlider) userInfo:nil repeats:YES];
    [self.currentSlider setThumbImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    self.volueSlider.transform = CGAffineTransformMakeRotation(-1.57079633);
    
    [self setImageWithNorme:@"playMusic" andHeightImage:@"pause"];
    [self getdataFromServer:self.musicId];
    
    // 隐藏时间显示label
    self.totleTimeLabel.hidden = YES;
    self.currentLabel.hidden = YES;
    
    self.imag2Views = [[UIImageView alloc] init];
    [self.view addSubview:self.imag2Views];
//    self.volueImageView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"2"]];
//    self.imag2Views.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"2"]];
//    
    // 设置最大音量
    self.volueSlider.maximumValue = 1.0;
    // 最小音量
    self.volueSlider.minimumValue = 0.0;
    // 初始化音量大小
    self.volueSlider.value = 0.4;
    
    [self.volueSlider setMaximumTrackImage:[UIImage imageNamed:@"clearBack"] forState:UIControlStateNormal];
    [self.volueSlider setMinimumTrackImage:[UIImage imageNamed:@"clearBack"] forState:UIControlStateNormal];
    [self.volueSlider addTarget:self action:@selector(volueChange) forControlEvents:UIControlEventValueChanged];
    
    // 设置圆角
    [self setRouteImageView];
    // 加载动画但不执行
    [self.routeImageView.layer addAnimation:self.monkeAnimatin forKey:@"monkeyAnimation"];
    [self.routeImageView startAnimating];
    
    // 设置转动图像的大小和圆滑度
    self.routeImageView.layer.cornerRadius = self.routeImageView.frame.size.height / 2;
    self.routeImageView.layer.masksToBounds = YES;
    
    //添加菊花效果
    [self addProgressHub];
  
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
            [self collectionNews];
            break;
        case 1:
            //调用分享方法
            [self shareMusic];
            break;
            
        default:
            break;
    }
    
    
}

//分享的实现
- (void)shareMusic{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:APPKEY
                                      shareText: @"爱音乐,爱旅游.欢迎使用SongRunning应用,我们以最好的视听体验展现给您!"
                                     shareImage: [UIImage imageNamed:@"sharing"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToLine,UMShareToDouban,nil]
                                       delegate:self];
    
}


 //收藏方法的实现
 - (void)collectionNews{
     //定义一个flag用来判断是否收藏过
     NSMutableArray *arr = [[DataBaseHandle shareDataBaseHandle]selectAllNews];
     BOOL collect = NO;
     for (SounModel *model in arr) {
     if ([model.titles isEqualToString:self.titles]) {
     collect = YES;
   
     }
}
     if (collect) {
     //已经收藏过了
     UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"亲,您已经收藏过了!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
     [alertView show];

     }else{
     SounModel *model = [[SounModel alloc]init];
     model.countId = self.musicId;
     model.titles = self.titles;
  
     [[DataBaseHandle shareDataBaseHandle]insertNews:model];

     UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"收藏成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
     [alertView show];
     [alertView dismissWithClickedButtonIndex:0 animated:YES];
     
     
     }
     
 
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




// 懒加载
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        self.dataArray = [@[] mutableCopy];
    }
    return _dataArray;
}

- (NSMutableArray *)playItemArray
{
    if (!_playItemArray) {
        self.playItemArray = [@[] mutableCopy];
    }
    return _playItemArray;
}

-(CABasicAnimation *)monkeAnimatin
{
    if (!_monkeAnimatin) {
        self.monkeAnimatin = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        self.monkeAnimatin.toValue = [NSNumber numberWithFloat:2.0 * M_PI];
        self.monkeAnimatin.duration = 10;
        self.monkeAnimatin.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        self.monkeAnimatin.cumulative = NO;
        self.monkeAnimatin.removedOnCompletion = NO;
        self.monkeAnimatin.repeatCount = FLT_MAX;
    }
    return _monkeAnimatin;
}

- (void)setRouteImageView
{
    self.routeImageView.layer.cornerRadius = self.routeImageView.frame.size.height / 2;
    self.routeImageView.layer.masksToBounds = YES;
    self.routeImageView.userInteractionEnabled = YES;
}

// 服务器交互
- (void)getdataFromServer:(NSString *)musicId
{
    
    
    NSString *urlString = [NSString stringWithFormat:@"http://www.duole.fm/api/collect/get_sound_list?collect_id=%@&visitor_uid=0&sort=2&page=1&limit=30&device=iphone" , musicId];
    self.blockHelper = [[BlockHelper alloc] init];
    __block MusicPlayViewController *blockSelf = self;
    [self.blockHelper blockHelperBeginRequestWithUrlString:urlString success:^(NSData *data) {
        [blockSelf parseDataWithData:data];
    } fail:^(NSError *error) {
        
    }];
}

// 数据解析
- (void)parseDataWithData:(NSData *)data
{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *dictArray = dic[@"data"];
    for (NSDictionary *dict in dictArray) {
        SounModel *model = [SounModel new];
        model.mp3Url = dict[@"sound_url"];
        model.cover_url = dict[@"cover_url"];
        model.titles = dict[@"title"];
        self.titles = model.titles;
        [self.dataArray addObject:model];
    }
    [self.musicList reloadData];
    [self createMusicPlayer];
    [self.hud hide:YES];
    
}

// 创建播放器
- (void)createMusicPlayer
{
    SounModel *model = self.dataArray[self.n];
    
    self.navigationItem.title = model.titles;
    AVPlayerItem *playItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:model.mp3Url]];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_url]];
    [self.routeImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_url]];
    self.routeImageView.layer.cornerRadius = 20;
    self.routeImageView.layer.masksToBounds = YES;
    [[WgPalyer sharedPlayer].player replaceCurrentItemWithPlayerItem:playItem];
    [[WgPalyer sharedPlayer].player play];
    self.isPlay = YES;
}

// 设置image2的frame
- (void)setFrame
{
    self.imag2Views.frame = CGRectMake(CGRectGetMinX(self.volueSlider.frame), CGRectGetMinY(self.volueSlider.frame), self.volueSlider.frame.size.width * self.volueSlider.value, CGRectGetHeight(self.volueSlider.frame));
}


// 下载
- (IBAction)downLoadAction:(UIButton *)sender
{
    SounModel *model = self.dataArray[self.n];
    [self cacheFilePathWithUrlString:model.mp3Url andWithFileName:model.titles];
}

// 下载方法
- (void)cacheFilePathWithUrlString:(NSString *)urlStr andWithFileName:(NSString *)fileName
{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *downLoadPath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp3" , fileName]];
    
    NSFileManager *manage = [NSFileManager defaultManager];
    if (![manage fileExistsAtPath:downLoadPath]) {
        [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:downLoadPath append:YES]];
        [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
            if (totalBytesRead / totalBytesExpectedToRead == 1.0) {
              

            }
        }];
        [operation start];
    }
}

// 给播放暂停按钮添加图片
- (void)setImageWithNorme:(NSString *)normalImage andHeightImage:(NSString *)heightImage
{
    [self.playButton setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [self.playButton setImage:[UIImage imageNamed:heightImage] forState:UIControlStateHighlighted];
}

// 上一首
- (IBAction)preSongButtonAction:(UIButton *)sender
{
    [self playWay:self.x andDoSomething:0];
}

// 下一首
- (IBAction)nextSongButtonAction:(UIButton *)sender
{
    [self playWay:self.x andDoSomething:1];
}

// 播放次序
- (void)playWay:(NSInteger)way andDoSomething:(NSInteger)something
{
    if (something == 0) {
        if (way == 0 || way == 1) {
            if (self.n == 0) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"已经是第一首了" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
            } else {
                --self.n;
                SounModel *model = self.dataArray[self.n];
               
                [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_url]];
                AVPlayerItem *playItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:model.mp3Url]];
                [[WgPalyer sharedPlayer].player replaceCurrentItemWithPlayerItem:playItem];
                self.navigationItem.title = model.titles;
            }
        }
    } else if (something == 1) {
        if (way == 0 || way == 1) {
            if (self.n + 1 == self.dataArray.count) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"已经是最后一首了" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
            } else {
                ++self.n;
                SounModel *model = self.dataArray[self.n];
              
                [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_url]];
                AVPlayerItem *playItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:model.mp3Url]];
                [[WgPalyer sharedPlayer].player replaceCurrentItemWithPlayerItem:playItem];
                self.navigationItem.title = model.titles;
            }
        }
    }
    if (way == 2) {
        SounModel *model = self.dataArray[self.n];
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_url]];
        AVPlayerItem *playItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:model.mp3Url]];
        [[WgPalyer sharedPlayer].player replaceCurrentItemWithPlayerItem:playItem];
        self.navigationItem.title = model.titles;
    }
    if (way == 3) {
        self.n = arc4random() % self.dataArray.count;
        SounModel *model = self.dataArray[self.n];
       
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_url]];
        AVPlayerItem *playItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:model.mp3Url]];
        [[WgPalyer sharedPlayer].player replaceCurrentItemWithPlayerItem:playItem];
        self.navigationItem.title = model.titles;
    }
}

// 暂停播放
- (IBAction)playButtonAction:(UIButton *)sender
{
    [self setFrame];
    self.isPlay = !self.isPlay;
    if (self.isPlay) {
        [[WgPalyer sharedPlayer].player play];
        [self setImageWithNorme:@"playMusic" andHeightImage:@"pause"];
        [self stopAnimation];
    } else {
        [[WgPalyer sharedPlayer].player pause];
        [self setImageWithNorme:@"pause" andHeightImage:@"playMusic"];
        [self startAnimation];
    }
}

// 开始动画
- (void)startAnimation
{
    CFTimeInterval pausedTime = [self.routeImageView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.routeImageView.layer.speed = 0.0;
    self.routeImageView.layer.timeOffset = pausedTime;
}

// 停止动画
- (void)stopAnimation
{
    self.routeImageView.layer.speed = 1.0;
    self.routeImageView.layer.beginTime = 0.0;
    CFTimeInterval pausedTime = [self.routeImageView.layer timeOffset];
    CFTimeInterval timeSincePause = [self.routeImageView.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.routeImageView.layer.beginTime = timeSincePause;
}

// 播放进度条变动
- (void)changeValueSlider
{
    if (self.isPlay) {
        CMTime totalTime = [[WgPalyer sharedPlayer].player currentTime];
        CGFloat time1 = (CGFloat)totalTime.value / totalTime.timescale;
        
        CMTime totalTime2 = [[WgPalyer sharedPlayer].player.currentItem duration];
        
        // 音乐总时长
        if (totalTime2.value != 0) {
            int totalDur = (int)((CGFloat)(totalTime2.value / totalTime2.timescale));
            self.totleTimeLabel.hidden = NO;
            self.totleTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d" , totalDur / 60 , totalDur % 60];
            
            CGFloat currentPlayTime = (CGFloat)totalTime.value / totalTime.timescale;
            if (currentPlayTime >= 0) {
                self.currentLabel.hidden = NO;
                int test = (int)currentPlayTime;
                self.currentLabel.text = [NSString stringWithFormat:@"%02d:%02d" , test / 60 , test % 60];
            }
            // 是否在播完后播放下一首
            if (totalDur - currentPlayTime <= 2) {
                if ((self.x == 0 || self.x == 1) && self.n + 1 < self.dataArray.count) {
                    ++self.n;
                }
                if (self.x == 3) {
                    self.n = arc4random() % self.dataArray.count;
                }
                SounModel *model = self.dataArray[self.n];
                self.navigationItem.title = model.titles;
                AVPlayerItem *playItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:model.mp3Url]];
                [[WgPalyer sharedPlayer].player replaceCurrentItemWithPlayerItem:playItem];
            }
            CGFloat time2 = (CGFloat)totalTime2.value / totalTime2.timescale;
            self.currentSlider.value = time1 / time2;
        }
    }
}

// 静音
- (IBAction)volueButtonAction:(UIButton *)sender
{
    self.isMute = !self.isMute;
    if (self.isMute) {
        [self.volueButton setImage:[UIImage imageNamed:@"静音"] forState:UIControlStateNormal];
        self.volue = self.volueSlider.value;
        self.volueSlider.value = 0.0f;
        [WgPalyer sharedPlayer].player.volume = 0.0f;
    } else {
        [self.volueButton setImage:[UIImage imageNamed:@"声音"] forState:UIControlStateNormal];
        self.volueSlider.value = self.volue;
        [WgPalyer sharedPlayer].player.volume = self.volueSlider.value;
    }
    [self setFrame];
}

// 音量调节
- (void)volueChange
{
    [self setFrame];
    [WgPalyer sharedPlayer].player.volume = self.volueSlider.value;
    if (self.volueSlider.value == 0) {
        self.isMute = !self.isMute;
        [self.volueButton setImage:[UIImage imageNamed:@"静音"] forState:UIControlStateNormal];
    } else {
        [self.volueButton setImage:[UIImage imageNamed:@"声音"] forState:UIControlStateNormal];
    }
}

// 播放方式
- (IBAction)playWay:(id)sender
{
    if (self.m == 0) {
        self.m += 2;
    }
    switch (self.m) {
        case 1:
            [MBProgressHUD showSuccess:@"顺序播放" toView:self.view];
            [self.playWay setImage:[UIImage imageNamed:@"顺序播放"] forState:UIControlStateNormal];
            self.x = self.m;
            self.m++;
            break;
        case 2:
            [MBProgressHUD showSuccess:@"单曲循环" toView:self.view];
            self.x = self.m;
            self.m++;
            [self.playWay setImage:[UIImage imageNamed:@"单曲循环"] forState:UIControlStateNormal];
            break;
        case 3:
            [MBProgressHUD showSuccess:@"随机播放" toView:self.view];
            [self.playWay setImage:[UIImage imageNamed:@"随机播放"] forState:UIControlStateNormal];
            self.x = self.m;
            self.m = 1;
            break;
            
        default:
            break;
    }
}


// 播放列表
- (IBAction)playListAction:(UIButton *)sender
{
    if (self.musicList.alpha == 0.0) {
        [UIView animateWithDuration:1.0 animations:^{
            self.musicList.alpha = 1.0;
        }];
        self.imag2Views.alpha = 0.0;
    } else {
        [UIView animateWithDuration:1.0 animations:^{
            self.musicList.alpha = 0.0;
        }];
        self.imag2Views.alpha = 1.0;
    }
}

//// 收藏
//- (IBAction)CollectionButtonAction:(UIButton *)sender
//{
////    SounModel *model = self.dataArray[self.n];
//    if (self.isCollection) {
//        self.isCollection = NO;
//
//        [sender setImage:[UIImage imageNamed:@"noCollection"] forState:UIControlStateNormal];
//    } else {
//        self.isCollection = YES;
//  
//        [sender setImage:[UIImage imageNamed:@"collection"] forState:UIControlStateNormal];
//    }
//}

#pragma mark - table代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    SounModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.titles;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.n = indexPath.row;
    [UIView animateWithDuration:1.0 animations:^{
        self.musicList.alpha = 0.0;
    }];
    [self createMusicPlayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



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
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(makeSnow) userInfo:nil repeats:YES];
    
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
