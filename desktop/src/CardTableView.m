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
		[obj respondsToSelector: @selector( tableView:deleteKeyPressedOnRow: )] )
	{
		int index = [self selectedRow];
		
		id <NSTableViewDeleteKeyDelegate> delegate = ( id <NSTableViewDeleteKeyDelegate> ) obj;
		[delegate tableView:self deleteKeyPressedOnRow: index];
	}
	else
	{
		[super keyDown:event];
	}
}

@end
