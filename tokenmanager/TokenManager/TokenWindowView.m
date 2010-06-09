//
//  TokenWindowView.m
//  TokenManager
//
//  Created by Mike Chambers on 1/15/10.
//  Copyright 2010 Mike Chambers. All rights reserved.
//

#import "TokenWindowView.h"


@implementation TokenWindowView

@synthesize backgroundImage;

-(void)dealloc
{
	[backgroundImage release];
	[super dealloc];
}

- (void)drawRect:(NSRect)rect
{	
	[[NSColor clearColor] set];
    NSRectFill([self frame]);
	
	
	if(!backgroundImage)
	{
		return;
	}
	
	[backgroundImage compositeToPoint:NSZeroPoint operation:NSCompositeSourceOver];
	
	[[self window] setHasShadow:NO];
	[[self window] setHasShadow:YES];
}

@end
