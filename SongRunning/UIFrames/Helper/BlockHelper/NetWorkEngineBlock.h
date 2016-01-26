//
//  NetWorkEngineBlock.h
//  SongRunning
//
//  Created by 韩俊强 on 15/12/3.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^successfulBlock)(NSDictionary *dic);
typedef BOOL (^failBlock)(NSError *error);

@interface NetWorkEngineBlock : NSObject

- (id)initWithSuccessfulBlock:(successfulBlock)aSuucessBlock failBlock:(failBlock)aFailBlock;

- (void)get:(NSString *)urlStr;

- (void)post:(NSString *)urlStr params:(NSString *)paramsStr;

@end
