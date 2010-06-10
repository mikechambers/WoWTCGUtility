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

#import "CardView.h"
#import "Rarity.h"
#import "CardURLScheme.h"


#define CARD_DECK_FORUMS_TAG 0
#define RULES_FORUMS_TAG 1
#define WOWTCGDB_TAG 2
#define TCGPLAYER_TAG 3

@implementation CardView

@synthesize card;
@synthesize image;
@synthesize powersView;
@synthesize nameField;
@synthesize seriesField;
@synthesize tabView;
@synthesize numberField;

@synthesize rarityField;
@synthesize typeField;
@synthesize classField;
@synthesize raceField;
@synthesize factionField;
@synthesize talentField;
@synthesize professionsField;
@synthesize costField;
@synthesize attackField;
@synthesize damageTypeField;
@synthesize healthField;
@synthesize defenseField;

-(void)dealloc
{
	[rarityField release];
	[typeField release];
	[classField release];
	[raceField release];
	[factionField release];
	[talentField release];
	[professionsField release];
	[costField release];
	[attackField release];
	[damageTypeField release];
	[healthField release];
	[defenseField release];
	[numberField release];
	[tabView release];
	[seriesField release];
	[nameField release];
	[image release];
	[card release];
	[powersView release];
	[super dealloc];
}

-(void)awakeFromNib
{	
	[image setEditable:TRUE];
	[image setAllowsCutCopyPaste:TRUE];
	image.enableClick = TRUE;
	
	[[nameField cell] setBackgroundStyle:NSBackgroundStyleRaised];
	
	if(!card)
	{
		image.card = nil;
	}
}

-(void)setCard:(Card *) c
{
	if(self->card == c)
	{
		return;
	}
	
	[self->card release];
	self->card = [c retain];
	
	if(c == nil)
	{
		[self clearAllFields];
		return;
	}
	
	image.card = card;
	
	[powersView setPowersText:c.rules];
	[nameField setStringValue:c.cardName];
	[seriesField setStringValue:c.series];
	[numberField setIntValue:c.cardNumber];
	
	[rarityField setStringValue: [Rarity getRarityDescriptionForType:c.rarity]];
	[typeField setStringValue: c.type];
	[classField setStringValue: c.className];
	[raceField setStringValue: c.race];
	[factionField setStringValue: c.faction];
	[talentField setStringValue: c.talent];
	[professionsField setStringValue: c.professions];
	[costField setIntValue: c.cost];
	[attackField setIntValue: c.attack];
	[damageTypeField setStringValue: c.damageType];
	[healthField setIntValue: c.health];
	[defenseField setIntValue: c.defense];	
}

-(void)clearAllFields
{
	NSString *empty = @"";
	[powersView setPowersText:empty];
	[nameField setStringValue:empty];
	[seriesField setStringValue:empty];
	[numberField setStringValue:empty];
	
	[rarityField setStringValue:empty];
	[typeField setStringValue:empty];
	[classField setStringValue:empty];
	[raceField setStringValue:empty];
	[factionField setStringValue:empty];
	[talentField setStringValue:empty];
	[professionsField setStringValue:empty];
	[costField setStringValue:empty];
	[attackField setStringValue:empty];
	[damageTypeField setStringValue:empty];
	[healthField setStringValue:empty];
	[defenseField setStringValue:empty];
	
	image.card = nil;
}

-(IBAction)handleInfoClick:(NSSegmentedControl *)sender;
{
	int index = [sender selectedSegment];
	[tabView selectTabViewItemAtIndex:index];
}

-(IBAction)handleResourceClick:(NSControl *)sender
{
	if(!card)
	{
		return;
	}
	
	int tag = sender.tag;
	
	NSString *urlFormat;
	NSString *dataValue;
	switch(tag)
	{
		case CARD_DECK_FORUMS_TAG:
		{
			urlFormat = @"http://entertainment.upperdeck.com/wow/community/search/SearchResults.aspx?s=129&q=";
			dataValue = card.cardName;
			break;
		}
		case RULES_FORUMS_TAG:
		{
			urlFormat = @"http://entertainment.upperdeck.com/wow/community/search/SearchResults.aspx?s=122&q=";
			dataValue = card.cardName;
			break;
		}
		case WOWTCGDB_TAG:
		{
			//urlFormat = @"http://www.wowtcgdb.com/search-results.aspx?x=";
			urlFormat = @"http://www.wowtcgdb.com/carddetail.aspx?id=";
			dataValue = card.urlID;
			break;
		}
		case TCGPLAYER_TAG:
		{
			urlFormat = @"http://wow.tcgplayer.com/db/world_of_warcraft_tcg_single_card.asp?cn=";
			dataValue = card.cardName;
			break;
		}
	}
	
	NSString *escapedName = [dataValue stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	NSString *urlString = [NSString stringWithFormat:@"%@%@", urlFormat, escapedName];
	
	[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:urlString]];
	
}

-(IBAction)handleCopyCardURLPathMenu:(id)sender
{
	if(card == nil)
	{
		return;
	}
	
	NSPasteboard *pb = [NSPasteboard generalPasteboard];
	[pb declareTypes:[NSArray arrayWithObjects:NSURLPboardType, NSStringPboardType, nil] owner:self];
	
	NSURL *data = [CardURLScheme createURLForCard:card];
	
	
	//write to board as both a URL and a String
	[data writeToPasteboard:pb];
	[pb setString:data.description forType:NSStringPboardType];
}

@end
