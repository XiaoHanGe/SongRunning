//
//  ReadModel.m
//  Everyday
//
//  Created by lz on 15/10/12.
//  Copyright (c) 2015年 lz. All rights reserved.
//

#import "ReadModel.h"

@implementation ReadModel

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
    
}

- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

@end
