//
//  DataBaseHandle.h
//  ZYTD
//
//  Created by 韩俊强 on 15/11/9.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataBaseHandle : NSObject

+ (DataBaseHandle *)shareDataBaseHandle;

@property (nonatomic, retain) FMDatabase *fmdb;

#pragma mark 旅游页面
// 创建旅游表
- (void)creatJourTable;
// 插入旅游
- (void)insertJour : (JourNotes *)jour;
// 查找所有旅游
- (NSMutableArray *)selectAllJour;
// 删除某个旅游
- (void)deleteOneJourByJourNotesModel : (JourNotes *)jour;
// 删除所有旅游
- (void)deleteAllJour;

#pragma mark 新闻页面
//创建音乐表
- (void)creatMusicTable;
//插入音乐
- (void)insertNews : (SounModel *)news;
//查找全部音乐
- (NSMutableArray *)selectAllNews;
//删除某个音乐
- (void)deleteOneNewsByDataBaseModel : (SounModel *)news;
//删除所有的音乐
- (void)deleteAllNews;

#pragma mark 新闻阅读
//创建新闻阅读表
- (void)creatReadTable;
//插入阅读新闻
- (void)insertReadNews : (ReadDetailModel *)read;
//删除阅读新闻
- (void)deleteReadNews : (ReadDetailModel *)read;
//获得所有阅读新闻列表
- (NSMutableArray *)selectAllReadNews;
//删除所有阅读新闻
- (void)deleteAllReadNews;



@end
