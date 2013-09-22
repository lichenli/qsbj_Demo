//
//  QSModelVotes.h
//
//  Created by   on 13-9-18
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface QSModelVotes : NSObject <NSCoding>

@property (nonatomic, assign) double up;
@property (nonatomic, assign) double down;

+ (QSModelVotes *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
