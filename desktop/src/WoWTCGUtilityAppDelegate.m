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

#import "WoWTCGUtilityAppDelegate.h"
#import "Card.h"
#import "Rarity.h"
#import "WoWTCGDataStore.h"
#import "MenuTagConstants.h"
#import "UserDefaultsConstants.h"
#import "CardURLScheme.h"

#define CARD_NODE_INDEX 0
#define SEARCH_NODE_INDEX 1
#define DECK_NODE_INDEX 2

#define BASE_RULES_SEARCH_URL @"http://entertainment.upperdeck.com/wow/community/search/SearchResults.aspx?s=122&q="

@implementation WoWTCGUtilityAppDelegate

@synthesize window;
@synthesize dataStore;
@synthesize cardTable;
@synthesize cardView;
@synthesize searchField;
@synthesize filteredCards;
@synthesize outlineView;
@synthesize deckNode;
@synthesize searchNode;
@synthesize addOutlineMenu;
@synthesize addOutlineButton;
@synthesize searchSheet;
@synthesize cardsNode;
@synthesize preferencesWindow;
@synthesize appName;

-(void)dealloc
{
	[appName release];
	[preferencesWindow release];
	[cardsNode release];
	[searchSheet release];
	[addOutlineButton release];
	[addOutlineMenu release];
	[searchNode release];
	[deckNode release];
	[outlineView release];
	[filteredCards release];
	[searchField release];
	[dataStore release];
	[cardTable release];
	[cardView release];
	[window release];
	[super dealloc];
}

/*************** initialization APIS **********************/

-(id)init
{
	[super init];
	
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *appDefaults = [NSDictionary
								 dictionaryWithObject:@"YES" forKey:RUN_DELETE_ALERT_KEY];
	
    [defaults registerDefaults:appDefaults];	
	
	NSBundle *bundle = [NSBundle mainBundle];
	self.appName = [bundle objectForInfoDictionaryKey:@"Bundle name"];
	
	searchType = CardFilterSearch;
	
	[self initData];
		
	self.filteredCards = [dataStore.cards mutableCopy];
	
	self.deckNode = [[Node alloc] initWithLabel:@"DECKS"];
	deckNode.children = [NSMutableArray arrayWithCapacity:0];
	
	self.searchNode = [[Node alloc] initWithLabel:@"SMART DECKS"];
	[self loadSearchData];
	
	self.cardsNode = [[Node alloc] initWithLabel:@"CARDS"];
	
	[self registerMyApp];
	
	return self;
}

-(void)awakeFromNib
{	
	NSSize minSize = { 500, 380 };
	[window setContentMinSize:minSize];
	
	[outlineView selectOutlineViewItem:cardsNode];
	
	outlineView.searchNode = searchNode;
	outlineView.deckNode = deckNode;
	outlineView.cardsNode = cardsNode;
	[outlineView selectRowIndexes:[NSIndexSet indexSetWithIndex:CARD_NODE_INDEX] byExtendingSelection:NO];
	
	[outlineView expandItem:searchNode];
	[outlineView expandItem:deckNode];
}

/**************** custom URL scheme handler apis *****************/

- (void)registerMyApp
{
	[[NSAppleEventManager sharedAppleEventManager] setEventHandler:self andSelector:@selector(getUrl:withReplyEvent:) forEventClass:kInternetEventClass andEventID:kAEGetURL];
}

