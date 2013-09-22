//
//  CommentNSobject.m
//
//  Created by   on 13-9-20
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "CommentNSobject.h"
#import "CommentItems.h"


NSString *const kCommentNSobjectCount = @"count";
NSString *const kCommentNSobjectItems = @"items";
NSString *const kCommentNSobjectTotal = @"total";
NSString *const kCommentNSobjectPage = @"page";


@interface CommentNSobject ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CommentNSobject

@synthesize count = _count;
@synthesize items = _items;
@synthesize total = _total;
@synthesize page = _page;


+ (CommentNSobject *)modelObjectWithDictionary:(NSDictionary *)dict
{
    CommentNSobject *instance = [[CommentNSobject alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.count = [[self objectOrNilForKey:kCommentNSobjectCount fromDictionary:dict] doubleValue];
    NSObject *receivedCommentItems = [dict objectForKey:kCommentNSobjectItems];
    NSMutableArray *parsedCommentItems = [NSMutableArray array];
    if ([receivedCommentItems isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedCommentItems) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedCommentItems addObject:[CommentItems modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedCommentItems isKindOfClass:[NSDictionary class]]) {
       [parsedCommentItems addObject:[CommentItems modelObjectWithDictionary:(NSDictionary *)receivedCommentItems]];
    }

    self.items = [NSArray arrayWithArray:parsedCommentItems];
            self.total = [[self objectOrNilForKey:kCommentNSobjectTotal fromDictionary:dict] doubleValue];
            self.page = [[self objectOrNilForKey:kCommentNSobjectPage fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.count] forKey:kCommentNSobjectCount];
NSMutableArray *tempArrayForItems = [NSMutableArray array];
    for (NSObject *subArrayObject in self.items) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForItems addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForItems addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForItems] forKey:@"kCommentNSobjectItems"];
    [mutableDict setValue:[NSNumber numberWithDouble:self.total] forKey:kCommentNSobjectTotal];
    [mutableDict setValue:[NSNumber numberWithDouble:self.page] forKey:kCommentNSobjectPage];

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

    self.count = [aDecoder decodeDoubleForKey:kCommentNSobjectCount];
    self.items = [aDecoder decodeObjectForKey:kCommentNSobjectItems];
    self.total = [aDecoder decodeDoubleForKey:kCommentNSobjectTotal];
    self.page = [aDecoder decodeDoubleForKey:kCommentNSobjectPage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_count forKey:kCommentNSobjectCount];
    [aCoder encodeObject:_items forKey:kCommentNSobjectItems];
    [aCoder encodeDouble:_total forKey:kCommentNSobjectTotal];
    [aCoder encodeDouble:_page forKey:kCommentNSobjectPage];
}


@end
