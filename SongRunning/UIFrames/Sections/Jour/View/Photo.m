//
//  Photo.m
//  SuperPhotoAlbum
//
//  Created by 韩俊强 on 15/6/13.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "Photo.h"

@interface Photo ()<UIActionSheetDelegate,UMSocialUIDelegate>

@property(nonatomic,retain)MBProgressHUD *hud;//创建辅助视图

@property (nonatomic , strong) UIPageControl *pageControl;

@property (nonatomic , strong) UIImageView *imgView;

@property (nonatomic ,strong) UITextView *conentTextView;

@end

@implementation Photo
-(void)viewDidLoad
{
    [super viewDidLoad ];
    self.view.backgroundColor = [UIColor blackColor];
    
   
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    [self addAllSubViews];
    
    [self addTitleView];
    
    //添加菊花效果
    [self addProgressHub];
    [self.hud hide:YES];
    
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
            //            [self collectionNews];
            break;
        case 1:
            //调用分享方法
            [self shareNews];
            break;
            
        default:
            break;
    }
    
    
}
/*
 //收藏方法的实现
 - (void)collectionNews{
 //定义一个flag用来判断是否收藏过
 NSMutableArray *arr = [[DataBaseHandle shareDataBaseHandle]selectAllReadNews];
 BOOL collect = NO;
 for (AmuseModel *model in arr) {
 if ([model.title isEqualToString:self.title]) {
 collect = YES;
 }
 }
 if (collect) {
 //已经收藏过了
 UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"你已经收藏过该新闻" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
 [alertView show];
 
 }else{
 AmuseModel *model = [[AmuseModel alloc]init];//记得释放
 model.docid = self.ids;
 model.title = self.title;
 [[DataBaseHandle shareDataBaseHandle]insertReadNews:model];
 UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"收藏成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
 [alertView show];
 [alertView dismissWithClickedButtonIndex:0 animated:YES];
 
 
 }
 
 
 }
 
 */
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




-(void)addTitleView
{
    UIView *titleView = [[UIView alloc ] initWithFrame:CGRectMake(0, 20, kScreenW, 40)];
    UIButton *blackbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    blackbutton.frame = CGRectMake(10, 5, 50, 40);
    [blackbutton setImage:[UIImage imageNamed:@"icon_back_highlighted@2x.png"] forState:UIControlStateNormal];
    [blackbutton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:blackbutton];
    
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(70 , 10, kScreenW - 70, 40)];
    titlelabel.numberOfLines = 0;
    titlelabel.adjustsFontSizeToFitWidth = YES;
    titlelabel.text = self.title;
    
 
//    titlelabel.textAlignment = NSTextAlignmentCenter;
//    titlelabel.backgroundColor = [UIColor blackColor];
    titlelabel.textColor = [UIColor whiteColor];
    
    UIImageView *heheimageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenW - 50, 5, 30, 30)];
    TracelDeatil *tra = self.travelArray[0];
    heheimageView.layer.cornerRadius = 15;
    heheimageView.layer.masksToBounds = YES;
    [heheimageView sd_setImageWithURL:[NSURL URLWithString:tra.avatar]];
    
    UILabel *heheLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(heheimageView.frame) - 100, 10, 100, 20)];
    heheLabel.textAlignment = NSTextAlignmentRight;

    heheLabel.textColor = [UIColor colorWithRed:0.9255 green:0.9255 blue:0.9255 alpha:1.0];
    heheLabel.font = [UIFont systemFontOfSize:13];
    heheLabel.text = tra.nickname;
    
    [titleView addSubview:titlelabel];
    [titleView addSubview:heheimageView];
    [titleView addSubview:heheLabel];
    
    [self.view addSubview:titleView];

}

-(void)buttonAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        //回调方法
    }];
}

-(NSMutableArray *)travelArray
{
    if (_travelArray == nil) {
        self.travelArray = [NSMutableArray array];
    }
    return _travelArray;
}

-(void)addAllSubViews
{
    NSMutableArray *picArray = [NSMutableArray array];
    NSMutableArray *connentArray = [NSMutableArray array];
    if (_travelArray.count != 0) {
        for (int i ; i < _travelArray.count; i ++) {
            TracelDeatil *tra = [TracelDeatil new];
            tra  = self.travelArray[i];
            [picArray addObject:tra.picture];
            [connentArray addObject:tra.travDescription];
        }
    }
    
    self.scrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, KSCREEN_WIDTH, KSCREEN_HEIGH - 20 )];
