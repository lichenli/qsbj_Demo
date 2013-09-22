//
//  QSModelUser.h
//
//  Created by   on 13-9-18
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface QSModelUser : NSObject <NSCoding>

@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *lastVisitedAt;
@property (nonatomic, strong) NSString *userIdentifier;
@property (nonatomic, strong) NSString *role;
@property (nonatomic, strong) NSString *createdAt;
@property (nonatomic, assign) id lastDevice;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *login;

+ (QSModelUser *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
