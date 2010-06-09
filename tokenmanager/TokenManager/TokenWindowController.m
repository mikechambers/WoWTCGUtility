//
//  TokenWindow.m
//  TokenManager
//
//  Created by Mike Chambers on 1/15/10.
//  Copyright 2010 Mike Chambers. All rights reserved.
//

#import "TokenWindowController.h"
#import <AppKit/AppKit.h>

@implementation TokenWindowController

@synthesize initialLocation;
@synthesize contentView;
@synthesize tokenType;

-(void)dealloc
{
	[contentView release];
	[super dealloc];
}

-(id)initWithTokenType:(TokenType)value
{
	if(![super initWithWindowNibName:@"TokenWindow"])
	{
		return nil;
	}
	
	[[self window] setLevel:NSFloatingWindowLevel];
	
	self.tokenType = value;
	
	return self;
}

-(void)awakeFromNib
{
	[self drawToken];
}


-(void)drawToken
{	
	NSString *tokenImageName;
	
	
	switch(tokenType)
	{
		case CounterTokenType:
		{
			tokenImageName = @"counterToken.png";
		}
	}
	
	NSString *path = [[[[NSBundle mainBundle] resourcePath] 
					   stringByAppendingPathComponent:@"/assets/tokens/"]
					  stringByAppendingPathComponent:tokenImageName];
	
	NSFileManager *fMan = [NSFileManager defaultManager];
	if(![fMan fileExistsAtPath:path])
	{
		return;
	}
	
	NSImage *im = [[NSImage alloc] initByReferencingFile:path];
	
	self.contentView.backgroundImage = im;
	
	[self.contentView drawRect:[self.contentView frame]];
	
	[im release];	
	
}
@end
