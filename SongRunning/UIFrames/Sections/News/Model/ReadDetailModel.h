//
//  ReadDetailModel.h
//  Everyday
//
//  Created by lz on 15/10/12.
//  Copyright (c) 2015年 lz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadDetailModel : NSObject

@property (nonatomic, copy) NSString *coverimg;
@property (nonatomic, copy) NSString *aId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
