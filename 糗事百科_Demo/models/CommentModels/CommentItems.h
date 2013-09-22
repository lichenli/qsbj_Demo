//
//  CommentItems.h
//
//  Created by   on 13-9-20
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentUser.h"
@class CommentUser;

@interface CommentItems : NSObject <NSCoding>

@property (nonatomic, assign) double floor;
@property (nonatomic, strong) NSString *itemsIdentifier;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) CommentUser * user;

+ (CommentItems *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
