//
//  NSArray+NSArray_Indexing.m
//  dragAndDropTest
//
//  Created by Mario Adrian on 31.07.12.
//  Copyright (c) 2012 Mario Adrian. All rights reserved.
//

// NSArray+Indexing.m
#import "NSArray+Indexing.h"
@implementation NSArray (Indexing)
- (id)objectAtIndexedSubscript:(NSUInteger)idx
{
    return [self objectAtIndex:idx];
}
@end
@implementation NSMutableArray (Indexing)
- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx
{
    [self replaceObjectAtIndex:idx withObject:obj];
}
@end

// NSMutableDictionary+Indexing.m
@implementation  NSDictionary (Indexing)

- (id)objectForKeyedSubscript:(id)key
{
    return [self objectForKey:key];
}
@end
@implementation  NSMutableDictionary (Indexing)
- (void)setObject:(id)obj forKeyedSubscript:(id)key
{
    [self setObject:obj forKey:key];
}
@end
