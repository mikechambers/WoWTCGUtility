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

#import "RarityPredicateEditorRowTemplate.h"
#import "Rarity.h"

@implementation RarityPredicateEditorRowTemplate

@synthesize rightPopup;
@synthesize leftPopup;
@synthesize expressionPopup;

-(void)dealloc
{
	[expressionPopup dealloc];
	[leftPopup dealloc];
	[rightPopup dealloc];
	[super dealloc];
}


-(id)init
{
	/************ left menu **************/
	NSMenu *leftMenu = [[[NSMenu allocWithZone:[NSMenu menuZone]] initWithTitle:@"keypath menu"] autorelease];
	
	NSMenuItem *leftMenuItem = [[[NSMenuItem alloc] initWithTitle:@"Rarity" action:nil keyEquivalent:@""] autorelease];
	[leftMenuItem setRepresentedObject:[NSExpression expressionForKeyPath:@"rarity"]];
	[leftMenuItem setEnabled:YES];
	
	[leftMenu addItem:leftMenuItem];
	
	leftPopup = [[NSPopUpButton alloc] initWithFrame:NSZeroRect pullsDown:NO];
	[leftPopup setMenu:leftMenu];	
	
	
	/************ right menu ***************/
	NSArray *types = [Rarity rarityNames];
	
	NSMenu *rightMenu = [[[NSMenu allocWithZone:[NSMenu menuZone]] initWithTitle:@"bool menu"] autorelease];
	
	NSExpression *rarityExpression;
	NSMenuItem *menuItem;
	for(NSString *s in types)
	{
		rarityExpression = [NSExpression expressionForConstantValue:[NSNumber numberWithInt:[Rarity getRarityTypeForDescription:s]]];
		
		menuItem = [[[NSMenuItem alloc] initWithTitle:s action:nil keyEquivalent:@""] autorelease];
		[menuItem setRepresentedObject:rarityExpression];
		[menuItem setEnabled:YES];
		
		[rightMenu addItem:menuItem];
	}
	
	rightPopup = [[NSPopUpButton alloc] initWithFrame:NSZeroRect pullsDown:NO];
	[rightPopup setMenu:rightMenu];	
	

	/************** center menu ***************/
	
	/*
	NSLessThanPredicateOperatorType = 0,
	NSLessThanOrEqualToPredicateOperatorType,
	NSGreaterThanPredicateOperatorType,
	NSGreaterThanOrEqualToPredicateOperatorType
	*/
	
	
	NSArray *menuTitles = [NSArray arrayWithObjects:
								@"is",
							   @"is not",
							   @"is less than",
							   @"is greater than",
							   @"is less than or equal to",
							   @"is greater than or equal to", nil];
	
	NSArray *menuValues = [NSArray arrayWithObjects:
							[NSNumber numberWithInt:NSEqualToPredicateOperatorType],
						   [NSNumber numberWithInt:NSNotEqualToPredicateOperatorType],
						   [NSNumber numberWithInt:NSLessThanPredicateOperatorType],
						   [NSNumber numberWithInt:NSGreaterThanPredicateOperatorType],
						   [NSNumber numberWithInt:NSLessThanOrEqualToPredicateOperatorType],
						   [NSNumber numberWithInt:NSGreaterThanOrEqualToPredicateOperatorType],
						   nil
						   ];
	
	
	NSMenu *expressionMenu = [[[NSMenu allocWithZone:[NSMenu menuZone]] initWithTitle:@"keypath menu"] autorelease];
	
	int len = menuTitles.count;
	
	NSMenuItem *mItem;
	for(int i = 0; i < len; i++)
	{
		mItem = [[[NSMenuItem alloc] initWithTitle:[menuTitles objectAtIndex:i] action:nil keyEquivalent:@""] autorelease];
		[mItem setRepresentedObject:[menuValues objectAtIndex:i]];
		[mItem setEnabled:YES];
		
		[expressionMenu addItem:mItem];
	}
	
	/*
	NSMenuItem *equalsMenuItem = [[[NSMenuItem alloc] initWithTitle:@"is" action:nil keyEquivalent:@""] autorelease];
	[equalsMenuItem setRepresentedObject:[NSNumber numberWithInt: NSEqualToPredicateOperatorType]];
	[equalsMenuItem setEnabled:YES];
	
	[expressionMenu addItem:equalsMenuItem];
	
	NSMenuItem *notEqualsMenuItem = [[[NSMenuItem alloc] initWithTitle:@"is not" action:nil keyEquivalent:@""] autorelease];
	[notEqualsMenuItem setRepresentedObject:[NSNumber numberWithInt:NSNotEqualToPredicateOperatorType]];
	[notEqualsMenuItem setEnabled:YES];
	
	[expressionMenu addItem:notEqualsMenuItem];
	*/
	
	expressionPopup = [[NSPopUpButton alloc] initWithFrame:NSZeroRect pullsDown:NO];
	[expressionPopup setMenu:expressionMenu];		

	
	return self;
}


- (id)copyWithZone:(NSZone *)zone
{
    return [self retain]; //we are immutable
}



- (double)matchForPredicate:(NSPredicate *)predicate
{	
	if([predicate isKindOfClass:[NSCompoundPredicate class]])
	{
		return [super matchForPredicate:predicate];
	}
	

	NSString* substr = [predicate.predicateFormat substringToIndex:6];	
	
	if ([substr isEqualToString: @"rarity"])
	{
		return .99;
	}
	
	return [super matchForPredicate:predicate];
}

-(NSArray *)templateViews
{
	NSArray *newViews = [NSArray arrayWithObjects:[self leftPopup], [self expressionPopup], [self rightPopup], nil];
	
	return newViews;
}

- (void)setPredicate:(NSPredicate *)predicate
{
	NSComparisonPredicate *p = (NSComparisonPredicate *)predicate;
	
	NSString *right = p.rightExpression.constantValue;

	
	NSString *rarityType = [Rarity getRarityDescriptionForType:[right intValue]];
	[rightPopup selectItemWithTitle:rarityType];
}

-(NSPredicate *)predicateWithSubpredicates:(NSArray *) subpredicates
{		
	NSExpression *rightExpression = [[rightPopup selectedItem] representedObject];
	NSExpression *expression = [[expressionPopup selectedItem] representedObject];

	NSPredicate *out = [NSComparisonPredicate predicateWithLeftExpression:[NSExpression expressionForKeyPath:@"rarity"]
																   rightExpression:[NSExpression expressionForConstantValue:rightExpression]
																		  modifier:NSDirectPredicateModifier 
																	 type:[(NSNumber *)expression intValue]
																		   options:0];
	

	//ok. im hitting some weird bug here. If if just return out, then the predicate fails when I filters.
	//if I first, create a new predicate, using the predicateFormat from out, then it works.
	//When I trace out each predicate, they are the same.
	//Note, NSPredicate predicateWithFormat is not doing the subsititution, which is why I have to create an extra NSString
	//which does do the subsitutiion
	return [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@", out.predicateFormat]];
}

- (NSArray *)displayableSubpredicatesOfPredicate:(NSPredicate *)predicate
{
	return nil;
}

@end
