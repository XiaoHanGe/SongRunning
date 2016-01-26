//
//  TracelDeatil.m
//  WonderfulLife
//
//  Created by 韩俊强 on 15/7/11.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//

#import "TracelDeatil.h"

@implementation TracelDeatil



-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(NSString *)description
{

    return [NSString stringWithFormat:@"%@,%@,%@,%@",_picture,_travCreated_date,_height,_travDescription];
    
}


    
    



@end
