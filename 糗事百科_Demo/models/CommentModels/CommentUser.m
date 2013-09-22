//
//  CommentUser.m
//
//  Created by   on 13-9-20
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "CommentUser.h"


NSString *const kCommentUserLastVisitedAt = @"last_visited_at";
NSString *const kCommentUserLogin = @"login";
NSString *const kCommentUserId = @"id";
NSString *const kCommentUserRole = @"role";
NSString *const kCommentUserCreatedAt = @"created_at";
NSString *const kCommentUserLastDevice = @"last_device";
NSString *const kCommentUserIcon = @"icon";
NSString *const kCommentUserState = @"state";


@interface CommentUser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CommentUser

@synthesize lastVisitedAt = _lastVisitedAt;
@synthesize login = _login;
@synthesize userIdentifier = _userIdentifier;
@synthesize role = _role;
@synthesize createdAt = _createdAt;
@synthesize lastDevice = _lastDevice;
@synthesize icon = _icon;
@synthesize state = _state;


+ (CommentUser *)modelObjectWithDictionary:(NSDictionary *)dict
{
    CommentUser *instance = [[CommentUser alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.lastVisitedAt = [[self objectOrNilForKey:kCommentUserLastVisitedAt fromDictionary:dict] doubleValue];
            self.login = [self objectOrNilForKey:kCommentUserLogin fromDictionary:dict];
            self.userIdentifier = [self objectOrNilForKey:kCommentUserId fromDictionary:dict];
            self.role = [self objectOrNilForKey:kCommentUserRole fromDictionary:dict];
            self.createdAt = [[self objectOrNilForKey:kCommentUserCreatedAt fromDictionary:dict] doubleValue];
            self.lastDevice = [self objectOrNilForKey:kCommentUserLastDevice fromDictionary:dict];
            self.icon = [self objectOrNilForKey:kCommentUserIcon fromDictionary:dict];
            self.state = [self objectOrNilForKey:kCommentUserState fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lastVisitedAt] forKey:kCommentUserLastVisitedAt];
    [mutableDict setValue:self.login forKey:kCommentUserLogin];
    [mutableDict setValue:self.userIdentifier forKey:kCommentUserId];
    [mutableDict setValue:self.role forKey:kCommentUserRole];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createdAt] forKey:kCommentUserCreatedAt];
    [mutableDict setValue:self.lastDevice forKey:kCommentUserLastDevice];
    [mutableDict setValue:self.icon forKey:kCommentUserIcon];
    [mutableDict setValue:self.state forKey:kCommentUserState];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.lastVisitedAt = [aDecoder decodeDoubleForKey:kCommentUserLastVisitedAt];
    self.login = [aDecoder decodeObjectForKey:kCommentUserLogin];
    self.userIdentifier = [aDecoder decodeObjectForKey:kCommentUserId];
    self.role = [aDecoder decodeObjectForKey:kCommentUserRole];
    self.createdAt = [aDecoder decodeDoubleForKey:kCommentUserCreatedAt];
    self.lastDevice = [aDecoder decodeObjectForKey:kCommentUserLastDevice];
    self.icon = [aDecoder decodeObjectForKey:kCommentUserIcon];
    self.state = [aDecoder decodeObjectForKey:kCommentUserState];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_lastVisitedAt forKey:kCommentUserLastVisitedAt];
    [aCoder encodeObject:_login forKey:kCommentUserLogin];
    [aCoder encodeObject:_userIdentifier forKey:kCommentUserId];
    [aCoder encodeObject:_role forKey:kCommentUserRole];
    [aCoder encodeDouble:_createdAt forKey:kCommentUserCreatedAt];
    [aCoder encodeObject:_lastDevice forKey:kCommentUserLastDevice];
    [aCoder encodeObject:_icon forKey:kCommentUserIcon];
    [aCoder encodeObject:_state forKey:kCommentUserState];
}


@end
