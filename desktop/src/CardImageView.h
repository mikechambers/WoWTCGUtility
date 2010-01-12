//
//  CardImage.h
//  WoWTCGUtility
//
//  Created by Mike Chambers on 1/12/10.
//  Copyright 2010 Mike Chambers. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Card.h"

@interface CardImageView : NSImageView
{
	Card *card;
}

@property (retain) Card *card;

-(void)displayCard;

@end