- (void)getUrl:(NSAppleEventDescriptor *)event withReplyEvent:(NSAppleEventDescriptor *)replyEvent
{
	NSString *urlStr = [[[event paramDescriptorForKeyword:keyDirectObject] stringValue] stringByReplacingOccurrencesOfString:URL_SCHEME withString:@""];
	// Now you can parse the URL and perform whatever action is needed
	
	NSURL *url = [NSURL URLWithString:urlStr];	
	NSLog(@"path %@", url.path);
	
	//note commented out code below is for cardName search urls.
	//All of the code is in the app, but we have not exposed it via
	//UI right now
	
	/*
	if([url.path compare:SEARCH_ROOT_PATH] != NSOrderedSame || 
		[url.path compare:ID_ROOT_PATH] != NSOrderedSame)
	{
		return;
	}
	 */
	
	if([url.path compare:ROOT_PATH] != NSOrderedSame)
	{
		return;
	}
	
	//ID_ROOT_PATH
	
	NSString *query = url.query;
	
	NSArray *tokens = [query componentsSeparatedByString:@"="];
	
	if([tokens count] < 2)
	{
		return;
	}
	
	NSString *key = [tokens objectAtIndex:0];
	NSString *value = [[tokens objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	/*	
	if([key compare:@"cardname"] == NSOrderedSame)
	{
		searchField.stringValue = value;
		[self filterOnCardName:value];
	}
	 */

	if([key compare:CARD_ID_KEY] == NSOrderedSame)
	{
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"cardId == %i", [value intValue]];
		
		NSLog(@"%@", predicate.predicateFormat);
		[self filterCardsWithPredicate:predicate];
	}

}


/**************  General App Lifecycle APIs *****************/

-(void)initData
{	
	NSString *path = [[[NSBundle mainBundle] resourcePath] 
					   stringByAppendingPathComponent:@"/assets/wow_tcg.data"];	
	
	NSDictionary * rootObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
	
	self.dataStore = [rootObject valueForKey:DATA_STORE_KEY];
	
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication*)sender
{
    return YES;
}

/***************** Data Persistence APIs ********************/

-(void)saveSearchData
{
	NSString *path = [self pathForDataFile];
	
	NSMutableDictionary *rootObject = [NSMutableDictionary dictionary];
    
	[rootObject setValue: searchNode.children forKey:@"searches"];
	[NSKeyedArchiver archiveRootObject: rootObject toFile: path];
}

-(void)loadSearchData
{
	NSString *path = [self pathForDataFile];
	
	NSFileManager *fMan = [NSFileManager defaultManager];
	if(![fMan fileExistsAtPath:path])
	{
		searchNode.children = [NSMutableArray arrayWithCapacity:0];
		return;
	}
	
	NSDictionary * rootObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path]; 
	
	NSMutableArray *b = [rootObject valueForKey:@"searches"];
	
	searchNode.children = b;
}

- (NSString *) pathForDataFile
{
	//NSString *appName = [self appName];
    
	NSString *folder = [NSString stringWithFormat:@"~/Library/Application Support/%@/", appName];
	folder = [folder stringByExpandingTildeInPath];
	
	NSFileManager *fMan = [NSFileManager defaultManager];
	if ([fMan fileExistsAtPath:folder] == NO)
	{
		[fMan createDirectoryAtPath: folder withIntermediateDirectories: TRUE
						 attributes: nil error:NULL];
	}
    
	NSString *fileName = [NSString stringWithFormat:@"%@.searches", appName];
	
	return [folder stringByAppendingPathComponent: fileName];    
}

/********************* general Card TableView APIs *******************/

-(void)updateTableViewRowSelection
{
	NSIndexSet *row = [NSIndexSet indexSetWithIndex:0];
	[cardTable selectRowIndexes:row byExtendingSelection:FALSE];
}

-(void)refreshTableViewData
{
	[cardTable reloadData];
	
	//need to do this or somethings the grid is drawn wrong
	[cardTable setNeedsDisplay:TRUE];
	[cardTable noteNumberOfRowsChanged];
	[self updateTitle];
	
	if(filteredCards.count == 0)
	{
		return;
	}
	
	cardView.card = [filteredCards objectAtIndex:0];
	[self updateTableViewRowSelection];
}

-(void)updateTitle
{
	int index = [outlineView selectedRow];
	
	
	NSString *title;
	if(index == -1)
	{
		title = @"WoW TCG Utility";
	}
	else
	{
		Node *node = [outlineView itemAtRow:index];
	
		title = [NSString stringWithFormat:@"WoWTCG Utility : %@ (%i of %i Cards)", node.label, 
				self.filteredCards.count, 
				self.dataStore.cards.count];
	}
	
	window.title = title;
}

