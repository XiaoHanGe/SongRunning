//
//  BlockHelper.h
//  音乐搜索接口
//
//  Created by 韩俊强 on 15/11/28.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^SuccessBlock)(NSData *data);
typedef void(^FailBlock)(NSError *error);

@interface BlockHelper : NSObject

- (void)blockHelperBeginRequestWithUrlString : (NSString *)urlString success : (SuccessBlock)success fail : (FailBlock)fail;

@end
