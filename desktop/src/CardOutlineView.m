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

#import "CardOutlineView.h"
#import "MenuTagConstants.h"
#import "NSOutlineView+DeleteKey.h"

@implementation CardOutlineView

@synthesize contextMenu;
@synthesize searchNode;
@synthesize deckNode;
@synthesize cardsNode;

- (id)initWithCoder:(NSCoder *)decoder
{
	if(![super initWithCoder:decoder])
	{
		return nil;
	}
	
	self.deckNode = [[[Node alloc] initWithLabel:@"DECKS"] autorelease];
	deckNode.children = [NSMutableArray arrayWithCapacity:0];
	
	self.searchNode = [[[Node alloc] initWithLabel:@"SMART DECKS"] autorelease];

	self.cardsNode = [[[Node alloc] initWithLabel:@"CARDS"] autorelease];	
	
	return self;
}

-(void)awakeFromNib
{		
	[self selectOutlineViewItem:cardsNode];
	
	[self selectRowIndexes:[NSIndexSet indexSetWithIndex:CARD_NODE_INDEX] byExtendingSelection:NO];
}

-(void)expandNodes
{
	[self expandItem:searchNode];
	[self expandItem:deckNode];
}

-(void)dealloc
{
	[cardsNode release];
	[searchNode release];
	[deckNode release];
	[contextMenu release];
	[super dealloc];
}

- (NSMenu *)menuForEvent:(NSEvent *)theEvent
{
    NSPoint pt = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    Node *item = (Node *)[self itemAtRow: [self rowAtPoint:pt]];
	
	[self updateMenuState:contextMenu forItem:item];

	if(item != searchNode && item != deckNode && item != cardsNode)
	{
		[self selectOutlineViewItem:item];
	}
	
	return contextMenu;
}

- (void)menuNeedsUpdate:(NSMenu *)menu
{
	Node *node = [self selectedNode];
	[self updateMenuState:menu forItem:node];
}

-(Node *)selectedNode
{
	Node *node = [self itemAtRow:[self selectedRow]];
	return node;
}

-(void)refreshNode:(Node *)node
{
	[self reloadItem:node reloadChildren:TRUE];
	[self expandItem:node];
}

-(void)updateMenuState:(NSMenu *)menu forItem:(Node *)node
{
	Node *parent = [self parentForItem:node];
	
	BOOL isSearchNode = FALSE;
	BOOL isDeckNode = FALSE;
	
	if(parent == searchNode)
	{
		isSearchNode = TRUE;
		
	}
	else if(parent == deckNode)
	{
		isDeckNode = TRUE;
	}
	
	NSMenuItem *editSearchMenu = [menu itemWithTag:EDIT_SEARCH_TAG];
	NSMenuItem *deleteSearchMenu = [menu itemWithTag:DELETE_SEARCH_TAG];
	NSMenuItem *renameSearchMenu = [menu itemWithTag:RENAME_SEARCH_TAG];
	NSMenuItem *exportSearchMenu = [menu itemWithTag:EXPORT_SEARCH_TAG];
	[exportSearchMenu setEnabled:isSearchNode];
	[editSearchMenu setEnabled:isSearchNode];
	[deleteSearchMenu setEnabled:isSearchNode];
	[renameSearchMenu setEnabled:isSearchNode];
	
	
	NSMenuItem *editDeckMenu = [menu itemWithTag:EDIT_DECK_TAG];
	NSMenuItem *deleteDeckMenu = [menu itemWithTag:DELETE_DECK_TAG];
	NSMenuItem *renameDeckMenu = [menu itemWithTag:RENAME_DECK_TAG];
	NSMenuItem *exportDeckMenu = [menu itemWithTag:EXPORT_DECK_TAG];
	[exportDeckMenu setEnabled:isDeckNode];
	[editDeckMenu setEnabled:isDeckNode];	
	[deleteDeckMenu setEnabled:isDeckNode];
	[renameDeckMenu setEnabled:isDeckNode];	
}

-(void)selectOutlineViewItem:(Node *)node
{
	int index = [self rowForItem:node];
	NSIndexSet *row = [NSIndexSet indexSetWithIndex:index];
	[self selectRowIndexes:row byExtendingSelection:FALSE];
}

-(void)setSelectedItemToEdit
{
	int index = [self selectedRow];
	Node *n =  [self itemAtRow:index];
	
	Node *parent = [self parentForItem:n];
	if(parent != deckNode && parent != searchNode)
	{
		return;
	}
	
	[self editColumn:0 row: self.selectedRow withEvent:nil select:TRUE];
}



@end
