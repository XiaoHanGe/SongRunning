//
//  BlockHelper.m
//  音乐搜索接口
//
//  Created by 韩俊强 on 15/11/28.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//

#import "BlockHelper.h"

@interface BlockHelper ()

@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) NSMutableData *data;

// 当定义block类型的属性时, 要用copy修饰
@property (nonatomic, copy) SuccessBlock successBlock;
@property (nonatomic, copy) FailBlock failBlock;

@end

@implementation BlockHelper

- (NSMutableData *)data
{
    if (!_data) {
        self.data = [NSMutableData data];
    }
    return _data;
}


- (void)blockHelperBeginRequestWithUrlString : (NSString *)urlString success : (SuccessBlock)success fail : (FailBlock)fail
{
    // 属性保存用户信息(外界)传入的block
    self.successBlock = success;
    self.failBlock = fail;
    NSString *urlEncodeStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlEncodeStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    __block BlockHelper *blockSelf = self;
    
  [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
      [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:YES];
      if (data != nil) {
          blockSelf.successBlock(data);
          [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];

      }else{
          
          blockSelf.failBlock(connectionError);
          [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
          
      }

  }];
 
}

- (void)dealloc
{
    self.connection = nil;
    self.data = nil;
    self.successBlock = nil;
    self.failBlock = nil;
}


@end
