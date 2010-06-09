//
//  TokenManagerAppDelegate.m
//  TokenManager
//
//  Created by Mike Chambers on 1/15/10.
//  Copyright 2010 Mike Chambers. All rights reserved.
//

#import "TokenManagerAppDelegate.h"
#import "TokenWindowController.h"

@implementation TokenManagerAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Insert code here to initialize your application 
}


-(IBAction)handleAddTokenSelect:(NSPopUpButton *)sender
{
	int tag = [[sender selectedItem] tag];
	
	TokenType type = -1;
	switch(tag)
	{
		case GENERIC_TOKEN_TAG:
		{
			type = CounterTokenType;
		}
	}
	
	if(type == -1)
	{
		return;
	}
	
	TokenWindowController *token = [[TokenWindowController alloc] initWithTokenType:type];
	[token showWindow:self];
}

@end
