//
//  CommentItems.m
//
//  Created by   on 13-9-20
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "CommentItems.h"
#import "CommentUser.h"


NSString *const kCommentItemsFloor = @"floor";
NSString *const kCommentItemsId = @"id";
NSString *const kCommentItemsContent = @"content";
NSString *const kCommentItemsUser = @"user";


@interface CommentItems ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CommentItems

@synthesize floor = _floor;
@synthesize itemsIdentifier = _itemsIdentifier;
@synthesize content = _content;
@synthesize user = _user;


+ (CommentItems *)modelObjectWithDictionary:(NSDictionary *)dict
{
    CommentItems *instance = [[CommentItems alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.floor = [[self objectOrNilForKey:kCommentItemsFloor fromDictionary:dict] doubleValue];
            self.itemsIdentifier = [self objectOrNilForKey:kCommentItemsId fromDictionary:dict];
            self.content = [self objectOrNilForKey:kCommentItemsContent fromDictionary:dict];
            self.user = [CommentUser modelObjectWithDictionary:[dict objectForKey:kCommentItemsUser]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.floor] forKey:kCommentItemsFloor];
    [mutableDict setValue:self.itemsIdentifier forKey:kCommentItemsId];
    [mutableDict setValue:self.content forKey:kCommentItemsContent];
    [mutableDict setValue:[self.user dictionaryRepresentation] forKey:kCommentItemsUser];

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

    self.floor = [aDecoder decodeDoubleForKey:kCommentItemsFloor];
    self.itemsIdentifier = [aDecoder decodeObjectForKey:kCommentItemsId];
    self.content = [aDecoder decodeObjectForKey:kCommentItemsContent];
    self.user = [aDecoder decodeObjectForKey:kCommentItemsUser];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_floor forKey:kCommentItemsFloor];
    [aCoder encodeObject:_itemsIdentifier forKey:kCommentItemsId];
    [aCoder encodeObject:_content forKey:kCommentItemsContent];
    [aCoder encodeObject:_user forKey:kCommentItemsUser];
}


@end
