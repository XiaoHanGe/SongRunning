//
//  MineViewCell.m
//  ZYTD
//
//  Created by 韩俊强 on 15/11/8.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//

#import "MineViewCell.h"

@implementation MineViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.dataArray = [NSMutableArray array];
        
        for (int i = 0; i < 3; i++) {
            MineModel *model = [[MineModel alloc]init];
            
            [self.dataArray addObject:model];
        }
        
        [self addAllViews];

    }
    return self;
}

- (void)addAllViews{
    
    self.aLabel = [[UILabel alloc]initWithFrame:CGRectMake(45, 0, kScreenW, 44)];
    
    self.contentView.backgroundColor = kMineCellColor;
    [self.contentView addSubview:self.aLabel];
    
    self.photoImage = [[UIImageView alloc]initWithFrame:CGRectMake(10,7 , kMinePhotoW, kMinePhotoW)];
    
    //    self.photoImage.backgroundColor = [UIColor redColor];
    self.photoImage.layer.cornerRadius = kMinePhotoCornerRadius;
    self.photoImage.layer.masksToBounds = YES;
    [self.contentView addSubview:self.photoImage];
    
    self.cachLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenW - 90, 10, 80, 30)];
    self.cachLabel.textColor = [UIColor grayColor];
    //    self.cachLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.cachLabel];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, kScreenW, 0) style:(UITableViewStylePlain)];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"testCell"];
    
    CGRect frame = self.tableView.frame;
    frame.size.height = 44 * self.dataArray.count;
    self.tableView.frame = frame;
    
    
}
- (void)showTableView{
    [self.contentView addSubview:self.tableView];
}

- (void)hiddenTableView{
    [self.tableView removeFromSuperview];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"testCell" forIndexPath:indexPath];
    
    MineModel *model = [[MineModel alloc]init];
    model = self.dataArray[indexPath.row];
    switch (indexPath.row) {
        case 0:
            
            cell.textLabel.text = @"我的音乐";
            break;
        case 1:
            
            cell.textLabel.text = @"我的旅游";
            break;
            case 2:
            
            cell.textLabel.text = @"我的阅读";
            break;
            default:
            break;
    }
 
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    // 阅读板块收藏
    ReadTableViewController *readVC = [[ReadTableViewController alloc]initWithStyle:(UITableViewStylePlain)];
    UINavigationController *readNC = [[UINavigationController alloc]initWithRootViewController:readVC];

   
    readNC.title = @"音乐收藏";
    
    // 音乐板块收藏
    MusicTableViewController *musicVC = [[MusicTableViewController alloc]initWithStyle:(UITableViewStylePlain)];
    UINavigationController *musicNC = [[UINavigationController alloc]initWithRootViewController:musicVC];
 
    readNC.title = @"阅读收藏";
    
    // 旅游板块收藏
    JourTableViewController *jourVC = [[JourTableViewController alloc]initWithStyle:(UITableViewStylePlain)];
    UINavigationController *jourNC = [[UINavigationController alloc]initWithRootViewController:jourVC];

    jourNC.title = @"旅游收藏";
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    switch (indexPath.row) {
        case 0:
            
            [delegate.window.rootViewController presentViewController:musicNC animated:YES completion:nil];
            
             break;
            case 1:
            
            [delegate.window.rootViewController presentViewController:jourNC animated:YES completion:nil];
            
             break;
            case 2:
            
            [delegate.window.rootViewController presentViewController:readNC animated:YES completion:nil];
            
            break;
        default:
            break;
}
    

}


- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
