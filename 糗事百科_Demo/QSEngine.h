//
//  QSEngine.h
//  糗事百科_Demo
//
//  Created by lichen on 13-9-18.
//  Copyright (c) 2013年 Lichen. All rights reserved.
//

#import "MKNetworkEngine.h"

@interface QSEngine : MKNetworkEngine

typedef void (^CurrencyResponseBlock)(MKNetworkOperation * operation);

- (MKNetworkOperation *) requestWithURL:(NSString *)url
                                params:(NSMutableDictionary *)params
                            httpMethod:(NSString *)httpMethod
                                 blcok:(CurrencyResponseBlock)blocks
                          errorHandler:(MKNKErrorBlock) error;


+(QSEngine *)shareEngine;


@end