-(NSString *)getNewNodeName:(Node *)parentNode
{
	NSString *prefix;
	NSString *out;
	if(parentNode == searchNode)
	{
		
		prefix = @"untitled search";
		int len = searchNode.children.count;
		
		if(len == 0)
		{
			return prefix;
		}
		
		int count = 2;
		
		out = prefix;
		BOOL found = FALSE;
		while(TRUE)
		{
			for(Node *n in searchNode.children)
			{
				if([n.label compare:out] == NSOrderedSame)
				{
					found = true;
					break;
				}
			}
			
			if(found)
			{
				found = false;
				out = [prefix stringByAppendingFormat:@" %i", count];
				count++;
			}
			else
			{
				
				break;
			}
			
		}
	}
	
	return out;
}

/************ NSTableView DataSource APIs **************/

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
	return [filteredCards count];
}

-(id)tableView:(NSTableView *)table objectValueForTableColumn:(NSTableColumn *)column row:(NSInteger)row
{	
	NSString *identifier = [column identifier];
	Card *c = [filteredCards objectAtIndex:row];
	
	if([identifier compare:@"rarity"] == NSOrderedSame)
	{
		return [Rarity getRarityAbbreviationForType:(int)c.rarity];
	}
	else
	{
		return [c valueForKey:identifier];
	}
}

-(void)tableView:(NSTableView *)tableView sortDescriptorsDidChange:(NSArray *)oldDescriptors
{
	NSArray *newDescriptors = [cardTable sortDescriptors];
	
	[filteredCards sortUsingDescriptors:newDescriptors];
	
	[self refreshTableViewData];
}

/************* NSOutlineView Delegate APIs *****************/

- (void)outlineViewSelectionDidChange:(NSNotification *)notification
{
	[self updateOutlineViewSelection];
}

-(void)updateOutlineViewSelection
{
	
	int index = [outlineView selectedRow];
	
	Node *n = [outlineView itemAtRow:index];
	
	if(n == cardsNode)
	{
		self.filteredCards = [dataStore.cards mutableCopy];
		[self refreshTableViewData];
	}
	else if([outlineView parentForItem:n] == searchNode)
	{
		[self filterCardsWithPredicate:((NSPredicate *)n.data)];
	}
	else if([outlineView parentForItem:n] == deckNode)
	{
		//deckNode
	}
}

-(void)tableViewSelectionDidChange:(NSNotification *)notification
{
	int index = [cardTable selectedRow];
	
	if(index < 0)
	{
		return;
	}

	Card *c = nil;
	if([filteredCards count] > 0)
	{
		c = [filteredCards objectAtIndex:index];;
	}
	
	cardView.card = c;
}


/***************** Search APIs *******************/

-(IBAction)handleSearch:(NSSearchField *)sField
{
	NSString *searchString = [sField stringValue];
		
	if(searchType == RulesForumSearch)
	{
		[self searchRulesForum:searchString];
		return;
	}
	
	if([searchString length] == 0)
	{
		self.filteredCards = [dataStore.cards mutableCopy];
		[self refreshTableViewData];
		return;
	}
	
	[self filterOnCardName:searchString];
}

-(void)filterOnCardName:(NSString *)cardName
{
	NSPredicate *namePredicate = [NSPredicate predicateWithFormat:@"cardName contains[c] %@", cardName];
	[self filterCardsWithPredicate:namePredicate];
	[outlineView selectOutlineViewItem:cardsNode];
}

-(void)filterCardsWithPredicate:(NSPredicate *)predicate
{
	
	self.filteredCards = [dataStore.cards mutableCopy];
	
	[filteredCards filterUsingPredicate:predicate];
	
	[self refreshTableViewData];
}


