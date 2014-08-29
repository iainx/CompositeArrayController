//
//  OTAppDelegate.m
//  CompositeArrayController
//
//  Created by iain on 24/08/2014.
//  Copyright (c) 2014 False Victories. All rights reserved.
//

#import "OTAppDelegate.h"
#import "FVCompositeArray.h"
#import "OTHeader.h"

@implementation OTAppDelegate {
    FVCompositeArray *_model;
    NSMutableArray *_section1;
    NSMutableArray *_section2;
    NSMutableArray *_section3;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    _section1 = [NSMutableArray arrayWithArray:@[@"Test 1.1", @"Test 1.2", @"Test 1.3"]];
    _section2 = [NSMutableArray arrayWithArray:@[@"Test 2.1", @"Test 2.2", @"Test 2.3", @"Test 2.4"]];
    _section3 = [NSMutableArray arrayWithArray:@[@"Red", @"Green", @"Blue"]];
    NSArray *headers = @[[[OTHeader alloc] initWithTitle:@"Section 1"],
                         [[OTHeader alloc] initWithTitle:@"Section 2"],
                         [[OTHeader alloc] initWithTitle:@"Colours"]];
    
    _model = [[FVCompositeArray alloc] init];
    _model.arrays = @[_section1, _section2, _section3];
    _model.headers = headers;
    
    id proxy = [_model mutableArrayValueForKey:@"items"];
    NSLog(@"Count: %lu", [proxy count]);

    self.arrayController = [[NSArrayController alloc] init];
    self.arrayController.avoidsEmptySelection = NO;
    [self.arrayController bind:@"contentArray" toObject:_model withKeyPath:@"items" options:nil];
}

- (IBAction)addToSection1:(id)sender
{
    NSUInteger compositeIndex = [_model compositeIndexForIndex:1 inArray:_section1];
    [self.arrayController insertObject:@"Addition 1" atArrangedObjectIndex:compositeIndex];
}

- (IBAction)addToSection2:(id)sender
{
    NSUInteger compositeIndex = [_model compositeIndexForIndex:1 inArray:_section2];
    [self.arrayController insertObject:@"Addition 2" atArrangedObjectIndex:compositeIndex];
}

- (IBAction)addToSection3:(id)sender
{
    NSUInteger compositeIndex = [_model compositeIndexForIndex:3 inArray:_section3];
    [self.arrayController insertObject:@"BLACK!" atArrangedObjectIndex:compositeIndex];
}

#pragma mark - NSTableViewDelegate methods

- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row
{
    id object = self.arrayController.arrangedObjects[row];
    NSTableCellView *view;
    
    if ([object isKindOfClass:[OTHeader class]]) {
        view = [tableView makeViewWithIdentifier:@"HeaderRow" owner:self];
        
        OTHeader *header = (OTHeader *)object;
        view.textField.stringValue = header.headerTitle;
    } else if ([object isKindOfClass:[NSString class]]) {
        view = [tableView makeViewWithIdentifier:@"NormalRow" owner:self];
        view.textField.stringValue = object;
    }
    
    return view;
}

- (BOOL)tableView:(NSTableView *)tableView
  shouldSelectRow:(NSInteger)row
{
    id object = self.arrayController.arrangedObjects[row];
    return ![object isKindOfClass:[OTHeader class]];
}
@end
