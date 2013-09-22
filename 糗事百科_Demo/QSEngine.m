//
//  QSEngine.m
//  糗事百科_Demo
//
//  Created by lichen on 13-9-18.
//  Copyright (c) 2013年 Lichen. All rights reserved.
//

#import "QSEngine.h"

@implementation QSEngine


+(QSEngine *)shareEngine
{
    static QSEngine * singlit = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singlit = [[QSEngine alloc] init];
    });
    return singlit;
}

#pragma mark - add by lichen
- (MKNetworkOperation*) requestWithURL:(NSString *)url
                                params:(NSMutableDictionary *)params
                            httpMethod:(NSString *)httpMethod
                                 blcok:(CurrencyResponseBlock)blocks
                          errorHandler:(MKNKErrorBlock) error
{
    
    if (params == nil)
    {
        params = [NSMutableDictionary dictionary];
    }
    
    MKNetworkOperation * request = [self operationWithPath:url
                                                    params:params
                                                httpMethod:httpMethod];


    [request addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        if (blocks) {
            blocks (completedOperation);
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        error = error;
    }];
    
    [self enqueueOperation:request];
    return  request;
}

@end
