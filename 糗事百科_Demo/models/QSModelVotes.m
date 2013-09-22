//
//  QSModelVotes.m
//
//  Created by   on 13-9-18
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "QSModelVotes.h"


NSString *const kQSModelVotesUp = @"up";
NSString *const kQSModelVotesDown = @"down";


@interface QSModelVotes ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation QSModelVotes

@synthesize up = _up;
@synthesize down = _down;


+ (QSModelVotes *)modelObjectWithDictionary:(NSDictionary *)dict
{
    QSModelVotes *instance = [[QSModelVotes alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.up = [[self objectOrNilForKey:kQSModelVotesUp fromDictionary:dict] doubleValue];
            self.down = [[self objectOrNilForKey:kQSModelVotesDown fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.up] forKey:kQSModelVotesUp];
    [mutableDict setValue:[NSNumber numberWithDouble:self.down] forKey:kQSModelVotesDown];

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

    self.up = [aDecoder decodeDoubleForKey:kQSModelVotesUp];
    self.down = [aDecoder decodeDoubleForKey:kQSModelVotesDown];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_up forKey:kQSModelVotesUp];
    [aCoder encodeDouble:_down forKey:kQSModelVotesDown];
}


@end
