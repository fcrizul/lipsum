//
//  AppDelegate.h
//  Lorem Ipsum
//
//  Created by Francisco Crizul on 2/27/14.
//  Copyright (c) 2014 Francisco Crizul. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate,NSURLConnectionDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *count;
@property (unsafe_unretained) IBOutlet NSTextView *lipsum;
@property (weak) IBOutlet NSTextField *infoLipsum;
@property (weak) IBOutlet NSButton *start;
@property (weak) IBOutlet NSProgressIndicator *progressIndicator;
@property (weak) IBOutlet NSButton *genButton;
@property (weak) IBOutlet NSComboBox *typeOfResult;

- (IBAction)GenerateButton:(id)sender;

@end
