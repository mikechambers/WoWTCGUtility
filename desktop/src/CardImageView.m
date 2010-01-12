//
//  CardImage.m
//  WoWTCGUtility
//
//  Created by Mike Chambers on 1/12/10.
//  Copyright 2010 Mike Chambers. All rights reserved.
//

#import "CardImageView.h"


@implementation CardImageView

@synthesize card;

-(void)dealloc
{
	[card release];
	[super dealloc];
}

-(void)setCard:(Card *) c
{
	if(self->card == c)
	{
		return;
	}
	
	[self->card release];
	self->card = [c retain];
	
	[self displayCard];
}

-(void)displayCard
{
	NSString *path = [[[[NSBundle mainBundle] resourcePath] 
					   stringByAppendingPathComponent:@"/assets/cards/"]
					  stringByAppendingPathComponent:card.cardImageName];
	
	NSFileManager *fMan = [NSFileManager defaultManager];
	if(![fMan fileExistsAtPath:path])
	{
		path = [[[NSBundle mainBundle] resourcePath] 
				stringByAppendingPathComponent:@"/assets/icons/background.png"];
	}
	
	
	NSImage *im = [[NSImage alloc] initByReferencingFile:path];
	
	self.image = im;
	
	[im release];	
}

@end
