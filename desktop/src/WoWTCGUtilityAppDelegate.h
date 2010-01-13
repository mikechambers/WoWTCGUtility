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

#import <Cocoa/Cocoa.h>
#import "WoWTCGDataStore.h"
#import "CardView.h"
#import "Node.h"
#import "SearchSheetController.h"
#import "DataOutlineView.h"
#import "PreferencesWindowController.h"
#import "DeleteKeyDelegate.h"

typedef enum {
	CardFilterSearch = 0,
	RulesForumSearch = 1
} SearchTypeEnum;

#if __MAC_OS_X_VERSION_MIN_REQUIRED < 1060
	@interface WoWTCGUtilityAppDelegate : NSObject <DeleteKeyDelegate>
#else
	@interface WoWTCGUtilityAppDelegate : NSObject <NSApplicationDelegate, DeleteKeyDelegate>
#endif
{
	SearchTypeEnum searchType;
	
	IBOutlet NSTableView *cardTable;
	IBOutlet CardView *cardView;
	IBOutlet NSSearchField *searchField;
	IBOutlet DataOutlineView *outlineView;
	IBOutlet NSMenu *addOutlineMenu;
	IBOutlet NSString *appName;
	
	NSMutableArray *filteredCards;
	NSInteger iPreviousRowCount;
	
	Node *deckNode;
	Node *searchNode;
	Node *cardsNode;
	SearchSheetController *searchSheet;
    NSWindow *window;
	WoWTCGDataStore *dataStore;	
	NSButton *addOutlineButton;
	PreferencesWindowController *preferencesWindow;
	
	NSArray *searchKeys;
}

@property (retain) NSArray *searchKeys;
@property (retain) PreferencesWindowController *preferencesWindow;
@property (assign) IBOutlet NSWindow *window;
@property (retain) IBOutlet NSTableView *cardTable;
@property (retain) IBOutlet CardView *cardView;
@property (retain) IBOutlet NSSearchField *searchField;
@property (retain) IBOutlet DataOutlineView *outlineView;
@property (retain) IBOutlet NSMenu *addOutlineMenu;
@property (retain) IBOutlet NSButton *addOutlineButton;
@property (retain) IBOutlet NSString *appName;

@property (retain) NSMutableArray *filteredCards;
@property (retain) WoWTCGDataStore *dataStore;
@property (retain) SearchSheetController *searchSheet;
@property (retain) Node *deckNode;
@property (retain) Node *searchNode;
@property (retain) Node *cardsNode;

-(IBAction)handleSearch:(NSSearchField *)searchField;
-(IBAction)handleEditSearchClick:(id)sender;
-(IBAction)handleCreateSearchClick:(id)sender;
-(IBAction)handleDeleteNodeMenu:(id)sender;
-(IBAction)handleAlwaysOnTopMenu:(id)sender;
-(IBAction)handleSearchMenu:(id)sender;
-(IBAction)handleRenameItemMenu:(id)sender;
-(IBAction)handlePreferencesMenuClick:(id)sender;

-(void)initData;

-(void)saveSearchData;
-(NSString *) pathForDataFile;

-(void)resetCardData;
-(void)refreshCardTableData;
-(void)redrawCardTable;
-(void)selectCardTableRow:(int)index;


//-(void)updateTableViewRowSelection;
-(void)showSavedSearchSheet:(Node *)predicateNode;
-(void)filterCardsWithPredicate:(NSPredicate *)predicate;
-(void)loadSearchData;
-(void)deleteNode:(Node *)node;
-(void)updateOutlineViewSelection;
-(void)searchRulesForum:(NSString *)searchString;
-(void)updateTitle;
-(NSString *)getNewNodeName:(Node *)parentNode;
- (void)registerMyApp;

@end
