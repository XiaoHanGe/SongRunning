//
//  ReadTableViewController.m
//  SongRunning
//
//  Created by 韩俊强 on 15/12/7.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//

#import "ReadTableViewController.h"

@interface ReadTableViewController ()

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ReadTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [@[]mutableCopy];

    // 注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kMineCell];
    
  self.dataArray =  [[DataBaseHandle shareDataBaseHandle]selectAllReadNews];
    
    //消除多余单元格
    self.tableView.tableFooterView = [[UITableView alloc]init];
 
    //调用左返回Item
    [self addLelfBackItem];
    
    self.navigationController.navigationBar.barTintColor = WEIBOColor(255, 145, 181);

}


//添加左右返回Item
- (void)addLelfBackItem{
    //左返回
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:(UIBarButtonItemStylePlain) target:self action:@selector(handleBack :)];
    self.navigationItem.leftBarButtonItem = leftItem;
    //右清空收藏
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"清空" style:(UIBarButtonItemStylePlain) target:self action:@selector(handleClear :)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
//返回的实现
- (void)handleBack : (UIBarButtonItem *)back{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//清空收藏
- (void)handleClear : (UIBarButtonItem *)clear{
    
    [[DataBaseHandle shareDataBaseHandle]deleteAllReadNews];
    //移除本页面数据
    [self.tableView removeFromSuperview];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    

    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMineCell forIndexPath:indexPath];
    ReadDetailModel *model = self.dataArray[indexPath.row];
   
    cell.textLabel.text = model.title;

    
    return cell;
}

// 点击cell会走的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MaterialViewController *materialVC = [[MaterialViewController alloc] init];
    ReadDetailModel *model = self.dataArray[indexPath.row];;
    materialVC.aId = model.aId;
    materialVC.title = model.title;
    [self.navigationController pushViewController:materialVC animated:YES];
}

// 是否可以编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// 滑动删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ReadDetailModel *model = self.dataArray[indexPath.row];
        
        [[DataBaseHandle shareDataBaseHandle]deleteReadNews:model];
        
        [self.dataArray removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
    }
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
