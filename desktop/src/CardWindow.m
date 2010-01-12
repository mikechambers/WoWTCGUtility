//
//  CardWindow.m
//  WoWTCGUtility
//
//  Created by Mike Chambers on 1/12/10.
//  Copyright 2010 Mike Chambers. All rights reserved.
//

#import "CardWindow.h"


@implementation CardWindow

@synthesize card;
@synthesize imageView;

-(void)dealloc
{
	[card release];
	[imageView release];
	
	[super dealloc];
}

-(id)init
{
	if(![super initWithWindowNibName:@"CardWindow"])
	{
		return nil;
	}
	
	return self;
}

-(void)awakeFromNib
{
	[[self window] setLevel:NSFloatingWindowLevel];
	imageView.card = card;
}

-(void)setCard:(Card *) c
{
	if(self->card == c)
	{
		return;
	}
	
	[self->card release];
	self->card = [c retain];
	
	if(card)
	{
		self.window.title = card.cardName;
	}
}

@end
