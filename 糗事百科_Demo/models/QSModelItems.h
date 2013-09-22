//
//  QSModelItems.h
//
//  Created by   on 13-9-18
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QSModelVotes;
@class QSModelUser;

@interface QSModelItems : NSObject <NSCoding>

@property (nonatomic, assign) id user;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *itemsIdentifier;
@property (nonatomic, assign) double publishedAt;
@property (nonatomic, strong) QSModelVotes *votes;
@property (nonatomic, strong) QSModelUser *users;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *tag;
@property (nonatomic, assign) double createdAt;
@property (nonatomic, assign) double commentsCount;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, assign) BOOL allowComment;

+ (QSModelItems *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
