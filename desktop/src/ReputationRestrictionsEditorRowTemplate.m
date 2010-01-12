//
//  ReputationRestrictionsEditorRowTemplate.m
//  WoWTCGUtility
//
//  Created by Mike Chambers on 1/12/10.
//  Copyright 2010 Mike Chambers. All rights reserved.
//

#import "ReputationRestrictionsEditorRowTemplate.h"


@implementation ReputationRestrictionsEditorRowTemplate

-(id)initWithArray:(NSArray *)arr
{
	if(![super initWithArray:arr forKeyPath:@"reputationRestrictions" andTitle:@"Reputation Restriction"])
	{
		return nil;
	}
	
	NSMenu *expressionMenu = [[[NSMenu allocWithZone:[NSMenu menuZone]] initWithTitle:@"keypath menu"] autorelease];
	
	/*
	NSMenuItem *containsMenuItem = [[[NSMenuItem alloc] initWithTitle:@"contains" action:nil keyEquivalent:@""] autorelease];
	[containsMenuItem setRepresentedObject:[NSNumber numberWithInt: NSContainsPredicateOperatorType]];
	[containsMenuItem setEnabled:YES];
	
	[expressionMenu addItem:containsMenuItem];
	*/
	
	NSMenuItem *equalsMenuItem = [[[NSMenuItem alloc] initWithTitle:@"is" action:nil keyEquivalent:@""] autorelease];
	[equalsMenuItem setRepresentedObject:[NSNumber numberWithInt: NSEqualToPredicateOperatorType]];
	[equalsMenuItem setEnabled:YES];
	
	[expressionMenu addItem:equalsMenuItem];
	/*
	NSMenuItem *notEqualsMenuItem = [[[NSMenuItem alloc] initWithTitle:@"is not" action:nil keyEquivalent:@""] autorelease];
	[notEqualsMenuItem setRepresentedObject:[NSNumber numberWithInt:NSNotEqualToPredicateOperatorType]];
	[notEqualsMenuItem setEnabled:YES];
	
	[expressionMenu addItem:notEqualsMenuItem];	
	*/
	
	NSPopUpButton *expressionPopup = [[NSPopUpButton alloc] initWithFrame:NSZeroRect pullsDown:NO];
	[expressionPopup setMenu:expressionMenu];	
	
	[self.customTemplateViews replaceObjectAtIndex:1 withObject:expressionPopup];
	
	return self;
}

@end
