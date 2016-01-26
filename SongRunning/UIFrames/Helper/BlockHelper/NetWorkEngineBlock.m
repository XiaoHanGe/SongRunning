//
//  NetWorkEngineBlock.m
//  SongRunning
//
//  Created by 韩俊强 on 15/12/3.
//  Copyright (c) 2015年 韩俊强. All rights reserved.
//

#import "NetWorkEngineBlock.h"

@interface NetWorkEngineBlock ()

@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, copy) successfulBlock successFulBlock;
@property (nonatomic, copy) failBlock failBlock;

@end

@implementation NetWorkEngineBlock

- (id)initWithSuccessfulBlock:(successfulBlock)aSuucessBlock failBlock:(failBlock)aFailBlock{
    self = [super init];
    if (self) {
        self.successFulBlock = aSuucessBlock;
        self.failBlock = aFailBlock;
    }
    return self;
}

- (void)get:(NSString *)urlStr{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)post:(NSString *)urlStr params:(NSString *)paramsStr{
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSData *paramsData = [paramsStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:paramsData];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    self.data = [NSMutableData dataWithCapacity:1];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:self.data options:0 error:nil];
    self.successFulBlock(dic);

}





- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    BOOL result = self.failBlock(error);
    if (result) {
        
    }else{
        
    }
}


@end