//    self.scrollView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.scrollView];
    
    
    for (int i = 0; i < picArray.count; i ++) {
        self.scrollView1 = [[UIScrollView alloc] initWithFrame:CGRectMake(self.scrollView.frame.size.width * i, -50 , self.scrollView.frame.size.width, self.scrollView.frame.size.height)] ;
        self.imgView =[UIImageView new];
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:picArray[i]]];
        [self.imgView setFrame:CGRectMake(0, 50, KSCREEN_WIDTH, KSCREEN_HEIGH/2)];
        self.imgView.contentMode = UIViewContentModeScaleAspectFit;
         self.imgView.center = [[UIApplication sharedApplication] keyWindow].center;
        [self.scrollView1 addSubview:self.imgView];
    
        
        self.conentTextView = [[UITextView alloc ] initWithFrame:CGRectMake(self.scrollView.frame.size.width * i +15, kScreenH -230, kScreenW - 30, 150)];
        self.conentTextView.backgroundColor = [UIColor colorWithRed:0.4863 green:0.4863 blue:0.4863 alpha:0];
        self.conentTextView.textColor = [UIColor whiteColor];
        self.conentTextView.text = connentArray[i];
        self.conentTextView.font = [UIFont systemFontOfSize:15];
        self.conentTextView.editable = NO;
        [self.scrollView addSubview:self.scrollView1];
        [self.scrollView addSubview:self.conentTextView];
    
        
        
        
        
        self.scrollView1.bounces = YES;
        self.scrollView1.scrollEnabled =YES;
        self.scrollView1.contentSize = CGSizeMake(self.scrollView1.frame.size.width , self.scrollView1.frame.size.height );
        
        self.scrollView1.minimumZoomScale = 1;
        
        self.scrollView1.maximumZoomScale = 3;
        self.scrollView1.delegate = self;
        self.imgView.contentMode =UIViewContentModeScaleAspectFit;
        
        
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenW / 7*6 + kScreenW * i,kScreenH/6*4 , kScreenW / 7 , 30)];
//        label.text = [NSString stringWithFormat:@"%d/%ld",i + 2,picArray.count];
//        label.textColor = [UIColor whiteColor];
//        label.textAlignment = NSTextAlignmentCenter;
//        [self.scrollView addSubview:label];
//        
        
        
    }
    

    
    
    
    
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width *(self.travelArray.count), self.scrollView.frame.size.height);
    self.scrollView.bounces = YES;
    
    self.scrollView.delegate =self;
    
    //设置页面标签
    self.pageControl= [[UIPageControl alloc] initWithFrame:CGRectMake(50, 550, 100, 40)];
    
    self.pageControl.backgroundColor = [UIColor clearColor];
    //设置页标的数量 （0~3）
    self.pageControl.numberOfPages = self.travelArray.count;
    
    //将页标的初始化为 从上个视图控制器中获得的值 （即在相册中点的是第几个图片 就把页标置为第几页）
    self.pageControl.currentPage = self.contentStr;
    //同时 ，也要将页面跳到与页标相同的地方
    CGPoint point = CGPointMake(self.pageControl.currentPage * self.scrollView1.frame.size.width, 0);
    [self.scrollView setContentOffset:point animated:YES];
    //设置导航栏的标题为第几页 因为页标默认从0开始 所以相应的要加1再显示
//    self.navigationItem.title = [NSString stringWithFormat:@"第%ld页",self.contentStr + 1];

    
    
    self.pageControl.tag = 201;
    
    //设置非选中的页标的颜色
    self.pageControl.pageIndicatorTintColor =[UIColor blueColor];
    
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    
    [self.pageControl addTarget:self action:@selector(go:) forControlEvents:UIControlEventValueChanged];
//    [self.view addSubview:self.pageControl];
    
    
    
    
    
}

//让页面随着页标滑动
-(void)go:(UIPageControl *)sender
{
    CGPoint point = CGPointMake(self.pageControl.currentPage * self.scrollView1.frame.size.width, 0);
    [self.scrollView setContentOffset:point animated:YES];
//    self.navigationItem.title = [NSString stringWithFormat:@"第%ld页",self.pageControl.currentPage +1];
}


//还原图片大小  即将开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //为了实现当返回上次已经缩小或放大的照片时，能让其还原成原大小
    //需要操作的是大滚动视图中的小滚动视图
    if (scrollView == self.scrollView)
    {
        //取到当前所在的页面，第几页
        int index = scrollView.contentOffset.x / scrollView.frame.size.width;
        
        //如果当前时第0页，说明只要让第一页的还原就行
        if (index == 0)
        {
            UIScrollView * scroll1 = [scrollView.subviews objectAtIndex:index + 1];
//            scroll1.zoomScale = 1.0;
        }else if (index == self.travelArray.count -1) //如果当前时第4页，说明只要让前一页的还原就行
            
        {
            UIScrollView * scroll2 = [scrollView.subviews objectAtIndex:index - 1];
            scroll2.zoomScale = 1.0;
        }else //如果是中间页，则让当前页的的前一页和后一页都还原
        {
            UIScrollView * scroll1 = [scrollView.subviews objectAtIndex:index + 1];
            scroll1.zoomScale = 1.0;
            UIScrollView * scroll2 = [scrollView.subviews objectAtIndex:index - 1];
            scroll2.zoomScale = 1.0;
        }
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    //因为是用大UIScrollView套小UIScrollView实现，所以判断是不是大的时才执行
    if (scrollView != self.scrollView)
    {
        //因为内层滚动视图中只放了一张UIImageView，所以用objectAtIndex:0 取到当前图像
        //为了让放大或缩小后都使中心不变，所以在此方法中（缩放结果代理方法），让图片的中心一直保持屏幕的中心
        UIImageView * imgView = [scrollView.subviews objectAtIndex:0];
        imgView.center = [[UIApplication sharedApplication] keyWindow].center;
    }
}


//让页标 随着页面滑动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    NSLog(@"lvhuan%@",NSStringFromCGPoint(scrollView.contentOffset));
    int half_x = scrollView.frame.size.width / 2;
    int page = (scrollView.contentOffset.x - half_x)/self.view.frame.size.width +1;
    self.pageControl.currentPage = page;
//    self.navigationItem.title = [NSString stringWithFormat:@"第%d页",page +1];
    
    
   
}
//图片缩放
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    
    
    return [[scrollView subviews] objectAtIndex:0];
}


-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
@end
