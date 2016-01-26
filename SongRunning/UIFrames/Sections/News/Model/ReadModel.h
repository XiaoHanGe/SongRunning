//
//  ReadModel.h
//  Everyday
//
//  Created by lz on 15/10/12.
//  Copyright (c) 2015年 lz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString *enname;
@property (nonatomic, copy) NSString *coverimg;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
