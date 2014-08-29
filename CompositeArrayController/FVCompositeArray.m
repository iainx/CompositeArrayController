//
//  OTCompositeArray.m
//  CompositeArrayController
//
//  Created by iain on 24/08/2014.
//  Copyright (c) 2014 False Victories. All rights reserved.
//

#import "FVCompositeArray.h"

@implementation FVCompositeArray

- (NSUInteger)countOfItems
{
    NSUInteger totalCount = self.arrays.count;
    for (NSArray *array in self.arrays) {
        totalCount += array.count;
    }
    
    return totalCount;
}

- (NSMutableArray *)arrayAtIndex:(NSUInteger)index
                    indexInArray:(NSUInteger *)indexInArray
{
    NSUInteger arrayIdx = 0;
    NSMutableArray *currentArray = self.arrays[arrayIdx];
    
    // If the index is 0 then we're in a header.
    if (index == 0) {
        *indexInArray = 0;
        return nil;
    }
    
    // Offset the first header
    index -= 1;
    
    // Find the array that the index is in.
    while (index >= currentArray.count) {
        // Offset to the next array
        index -= (currentArray.count);
        
        arrayIdx += 1;
        
        // Again, if index is 0, then it's a header.
        if (index == 0) {
            *indexInArray = arrayIdx;
            return nil;
        }
        
        // Offset the header
        index -= 1;
        
        // Update the current array
        currentArray = self.arrays[arrayIdx];
        if (arrayIdx + 1 >= self.arrays.count) {
            break;
        }
    }

    *indexInArray = index;
    return currentArray;
}

- (NSUInteger)compositeIndexForIndex:(NSUInteger)index
                             inArray:(NSMutableArray *)array
{
    NSUInteger compositeIndex = 0;
    NSUInteger arrayIndex = 0;
    NSArray *currentArray = self.arrays[arrayIndex++];
    
    while (currentArray != array) {
        compositeIndex += (1 + currentArray.count);
        
        currentArray = self.arrays[arrayIndex++];
    }
    
    compositeIndex += (1 + index);
    return compositeIndex;
}

- (id)objectInItemsAtIndex:(NSUInteger)index
{
    NSUInteger indexInArray;
    NSMutableArray *currentArray;
    
    currentArray = [self arrayAtIndex:index indexInArray:&indexInArray];
    if (currentArray == nil) {
        return self.headers[indexInArray];
    }
    
    return currentArray[indexInArray];
}

- (void)insertObject:(id)object
      inItemsAtIndex:(NSUInteger)index
{
    NSUInteger indexInArray;
    NSMutableArray *array = [self arrayAtIndex:index
                                  indexInArray:&indexInArray];
    
    // As we can't insert into a header
    // when we get nil, we know it actually means we want to insert at the end of the
    // previous array.
    if (array == nil) {
        array = self.arrays[indexInArray - 1];
        indexInArray = array.count;
    }
    [array insertObject:object atIndex:indexInArray];
}

- (void)removeObjectFromItemsAtIndex:(NSUInteger)index
{
    NSUInteger indexInArray;
    NSMutableArray *array = [self arrayAtIndex:index
                                  indexInArray:&indexInArray];
    
    [array removeObjectAtIndex:indexInArray];
}

@end
