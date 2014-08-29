//
//  OTHeader.h
//  CompositeArrayController
//
//  Created by iain on 29/08/2014.
//  Copyright (c) 2014 False Victories. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OTHeader : NSObject

@property (readwrite, copy) NSString *headerTitle;

- (instancetype)initWithTitle:(NSString *)title;
@end
