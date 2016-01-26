//
//  ReadDetailModel.m
//  Everyday
//
//  Created by lz on 15/10/12.
//  Copyright (c) 2015年 lz. All rights reserved.
//

#import "ReadDetailModel.h"

@implementation ReadDetailModel

- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.aId = value;
    }
}

- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

@end
