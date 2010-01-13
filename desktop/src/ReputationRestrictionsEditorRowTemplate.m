/*
 Copyright (c) 2010 Mike Chambers
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

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
