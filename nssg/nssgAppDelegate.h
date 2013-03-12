//
//  nssgAppDelegate.h
//  nssg
//
//  Created by Donald Rowe on 3/8/13.
//  Copyright (c) 2013 Donald Rowe. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface nssgAppDelegate : NSObject <NSApplicationDelegate>

// Delegate methods:
- (void)updateUserInterface;

// Window properties:
@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *textField;


@end
