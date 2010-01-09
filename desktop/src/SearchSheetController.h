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
#import "Node.h"

@interface NSObject (SearchSheetControllerDelegate)

- (void)predicateNodeWasCreated:(Node *)predicateNode;

@end

@interface SearchSheetController : NSWindowController
{
	WoWTCGDataStore *dataStore;
	
	IBOutlet NSWindow *sheet;
	IBOutlet NSPredicateEditor *predicateEditor;
	IBOutlet NSTextField *nameField;
	IBOutlet NSButton *okButton;
	
	id delegate;
	
	Node *predicateNode;
}

@property (retain) WoWTCGDataStore *dataStore;

@property (retain) IBOutlet NSWindow *sheet;
@property (retain) IBOutlet NSPredicateEditor *predicateEditor;
@property (retain) IBOutlet NSTextField *nameField;
@property (retain) IBOutlet NSButton *okButton;
@property (retain) Node *predicateNode;

-(IBAction) handleCancelButton:(id)sender;

- (void)showSheet: (NSWindow *)window withPredicateNode:(Node *)node;
-(void) closeSheet;
-(void)addTemplates;
-(void)updateOKButton;
-(IBAction)onPredicateChange:(id)sender;

-(void)setDelegate:(id) d;

-(IBAction)handleSaveButtonClick:(id)sender;

@end
