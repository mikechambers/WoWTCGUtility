//
//  TokenManagerAppDelegate.h
//  TokenManager
//
//  Created by Mike Chambers on 1/15/10.
//  Copyright 2010 Mike Chambers. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define GENERIC_TOKEN_TAG 1

@interface TokenManagerAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

-(IBAction)handleAddTokenSelect:(NSPopUpButton *)sender;

@end
