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

#import "SearchSheetController.h"
#import "RarityPredicateEditorRowTemplate.h"
#import "ArrayPredicateEditorRowTemplate.h"
#import "DamageTypePredicateEditorRowTemplate.h"
#import "ReputationRestrictionsEditorRowTemplate.h"

@implementation SearchSheetController

@synthesize dataStore;
@synthesize sheet;
@synthesize predicateEditor;
@synthesize predicateNode;
@synthesize nameField;
@synthesize okButton;

-(void)dealloc
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	
    if (delegate)
	{
        [nc removeObserver:delegate name:nil object:self];	
	}
	
	[okButton release];
	[nameField release];
	[predicateNode release];
	[dataStore release];
	[predicateEditor release];
	[sheet dealloc];
	[super dealloc];
}

-(void)setDelegate:(id) d
{
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	
    if (delegate)
    {
		[nc removeObserver:delegate name:nil object:self];
	}
	
	delegate = d;
	
    if ([delegate respondsToSelector:@selector(predicateNodeWasCreated:)])
	{
        [nc addObserver:delegate selector:@selector(predicateNodeWasCreated:)
				   name:@"predicateNodeWasCreated" object:self];
	}
}

- (void)showSheet: (NSWindow *)window withPredicateNode:(Node *)node
{
	if(sheet == nil)
	{
		[NSBundle loadNibNamed:@"SearchSheet" owner: self];
		[self addTemplates];
	}
	
	self.predicateNode = node;
	
	if(node.data == nil)
	{
		//predicateNode = [[Node alloc] initWithLabel:@"Untitled"];
		//predicateNode.data = [NSCompoundPredicate
		//					  orPredicateWithSubpredicates:[NSArray arrayWithObjects:
		//													nil]];
		predicateEditor.objectValue = nil;
		[predicateEditor addRow:self];
	}
	else
	{
		//predicateNode = node;
		//NSLog(@"%@", (NSPredicate *)predicateNode.data);
		predicateEditor.objectValue = ((NSPredicate *)predicateNode.data);
	}
	
	nameField.stringValue = predicateNode.label;

	[self updateOKButton];
	
    [NSApp beginSheet: sheet
	   modalForWindow: window
		modalDelegate: self
	   didEndSelector: @selector(didEndSheet:returnCode:contextInfo:)
		  contextInfo: nil];
}

-(void)addTemplates
{

	RarityPredicateEditorRowTemplate *rarityTemplate = [[RarityPredicateEditorRowTemplate alloc] init];

	 ArrayPredicateEditorRowTemplate *typeTemplate = [[ArrayPredicateEditorRowTemplate alloc] 
															initWithArray:dataStore.types 
															forKeyPath:@"type"
													 ];
	
	ArrayPredicateEditorRowTemplate *seriesTemplate = [[ArrayPredicateEditorRowTemplate alloc] 
													 initWithArray:dataStore.series 
													 forKeyPath:@"series"
													   ];
	
	DamageTypePredicateEditorRowTemplate *damageTypesTemplate = 
								[[DamageTypePredicateEditorRowTemplate alloc] initWithArray:dataStore.damageTypes];
	
	ReputationRestrictionsEditorRowTemplate *reputationRestrictionsTemplate = 
											[[ReputationRestrictionsEditorRowTemplate alloc] 
											initWithArray:dataStore.reputationRestrictionTypes];
	
	NSMutableArray *templates = [NSMutableArray arrayWithObjects:seriesTemplate, typeTemplate, 
								 rarityTemplate, damageTypesTemplate, reputationRestrictionsTemplate,
								 nil];
	
	
	//release these since we alloced them
	for(id template in templates)
	{
		[template release];
	}
	
	[templates addObjectsFromArray:predicateEditor.rowTemplates];
	
	
	predicateEditor.rowTemplates = templates;
}

- (void)didEndSheet:(NSWindow *)s returnCode:(int)returnCode contextInfo:(void *)contextInfo
{
    [sheet orderOut:self];
}

-(IBAction)handleSaveButtonClick:(id)sender
{
	predicateNode.data = predicateEditor.objectValue;
	predicateNode.label = nameField.stringValue;
	[delegate predicateNodeWasCreated:predicateNode];
	
	[self closeSheet];
}

-(void) closeSheet
{	
	self.predicateNode = nil;
	[NSApp endSheet:sheet];
}

-(IBAction) handleCancelButton:(id)sender
{
	[self closeSheet];
}

-(void)updateOKButton
{
	BOOL enabled = TRUE;
	if(nameField.stringValue.length == 0)
	{
		enabled = FALSE;
	}
	
	if(predicateEditor.numberOfRows == 0)
	{
		enabled = FALSE;
	}
	
	[okButton setEnabled:enabled];
}

/*********** NSTextField Delegate APIs ***********/

- (void)controlTextDidChange:(NSNotification *)aNotification
{
	[self updateOKButton];
}

-(IBAction)onPredicateChange:(id)sender
{
	if ([predicateEditor numberOfRows] == 0)
	{
		[predicateEditor addRow:self];
	}
}

- (void)predicateNodeWasCreated:(Node *)prediateNode
{
	//NSLog(@"predicateNodeWasCreated");
}

@end
