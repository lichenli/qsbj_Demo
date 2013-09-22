//
//  QSModelItems.m
//
//  Created by   on 13-9-18
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "QSModelItems.h"
#import "QSModelVotes.h"
#import "QSModelItems.h"


NSString *const kQSModelItemsUser = @"user";
NSString *const kQSModelItemsContent = @"content";
NSString *const kQSModelItemsId = @"id";
NSString *const kQSModelItemsPublishedAt = @"published_at";
NSString *const kQSModelItemsVotes = @"votes";
NSString *const kQSModelItemsUsers = @"user";
NSString *const kQSModelItemsImage = @"image";
NSString *const kQSModelItemsTag = @"tag";
NSString *const kQSModelItemsCreatedAt = @"created_at";
NSString *const kQSModelItemsCommentsCount = @"comments_count";
NSString *const kQSModelItemsState = @"state";
NSString *const kQSModelItemsAllowComment = @"allow_comment";


@interface QSModelItems ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation QSModelItems

@synthesize user = _user;
@synthesize content = _content;
@synthesize itemsIdentifier = _itemsIdentifier;
@synthesize publishedAt = _publishedAt;
@synthesize votes = _votes;
@synthesize users = _users;
@synthesize image = _image;
@synthesize tag = _tag;
@synthesize createdAt = _createdAt;
@synthesize commentsCount = _commentsCount;
@synthesize state = _state;
@synthesize allowComment = _allowComment;


+ (QSModelItems *)modelObjectWithDictionary:(NSDictionary *)dict
{
    QSModelItems *instance = [[QSModelItems alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.user = [self objectOrNilForKey:kQSModelItemsUser fromDictionary:dict];
            self.content = [self objectOrNilForKey:kQSModelItemsContent fromDictionary:dict];
            self.itemsIdentifier = [self objectOrNilForKey:kQSModelItemsId fromDictionary:dict];
            self.publishedAt = [[self objectOrNilForKey:kQSModelItemsPublishedAt fromDictionary:dict] doubleValue];
            self.votes = [QSModelVotes modelObjectWithDictionary:[dict objectForKey:kQSModelItemsVotes]];
            self.users = [QSModelUser modelObjectWithDictionary:[dict objectForKey:kQSModelItemsUsers]];
            self.image = [self objectOrNilForKey:kQSModelItemsImage fromDictionary:dict];
            self.tag = [self objectOrNilForKey:kQSModelItemsTag fromDictionary:dict];
            self.createdAt = [[self objectOrNilForKey:kQSModelItemsCreatedAt fromDictionary:dict] doubleValue];
            self.commentsCount = [[self objectOrNilForKey:kQSModelItemsCommentsCount fromDictionary:dict] doubleValue];
            self.state = [self objectOrNilForKey:kQSModelItemsState fromDictionary:dict];
            self.allowComment = [[self objectOrNilForKey:kQSModelItemsAllowComment fromDictionary:dict] boolValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.user forKey:kQSModelItemsUser];
    [mutableDict setValue:self.content forKey:kQSModelItemsContent];
    [mutableDict setValue:self.itemsIdentifier forKey:kQSModelItemsId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.publishedAt] forKey:kQSModelItemsPublishedAt];
    [mutableDict setValue:[self.votes dictionaryRepresentation] forKey:kQSModelItemsVotes];
    [mutableDict setValue:[self.users dictionaryRepresentation] forKey:kQSModelItemsUsers];
    [mutableDict setValue:self.image forKey:kQSModelItemsImage];
    [mutableDict setValue:self.tag forKey:kQSModelItemsTag];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createdAt] forKey:kQSModelItemsCreatedAt];
    [mutableDict setValue:[NSNumber numberWithDouble:self.commentsCount] forKey:kQSModelItemsCommentsCount];
    [mutableDict setValue:self.state forKey:kQSModelItemsState];
    [mutableDict setValue:[NSNumber numberWithBool:self.allowComment] forKey:kQSModelItemsAllowComment];

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

    self.user = [aDecoder decodeObjectForKey:kQSModelItemsUser];
    self.content = [aDecoder decodeObjectForKey:kQSModelItemsContent];
    self.itemsIdentifier = [aDecoder decodeObjectForKey:kQSModelItemsId];
    self.publishedAt = [aDecoder decodeDoubleForKey:kQSModelItemsPublishedAt];
    self.votes = [aDecoder decodeObjectForKey:kQSModelItemsVotes];
    self.users = [aDecoder decodeObjectForKey:kQSModelItemsUsers];
    self.image = [aDecoder decodeObjectForKey:kQSModelItemsImage];
    self.tag = [aDecoder decodeObjectForKey:kQSModelItemsTag];
    self.createdAt = [aDecoder decodeDoubleForKey:kQSModelItemsCreatedAt];
    self.commentsCount = [aDecoder decodeDoubleForKey:kQSModelItemsCommentsCount];
    self.state = [aDecoder decodeObjectForKey:kQSModelItemsState];
    self.allowComment = [aDecoder decodeBoolForKey:kQSModelItemsAllowComment];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_user forKey:kQSModelItemsUser];
    [aCoder encodeObject:_content forKey:kQSModelItemsContent];
    [aCoder encodeObject:_itemsIdentifier forKey:kQSModelItemsId];
    [aCoder encodeDouble:_publishedAt forKey:kQSModelItemsPublishedAt];
    [aCoder encodeObject:_votes forKey:kQSModelItemsVotes];
    [aCoder encodeObject:_users forKey:kQSModelItemsUsers];
    [aCoder encodeObject:_image forKey:kQSModelItemsImage];
    [aCoder encodeObject:_tag forKey:kQSModelItemsTag];
    [aCoder encodeDouble:_createdAt forKey:kQSModelItemsCreatedAt];
    [aCoder encodeDouble:_commentsCount forKey:kQSModelItemsCommentsCount];
    [aCoder encodeObject:_state forKey:kQSModelItemsState];
    [aCoder encodeBool:_allowComment forKey:kQSModelItemsAllowComment];
}


@end
