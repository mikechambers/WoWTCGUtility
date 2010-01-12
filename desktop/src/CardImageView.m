//
//  CardImage.m
//  WoWTCGUtility
//
//  Created by Mike Chambers on 1/12/10.
//  Copyright 2010 Mike Chambers. All rights reserved.
//

#import "CardImageView.h"
#import "CardWindow.h"

@implementation CardImageView

@synthesize card;
@synthesize enableClick;

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

- (void)mouseDown:(NSEvent *)event
{
    unsigned flags = [event modifierFlags];	
	
	if(enableClick && (flags & NSShiftKeyMask))
	{
		CardWindow *w = [[CardWindow alloc] init];
		w.card = card;
		[w showWindow:self];
	}
	
	[super mouseDown:event];
}

@end
