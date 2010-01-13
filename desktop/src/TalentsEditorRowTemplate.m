//
//  TalentsEditorRowTemplate.m
//  WoWTCGUtility
//
//  Created by Mike Chambers on 1/13/10.
//  Copyright 2010 Mike Chambers. All rights reserved.
//

#import "TalentsEditorRowTemplate.h"


@implementation TalentsEditorRowTemplate

-(id)initWithArray:(NSArray *)arr
{
	if(![super initWithArray:arr forKeyPath:@"talent" andTitle:@"Talent"])
	{
		return nil;
	}
	
	NSMenu *expressionMenu = [[[NSMenu allocWithZone:[NSMenu menuZone]] initWithTitle:@"keypath menu"] autorelease];
	
	NSMenuItem *equalsMenuItem = [[[NSMenuItem alloc] initWithTitle:@"is" action:nil keyEquivalent:@""] autorelease];
	[equalsMenuItem setRepresentedObject:[NSNumber numberWithInt: NSEqualToPredicateOperatorType]];
	[equalsMenuItem setEnabled:YES];
	
	[expressionMenu addItem:equalsMenuItem];
	
	NSPopUpButton *expressionPopup = [[NSPopUpButton alloc] initWithFrame:NSZeroRect pullsDown:NO];
	[expressionPopup setMenu:expressionMenu];	
	
	[self.customTemplateViews replaceObjectAtIndex:1 withObject:expressionPopup];
	
	return self;
}

@end