-(void)searchRulesForum:(NSString *)searchString
{
	if([searchString length] == 0)
	{
		return;
	}
	
	NSString *escapedSearch = [searchString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSString *urlString = [NSString stringWithFormat:@"%@%@", BASE_RULES_SEARCH_URL, escapedSearch];

	[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:urlString]];
}

/************ General Outline View APIs **************/


//todo: move this to outline view class
-(void)deleteNode:(Node *)node
{
	Node *parent = [outlineView parentForItem:node];
	
	int index = [parent.children indexOfObject:node];
	
	[parent.children removeObject:node];
	
	[self saveSearchData];
	
	[outlineView reloadItem:parent reloadChildren:TRUE];
	
	
	//note: In most cases, the OutlineView will automatically
	//switch selection when we move an item. 
	//However, in some cases it will not. The first two if
	//statements below check for those.
	
	//if there are no more child nodes then set the selection
	//to the main cards node
	if(parent.children.count == 0)
	{
		[outlineView selectOutlineViewItem:cardsNode];
	}
	else if(index == 0)
	{
		[outlineView selectOutlineViewItem:[parent.children objectAtIndex:0]];
	}
	else
	{
		//otherwise, the controll will set the selection. We then just
		//need to update the cards
		[self updateOutlineViewSelection];
	}
}

/**************** Outline View Data Source APIs **********************/


- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item
{
	
	//used in case item == nil //i.e. root
	int out = 3;
	if(item == searchNode || item == deckNode)
	{
		out = [((Node*)item).children count];
	}
	
    return out;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item
{
	if(item == deckNode || item == searchNode)
	{
		return TRUE;
	}
	else
	{
		return FALSE;
	}
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item
{
	Node *out;
	if(item == nil)
	{
		switch(index)
		{
			case CARD_NODE_INDEX:
			{
				out = cardsNode;
				break;
			}
			case SEARCH_NODE_INDEX:
			{
				out = searchNode;
				break;
			}
			case DECK_NODE_INDEX:
			{
				out = deckNode;
				break;
			}
		}
	}
	else
	{
		out = [((Node*)item).children objectAtIndex:index];
	}
	
	return out;
}


- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item
{
	return ((Node *)item).label;
}

- (void)outlineView:(NSOutlineView *)outlineView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn byItem:(id)item
{
	NSString *s = ((NSString *) object);
	
	if(s.length < 1)
	{
		return;
	}
	
	((Node *)item).label = object;
	
	[self saveSearchData];
}

/***************** outline view delegate APIs ********************/

- (BOOL)outlineView:(NSOutlineView *)outlineView isGroupItem:(id)item
{
	BOOL out = FALSE;
	if(item == deckNode || item == searchNode || item == cardsNode)
	{
		out = TRUE;
	}

	return out;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView shouldSelectItem:(id)item
{
	return !(item == deckNode || item == searchNode);
}




/************ IBAction Handlers ****************/


-(IBAction)handleCreateSearchClick:(id)sender
{
	Node *n = [[[Node alloc] initWithLabel:[self getNewNodeName:searchNode]] autorelease];
	[self showSavedSearchSheet:n];
}


-(IBAction)handleEditSearchClick:(id)sender
{
	int selectedIndex = [outlineView selectedRow];
	Node *node = ((Node *)[outlineView itemAtRow:selectedIndex]);
	
	if([outlineView parentForItem:node] != searchNode)
	{
		//we should never get here
		
		NSLog(@"ERROR : onEditSearchClick: Edit Search Context Menu selected for non search node");
		return;
	}
	
	[self showSavedSearchSheet:node];
}

-(void)deleteOutlineViewNode:(Node *)node
{
	Node *parent = [outlineView parentForItem:node];
	if(parent != deckNode && parent != searchNode)
	{
		return;
	}
	
	BOOL runAlert = [[NSUserDefaults standardUserDefaults] boolForKey:RUN_DELETE_ALERT_KEY];
	
	if(!runAlert)
	{
		[self deleteNode:node];
		return;
	}
	
	NSString *type = (parent == deckNode)?@"Deck":@"Search";
	NSAlert *alert = [NSAlert alertWithMessageText:[NSString stringWithFormat:@"Are you sure you want to delete the %@ named \"%@\"?", type, node.label] 
									 defaultButton:@"OK" 
								   alternateButton:@"Cancel" 
									   otherButton:nil 
						 informativeTextWithFormat:@"This action cannot be undone."];
	
	alert.alertStyle = NSWarningAlertStyle;
	[alert setShowsSuppressionButton:TRUE];
	
	NSInteger result = [alert runModal];
	
	if(result == NSAlertDefaultReturn)
	{
		[self deleteNode:node];
	}
	
	if([[alert suppressionButton] state] == NSOnState)
	{
		[[NSUserDefaults standardUserDefaults] setBool:FALSE forKey:RUN_DELETE_ALERT_KEY];
	}
}

-(IBAction)handleDeleteNodeMenu:(id)sender
{
	int selectedIndex = [outlineView selectedRow];
	Node *node = ((Node *)[outlineView itemAtRow:selectedIndex]);
	[self deleteOutlineViewNode:node];

}

-(IBAction)handleAlwaysOnTopMenu:(id)sender
{
	NSMenuItem *item = (NSMenuItem *)sender;
	
	BOOL alwaysOnTop = !item.state;
	item.state = alwaysOnTop;
	
	if(alwaysOnTop)
	{
		[[self window] setLevel:NSFloatingWindowLevel];
	}
	else
	{
		[[self window] setLevel:NSNormalWindowLevel];
	}
}

-(IBAction)handleRenameItemMenu:(id)sender
{
	[outlineView setSelectedItemToEdit];
}

-(IBAction)handleSearchMenu:(id)sender
{
	NSMenuItem *item = (NSMenuItem *)sender;
	NSMenu *parent = item.menu;
	
	item.state = NSOnState;
	
	NSArray *items = parent.itemArray;
	
	for(NSMenuItem *mi in items)
	{
		if(mi.tag != item.tag)
		{
			mi.state = NSOffState;
		}
	}
	
	NSSearchFieldCell *cell = [searchField cell];
	if(item.tag == SEARCH_CARDS_TAG)
	{
		searchType = CardFilterSearch;
		[cell setSendsWholeSearchString:FALSE];
	}
	else if(item.tag == SEARCH_RULES_FORUM_TAG)
	{
		searchType = RulesForumSearch;
		[cell setSendsWholeSearchString:TRUE];
	}
}

-(IBAction)handlePreferencesMenuClick:(id)sender
{
	if(!preferencesWindow)
	{
		self.preferencesWindow = [[PreferencesWindowController alloc] init];
	}
	
	[preferencesWindow showWindow:self];
	[preferencesWindow.window center];
}

/****************** Search Sheet APIs ***********/


//delegate listener for SearchSheet
- (void)predicateNodeWasCreated:(Node *)predicateNode
{
	if([outlineView rowForItem:predicateNode] == -1)
	{
		[searchNode.children addObject:predicateNode];
	}
	
	[outlineView reloadItem:searchNode reloadChildren:TRUE];
	[outlineView expandItem:searchNode];
	
	[outlineView selectOutlineViewItem:predicateNode];
	
	[self filterCardsWithPredicate:((NSPredicate *)predicateNode.data)];

	[self saveSearchData];
}

-(void)showSavedSearchSheet:(Node *)predicateNode
{
	if(searchSheet == nil)
	{
		self.searchSheet = [[SearchSheetController alloc] init];
		searchSheet.dataStore = dataStore;
		searchSheet.delegate = self;
	}
	
	[searchSheet showSheet:[self window] withPredicateNode:predicateNode];
}

- ( void ) deleteKeyPressed: ( NSOutlineView * ) view onRow: ( int ) rowIndex
{
	Node *node = ((Node *)[outlineView itemAtRow:rowIndex]);
	[self deleteOutlineViewNode:node];
}


@end
