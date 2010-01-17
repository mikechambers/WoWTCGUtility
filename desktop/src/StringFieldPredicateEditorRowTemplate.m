//
//  StringFieldPredicateEditorRowTemplate.m
//  WoWTCGUtility
//
//  Created by Mike Chambers on 1/17/10.
//  Copyright 2010 Mike Chambers. All rights reserved.
//

#import "StringFieldPredicateEditorRowTemplate.h"


@implementation StringFieldPredicateEditorRowTemplate

- (NSArray *)templateViews
{
	if(!super.currentTemplateViews)
	{
		super.currentTemplateViews = [[super templateViews] mutableCopy];
		NSTextField *field = [super.currentTemplateViews objectAtIndex:2];
		NSRect frame = field.frame;
		
		NSRect rect;
		rect.origin = frame.origin;
		rect.size.width  = 250;
		rect.size.height = frame.size.height;
		
		field.frame = rect;
	}
	
	return super.currentTemplateViews;
}

@end
