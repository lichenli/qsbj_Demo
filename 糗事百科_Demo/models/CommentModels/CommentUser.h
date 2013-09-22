//
//  CommentUser.h
//
//  Created by   on 13-9-20
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentUser : NSObject <NSCoding>

@property (nonatomic, assign) double lastVisitedAt;
@property (nonatomic, strong) NSString *login;
@property (nonatomic, strong) NSString *userIdentifier;
@property (nonatomic, strong) NSString *role;
@property (nonatomic, assign) double createdAt;
@property (nonatomic, strong) NSString *lastDevice;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *state;

+ (CommentUser *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
