//
//  OTCompositeArray.h
//  CompositeArrayController
//
//  Created by iain on 24/08/2014.
//  Copyright (c) 2014 False Victories. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FVCompositeArray : NSObject

@property (readwrite, strong) NSArray *arrays;
@property (readwrite, strong) NSArray *headers;

// KVO mutable indexed ordered to-many methods
- (NSUInteger)countOfItems;
- (id)objectInItemsAtIndex:(NSUInteger)index;
- (void)insertObject:(id)object
      inItemsAtIndex:(NSUInteger)index;
- (void)removeObjectFromItemsAtIndex:(NSUInteger)index;

// Accessor functions
- (NSMutableArray *)arrayAtIndex:(NSUInteger)index
                    indexInArray:(NSUInteger *)indexInArray;
- (NSUInteger)compositeIndexForIndex:(NSUInteger)index
                             inArray:(NSMutableArray *)array;

@end
