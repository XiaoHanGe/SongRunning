//
//  DataBaseHandle.m
//  ZYTD
//
//  Created by 韩俊强 on 15/11/9.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//

#import "DataBaseHandle.h"

@implementation DataBaseHandle

static DataBaseHandle *handle = nil;
+ (DataBaseHandle *)shareDataBaseHandle{
    @synchronized(self){
        if (!handle) {
            handle = [[DataBaseHandle alloc]init];

        }
    }
    return handle;
}


//创建文件路径
- (NSString *)creatFilePath{

    //创建一个Document下的文件夹用来储存收藏的相关信息
    NSFileManager *fileManger = [NSFileManager defaultManager];
    NSString *currentUsertPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    if (![fileManger fileExistsAtPath:currentUsertPath]) {
        BOOL isSuccess = [fileManger createDirectoryAtPath:currentUsertPath withIntermediateDirectories:YES attributes:nil error:nil];
        NSLog(@"%@",isSuccess ? @"1" : @"0");
        
    }else{
        
    }
    return currentUsertPath;
    
}


#pragma mark 旅游页面
// 创建旅游表
- (void)creatJourTable
{
    
    NSString *dbPatch = [[self creatFilePath]stringByAppendingPathComponent:@"jour.sqlite"];
    self.fmdb = [FMDatabase databaseWithPath:dbPatch];
    BOOL isOpen = [self.fmdb open];
    if (isOpen) {
        BOOL isCreat = [self.fmdb executeUpdate:@"create table if not exists Jour(number integer primary key autoincrement,ID text,name text,comment_count text,cover text,avatar text,nickname text,start_date text,photo_number text,fav_count text,total_days text,view_count text)"];
        
        NSLog(@"%@",isCreat ? @"JourTable创建成功":@"创建失败");
    }else{
        NSLog(@"打开失败");
    }

}
// 插入旅游
- (void)insertJour : (JourNotes *)jour
{
    BOOL isInsert = [self.fmdb executeUpdate:@"insert into Jour(ID,name,comment_count,cover,avatar,nickname,start_date,photo_number,fav_count,total_days,view_count)values(?,?,?,?,?,?,?,?,?,?,?)",jour.ID,jour.name,jour.comment_count,jour.cover,jour.avatar,jour.nickname,jour.start_date,jour.photo_number,jour.fav_count,jour.total_days,jour.view_count];
    
//    NSLog(@"%@",NSHomeDirectory());
    NSLog(@"%@",isInsert ? @"插入成功":@"插入失败");

}
// 查找所有旅游
- (NSMutableArray *)selectAllJour
{
    [self creatJourTable];
    FMResultSet *set = [self.fmdb executeQuery:@"select *from Jour"];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    while ([set next]) {
        JourNotes *model = [[JourNotes alloc]init];
        model.name = [set stringForColumn:@"name"];
        model.ID = [set stringForColumn:@"ID"];
        model.comment_count = [set stringForColumn:@"comment_count"];
        model.cover = [set stringForColumn:@"cover"];
        model.avatar = [set stringForColumn:@"avatar"];
        model.nickname = [set stringForColumn:@"nickname"];
        model.start_date = [set stringForColumn:@"start_date"];
        model.photo_number = [set stringForColumn:@"photo_number"];
        model.fav_count = [set stringForColumn:@"fav_count"];
        model.total_days = [set stringForColumn:@"total_days"];
        model.view_count = [set stringForColumn:@"view_count"];
        
        [array addObject:model];
        
    }
    return array;
}
// 删除某个旅游
- (void)deleteOneJourByJourNotesModel : (JourNotes *)jour
{
    BOOL isDelete = [self.fmdb executeUpdate:@"delete from Jour where name = ?",jour.name];
    NSLog(@"%@",isDelete ? @"删除成功":@"删除失败");
    

}
// 删除所有旅游
- (void)deleteAllJour
{
    BOOL isDelete = [self.fmdb executeUpdate:@"drop table Jour"];
    NSLog(@"%@",isDelete ? @"删除成功":@"删除失败");
}






#pragma mark 音乐页面

