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

#import "ArrayPredicateEditorRowTemplate.h"


@implementation ArrayPredicateEditorRowTemplate

@synthesize customTemplateViews;

-(void)dealloc
{
	[customTemplateViews dealloc];
	[super dealloc];
}

- (id)copyWithZone:(NSZone *)zone
{
    return [self retain]; //we are immutable
}

-(id)initWithArray:(NSArray *)arr forKeyPath:(NSString *)keyPath
{
	NSString *capPath = [keyPath capitalizedString];
	if(![self initWithArray:arr forKeyPath:keyPath andTitle: capPath])
	{
		return nil;
	}
	
	return self;
}

//designated constructor
-(id)initWithArray:(NSArray *)arr forKeyPath:(NSString *)keyPath andTitle:(NSString *)title
{	
	NSMutableArray *expressions = [NSMutableArray arrayWithCapacity:[arr count]];
	for(NSString *s in arr)
	{
		[expressions addObject:[NSExpression expressionForConstantValue:s]];
	}	
	
	if(!(self = [super initWithLeftExpressions:[NSArray arrayWithObjects:[NSExpression expressionForKeyPath:keyPath], nil]
					  rightExpressions:expressions
							  modifier:NSDirectPredicateModifier
							 operators:[NSArray arrayWithObjects:
										[NSNumber numberWithInt:NSEqualToPredicateOperatorType],
										[NSNumber numberWithInt:NSNotEqualToPredicateOperatorType], nil]
							   options:NSCaseInsensitivePredicateOption
		 ]))
	{
		return nil;
	}
	
	
	NSMenu *popupMenu = [[[NSMenu allocWithZone:[NSMenu menuZone]] initWithTitle:title] autorelease];
	
	NSMenuItem *menuItem = [[[NSMenuItem alloc] initWithTitle:title action:nil keyEquivalent:@""] autorelease];
	[menuItem setRepresentedObject:[NSExpression expressionForKeyPath:keyPath]];
	[menuItem setEnabled:YES];
	
	[popupMenu addItem:menuItem];
	
	NSPopUpButton *popup = [[[NSPopUpButton alloc] initWithFrame:NSZeroRect pullsDown:NO] autorelease];
	[popup setMenu:popupMenu];
	
	self.customTemplateViews = [[super templateViews] mutableCopy];	
	
	[self.customTemplateViews replaceObjectAtIndex:0 withObject:popup];
	
	return self;
}


- (NSArray *)templateViews
{
	return customTemplateViews;
}

@end
