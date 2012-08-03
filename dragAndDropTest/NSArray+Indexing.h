//
//  NSArray+NSArray_Indexing.h
//  dragAndDropTest
//
//  Created by Mario Adrian on 31.07.12.
//  Copyright (c) 2012 Mario Adrian. All rights reserved.
//

#import <Foundation/Foundation.h>

// NSArray+Indexing.h
@interface NSArray (Indexing)
- (id)objectAtIndexedSubscript:(NSUInteger)idx;
@end
@interface NSMutableArray (Indexing)
- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx;
@end
// NSDictionary+Indexing.h
@interface  NSDictionary (Indexing)
- (id)objectForKeyedSubscript:(id)key;
@end
@interface  NSMutableDictionary (Indexing)
- (void)setObject:(id)obj forKeyedSubscript:(id)key;
@end
