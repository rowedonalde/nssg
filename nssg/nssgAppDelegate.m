//
//  nssgAppDelegate.m
//  nssg
//
//  Created by Donald Rowe on 3/8/13.
//  Copyright (c) 2013 Donald Rowe. All rights reserved.
//

#import "nssgAppDelegate.h"

@implementation nssgAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    //NSArray* touchArgs = @[@"/Users/don/touched.txt"];
    
    //NSTask* toucher = [NSTask launchedTaskWithLaunchPath:@"/usr/bin/touch" arguments:touchArgs];
    
    // Launch it:
    //[toucher launch];
    
    NSString *svnWhich = @"/usr/bin/svn";
    NSString *svnCommand = @"info";
    NSString *svnXPath = @"/Users/don/svnrepos/svnx-read-only";
    NSArray *svnArgs = @[svnCommand, svnXPath];
    
    NSString *grepWhich = @"/usr/bin/grep";
    NSString *grepNeedle = @"Repository Root:";
    NSArray *grepArgs = @[grepNeedle];
    
    // Update the UI:
    //[self updateUserInterface];
    
    // Create a pipe for svn to read to:
    NSPipe *svnPipe = [NSPipe pipe];
    //NSFileHandle *standardOutput = [NSFileHandle fileHandleWithStandardOutput];
    //[svnPipe]
    //NSString *dumpFileName = @"/Users/don/svn-info.out"; //nvm, just used stdout
    
    // Launch svn info:
    //NSTask *svnInfoCall = [NSTask launchedTaskWithLaunchPath:svnWhich arguments:svnArgs];
    NSTask *svnInfoCall = [[NSTask alloc] init];
    //[svnInfoCall setStandardOutput:standardOutput];
    [svnInfoCall setStandardOutput:svnPipe];
    [svnInfoCall setLaunchPath:svnWhich];
    [svnInfoCall setArguments:svnArgs];
    [svnInfoCall launch];
    //[svnInfoCall waitUntilExit];
    
    // Launch grep:
    NSTask *grepCall = [[NSTask alloc] init];
    // Output "file":
    //NSFileHandle *grepOut = [NSFileHandle fileHandleForWritingAtPath:@"/tmp/svn.out"];
    //NSFileHandle *grepOut = [NSFileHandle fileHandleWithNullDevice];
    NSPipe *grepPipe = [NSPipe pipe];
    [grepCall setStandardInput:svnPipe];
    [grepCall setStandardOutput:grepPipe];
    [grepCall setLaunchPath:grepWhich];
    [grepCall setArguments:grepArgs];
    [grepCall launch];
    [grepCall waitUntilExit];
    //NSData *grepData = [[grepPipe fileHandleForReading] readDataToEndOfFile];
    NSData *grepData = [[grepPipe fileHandleForReading] availableData];
    NSString *grepString = [[NSString alloc] initWithData:grepData encoding:NSUTF8StringEncoding];
    
    
    // Log the grep output:
    NSLog(@"%@", grepString);
    [self.textField setStringValue:grepString];
    
    // Log the svn output:
    //NSLog(<#NSString *format, ...#>)
    
    //NSLog(@"It's done");
    
    //[svnInfoCall terminate];
    //NSLog(@"Exit Status: %d", [svnInfoCall terminationStatus]);
    
}

- (void)updateUserInterface {
    // Get the current message text:
    NSString *dispTxt = @"Hello";
    
    // Display the text:
    [self.textField setStringValue:dispTxt];
    //[self.textField setFloatValue:1.1];
    
    NSLog(@"The UI has been updated");
}

@end
