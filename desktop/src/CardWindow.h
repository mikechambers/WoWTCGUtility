//
//  CardWindow.h
//  WoWTCGUtility
//
//  Created by Mike Chambers on 1/12/10.
//  Copyright 2010 Mike Chambers. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Card.h"
#import "CardImageView.h"

@interface CardWindow : NSWindowController
{
	Card *card;
	IBOutlet CardImageView *imageView;
}

@property (retain) Card *card;
@property (retain) IBOutlet CardImageView *imageView;

@end
