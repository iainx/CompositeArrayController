//
//  OTAppDelegate.h
//  CompositeArrayController
//
//  Created by iain on 24/08/2014.
//  Copyright (c) 2014 False Victories. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface OTAppDelegate : NSObject <NSApplicationDelegate, NSTableViewDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (readwrite, strong) NSArrayController *arrayController;

- (IBAction)addToSection1:(id)sender;
- (IBAction)addToSection2:(id)sender;
- (IBAction)addToSection3:(id)sender;
@end
