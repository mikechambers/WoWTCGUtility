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
#import "Card.h"
#import "CardImageView.h"
#import "PowersWebView.h"

@interface CardView : NSView
{
	IBOutlet CardImageView *image;
	IBOutlet PowersWebView *powersView;
	IBOutlet NSTextField *nameField;
	IBOutlet NSTextField *seriesField;
	IBOutlet NSTextField *numberField;
	IBOutlet NSTabView *tabView;
	
	IBOutlet NSTextField *rarityField;
	IBOutlet NSTextField *typeField;
	IBOutlet NSTextField *classField;
	IBOutlet NSTextField *raceField;
	IBOutlet NSTextField *factionField;
	IBOutlet NSTextField *talentField;
	IBOutlet NSTextField *professionsField;
	IBOutlet NSTextField *costField;
	IBOutlet NSTextField *attackField;
	IBOutlet NSTextField *damageTypeField;
	IBOutlet NSTextField *healthField;
	IBOutlet NSTextField *defenseField;
	
	Card *card;
}

@property (retain) Card *card;

@property (retain) IBOutlet CardImageView *image;
@property (retain) IBOutlet PowersWebView *powersView;
@property (retain) IBOutlet NSTextField *nameField;
@property (retain) IBOutlet NSTextField *seriesField;
@property (retain) IBOutlet NSTextField *numberField;
@property (retain) IBOutlet NSTabView *tabView;

@property (retain) IBOutlet NSTextField *rarityField;
@property (retain) IBOutlet NSTextField *typeField;
@property (retain) IBOutlet NSTextField *classField;
@property (retain) IBOutlet NSTextField *raceField;
@property (retain) IBOutlet NSTextField *factionField;
@property (retain) IBOutlet NSTextField *talentField;
@property (retain) IBOutlet NSTextField *professionsField;
@property (retain) IBOutlet NSTextField *costField;
@property (retain) IBOutlet NSTextField *attackField;
@property (retain) IBOutlet NSTextField *damageTypeField;
@property (retain) IBOutlet NSTextField *healthField;
@property (retain) IBOutlet NSTextField *defenseField;

-(void)setCard:(Card *) c;
-(void)clearAllFields;


-(IBAction)handleInfoClick:(NSSegmentedControl *)sender;
-(IBAction)handleResourceClick:(id)sender;
-(IBAction)handleCopyCardURLPathMenu:(id)sender;

@end
