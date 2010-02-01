//
//  CardTableView.m
//  WoWTCGUtility
//
//  Created by Mike Chambers on 1/31/10.
//  Copyright 2010 Mike Chambers. All rights reserved.
//

#import "CardTableView.h"
#import "NSTableViewDeleteKeyDelegate.h"

@implementation CardTableView

- (void)keyDown:(NSEvent *)event
{
	id obj = [self delegate];
	unichar firstChar = [[event characters] characterAtIndex: 0];
	
	if ( ( firstChar == NSDeleteFunctionKey ||
		  firstChar == NSDeleteCharFunctionKey ||
		  firstChar == NSDeleteCharacter) &&
		[obj respondsToSelector: @selector( tableViewDeleteKeyPressed: )] )
	{		
		id <NSTableViewDeleteKeyDelegate> delegate = ( id <NSTableViewDeleteKeyDelegate> ) obj;
		[delegate tableViewDeleteKeyPressed:self];
	}
	else
	{
		[super keyDown:event];
	}
}

-(void)selectTableViewIndex:(int)index
{
	NSIndexSet *row = [NSIndexSet indexSetWithIndex:index];
	[self selectRowIndexes:row byExtendingSelection:FALSE];
}

-(void)redraw
{
	//need to do this or somethings the grid is drawn wrong
	[self setNeedsDisplay:TRUE];
	[self noteNumberOfRowsChanged];
}

@end
