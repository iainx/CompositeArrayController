//
//  OTHeader.m
//  CompositeArrayController
//
//  Created by iain on 29/08/2014.
//  Copyright (c) 2014 False Victories. All rights reserved.
//

#import "OTHeader.h"

@implementation OTHeader

- (instancetype)initWithTitle:(NSString *)title
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _headerTitle = title;
    return self;
}

@end
