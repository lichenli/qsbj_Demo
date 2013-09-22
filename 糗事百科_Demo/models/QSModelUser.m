//
//  QSModelUser.m
//
//  Created by   on 13-9-18
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "QSModelUser.h"


NSString *const kQSModelUserIcon = @"icon";
NSString *const kQSModelUserLastVisitedAt = @"last_visited_at";
NSString *const kQSModelUserId = @"id";
NSString *const kQSModelUserRole = @"role";
NSString *const kQSModelUserCreatedAt = @"created_at";
NSString *const kQSModelUserLastDevice = @"last_device";
NSString *const kQSModelUserState = @"state";
NSString *const kQSModelUserLogin = @"login";


@interface QSModelUser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation QSModelUser

@synthesize icon = _icon;
@synthesize lastVisitedAt = _lastVisitedAt;
@synthesize userIdentifier = _userIdentifier;
@synthesize role = _role;
@synthesize createdAt = _createdAt;
@synthesize lastDevice = _lastDevice;
@synthesize state = _state;
@synthesize login = _login;


+ (QSModelUser *)modelObjectWithDictionary:(NSDictionary *)dict
{
    QSModelUser *instance = [[QSModelUser alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.icon = [self objectOrNilForKey:kQSModelUserIcon fromDictionary:dict];
            self.lastVisitedAt = [self objectOrNilForKey:kQSModelUserLastVisitedAt fromDictionary:dict];
            self.userIdentifier = [self objectOrNilForKey:kQSModelUserId fromDictionary:dict];
            self.role = [self objectOrNilForKey:kQSModelUserRole fromDictionary:dict];
            self.createdAt = [self objectOrNilForKey:kQSModelUserCreatedAt fromDictionary:dict];
            self.lastDevice = [self objectOrNilForKey:kQSModelUserLastDevice fromDictionary:dict];
            self.state = [self objectOrNilForKey:kQSModelUserState fromDictionary:dict];
            self.login = [self objectOrNilForKey:kQSModelUserLogin fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.icon forKey:kQSModelUserIcon];
    [mutableDict setValue:self.lastVisitedAt forKey:kQSModelUserLastVisitedAt];
    [mutableDict setValue:self.userIdentifier forKey:kQSModelUserId];
    [mutableDict setValue:self.role forKey:kQSModelUserRole];
    [mutableDict setValue:self.createdAt forKey:kQSModelUserCreatedAt];
    [mutableDict setValue:self.lastDevice forKey:kQSModelUserLastDevice];
    [mutableDict setValue:self.state forKey:kQSModelUserState];
    [mutableDict setValue:self.login forKey:kQSModelUserLogin];

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

    self.icon = [aDecoder decodeObjectForKey:kQSModelUserIcon];
    self.lastVisitedAt = [aDecoder decodeObjectForKey:kQSModelUserLastVisitedAt];
    self.userIdentifier = [aDecoder decodeObjectForKey:kQSModelUserId];
    self.role = [aDecoder decodeObjectForKey:kQSModelUserRole];
    self.createdAt = [aDecoder decodeObjectForKey:kQSModelUserCreatedAt];
    self.lastDevice = [aDecoder decodeObjectForKey:kQSModelUserLastDevice];
    self.state = [aDecoder decodeObjectForKey:kQSModelUserState];
    self.login = [aDecoder decodeObjectForKey:kQSModelUserLogin];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_icon forKey:kQSModelUserIcon];
    [aCoder encodeObject:_lastVisitedAt forKey:kQSModelUserLastVisitedAt];
    [aCoder encodeObject:_userIdentifier forKey:kQSModelUserId];
    [aCoder encodeObject:_role forKey:kQSModelUserRole];
    [aCoder encodeObject:_createdAt forKey:kQSModelUserCreatedAt];
    [aCoder encodeObject:_lastDevice forKey:kQSModelUserLastDevice];
    [aCoder encodeObject:_state forKey:kQSModelUserState];
    [aCoder encodeObject:_login forKey:kQSModelUserLogin];
}


@end