//创建音乐表
- (void)creatMusicTable{

    NSString *dbPatch = [[self creatFilePath]stringByAppendingPathComponent:@"news.sqlite"];
     self.fmdb = [FMDatabase databaseWithPath:dbPatch];
    BOOL isOpen = [self.fmdb open];
    if (isOpen) {
        BOOL isCreat = [self.fmdb executeUpdate:@"create table if not exists News(number integer primary key autoincrement,countId text,titles text,cover_url text)"];
        
        NSLog(@"%@",isCreat ? @"MusicTable创建成功":@"创建失败");
    }else{
        NSLog(@"打开失败");
    }
}

//插入音乐
- (void)insertNews : (SounModel *)news{
//    [self openDataBase];
    BOOL isInsert = [self.fmdb executeUpdate:@"insert into News(countId,titles,cover_url)values(?,?,?)",news.countId,news.titles,news.cover_url];

   
    NSLog(@"%@",isInsert ? @"插入成功":@"插入失败");
}
//查询所有收藏音乐
- (NSMutableArray *)selectAllNews{
    [self creatMusicTable];
    FMResultSet *set = [self.fmdb executeQuery:@"select *from News"];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    while ([set next]) {
        SounModel *model = [[SounModel alloc]init];
        model.titles = [set stringForColumn:@"titles"];
        model.countId = [set stringForColumn:@"countId"];
        model.cover_url = [set stringForColumn:@"cover_url"];
        [array addObject:model];

    }
    return array;
}

//删除音乐
- (void)deleteOneNewsByDataBaseModel : (SounModel *)news{
    BOOL isDelete = [self.fmdb executeUpdate:@"delete from News where titles = ?",news.titles];
    NSLog(@"%@",isDelete ? @"删除成功":@"删除失败");
    
}
//删除所有音乐
- (void)deleteAllNews{
    BOOL isDelete = [self.fmdb executeUpdate:@"drop table News"];
    NSLog(@"%@",isDelete ? @"删除成功":@"删除失败");
    
}



#pragma mark 新闻阅读
//创建新闻阅读表
- (void)creatReadTable{
    NSString *dbPath = [[self creatFilePath]stringByAppendingPathComponent:@"read.sqlite"];
    self.fmdb = [FMDatabase databaseWithPath:dbPath];
    BOOL isOpen = [self.fmdb open];
    if (isOpen) {
        BOOL isCreat = [self.fmdb executeUpdate:@"create table if not exists Read(number integer primary key autoincrement,aId text,title text)"];
        NSLog(@"%@",isCreat ? @"ReanTable创建成功":@"创建失败");
    }else{
        NSLog(@"打开失败");
    }
}

//插入阅读新闻
- (void)insertReadNews : (ReadDetailModel *)read{
    [self creatReadTable];
    BOOL isInsert = [self.fmdb executeUpdate:@"insert into Read(aId,title)values(?,?)",read.aId,read.title];
//    NSLog(@"%@",NSHomeDirectory());
    NSLog(@"%@",isInsert ? @"插入成功":@"插入失败");
}

//删除阅读新闻
- (void)deleteReadNews : (ReadDetailModel *)read{
    BOOL isDelete = [self.fmdb executeUpdate:@"delete from Read where title = ?",read.title];
    NSLog(@"%@",isDelete ? @"删除成功":@"删除失败");
    
}

//获得所有阅读新闻列表
- (NSMutableArray *)selectAllReadNews{
    [self creatReadTable];
    FMResultSet *set = [self.fmdb executeQuery:@"select *from Read"];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    while ([set next]) {
        ReadDetailModel *model = [[ReadDetailModel alloc]init];
        model.title = [set stringForColumn:@"title"];
        model.aId = [set stringForColumn:@"aId"];
        [array addObject:model];
  
    }
    return array;
}

//删除所有阅读新闻
- (void)deleteAllReadNews{
    BOOL isDelete = [self.fmdb executeUpdate:@"drop table Read"];
    NSLog(@"%@",isDelete ? @"删除成功":@"删除阅读失败");
    
    
}


@end
