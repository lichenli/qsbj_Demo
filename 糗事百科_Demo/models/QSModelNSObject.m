//
//  QSModelNSObject.m
//
//  Created by   on 13-9-18
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "QSModelNSObject.h"
#import "QSModelItems.h"


NSString *const kQSModelNSObjectCount = @"count";
NSString *const kQSModelNSObjectItems = @"items";
NSString *const kQSModelNSObjectTotal = @"total";
NSString *const kQSModelNSObjectPage = @"page";

@interface QSModelNSObject ()



- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation QSModelNSObject

@synthesize count = _count;
@synthesize items = _items;
@synthesize total = _total;
@synthesize page = _page;

#pragma mark - 单例
+(QSModelNSObject *)shareQSModel
{
    static QSModelNSObject * singlit = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singlit = [[QSModelNSObject alloc] init];
    });
    return singlit;
}


+ (QSModelNSObject *)modelObjectWithDictionary:(NSDictionary *)dict
{
    QSModelNSObject *instance = [[QSModelNSObject alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.count = [[self objectOrNilForKey:kQSModelNSObjectCount fromDictionary:dict] doubleValue];
    NSObject *receivedQSModelItems = [dict objectForKey:kQSModelNSObjectItems];
    NSMutableArray *parsedQSModelItems = [NSMutableArray array];
    if ([receivedQSModelItems isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedQSModelItems) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedQSModelItems addObject:[QSModelItems modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedQSModelItems isKindOfClass:[NSDictionary class]]) {
       [parsedQSModelItems addObject:[QSModelItems modelObjectWithDictionary:(NSDictionary *)receivedQSModelItems]];
    }

    self.items = [NSArray arrayWithArray:parsedQSModelItems];
            self.total = [[self objectOrNilForKey:kQSModelNSObjectTotal fromDictionary:dict] doubleValue];
            self.page = [[self objectOrNilForKey:kQSModelNSObjectPage fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.count] forKey:kQSModelNSObjectCount];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForItems] forKey:@"kQSModelNSObjectItems"];
    [mutableDict setValue:[NSNumber numberWithDouble:self.total] forKey:kQSModelNSObjectTotal];
    [mutableDict setValue:[NSNumber numberWithDouble:self.page] forKey:kQSModelNSObjectPage];

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

    self.count = [aDecoder decodeDoubleForKey:kQSModelNSObjectCount];
    self.items = [aDecoder decodeObjectForKey:kQSModelNSObjectItems];
    self.total = [aDecoder decodeDoubleForKey:kQSModelNSObjectTotal];
    self.page = [aDecoder decodeDoubleForKey:kQSModelNSObjectPage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_count forKey:kQSModelNSObjectCount];
    [aCoder encodeObject:_items forKey:kQSModelNSObjectItems];
    [aCoder encodeDouble:_total forKey:kQSModelNSObjectTotal];
    [aCoder encodeDouble:_page forKey:kQSModelNSObjectPage];
}


@end
