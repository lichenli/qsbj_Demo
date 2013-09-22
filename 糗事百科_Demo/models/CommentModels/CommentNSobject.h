//
//  CommentNSobject.h
//
//  Created by   on 13-9-20
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CommentNSobject : NSObject <NSCoding>

@property (nonatomic, assign) double count;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, assign) double total;
@property (nonatomic, assign) double page;

+ (CommentNSobject *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
