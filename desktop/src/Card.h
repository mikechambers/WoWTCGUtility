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

@interface Card : NSObject <NSCoding>
{
	int cardId;
	NSString *cardName;
	NSString *series;
	int cardNumber;
	NSString *type;		
	NSString *className;
	NSString *race;
	NSString *professions;
	NSString *talent;
	NSString *faction;
	NSString *keywords;
	int rarity;
	int cost;
	int attack;
	int defense;
	int health;
	NSString *rules;
	NSString *urlID;
	NSString *cardImageName;
	NSString *seriesType;
	NSString *allyFaction;
	NSString *talentRestrictions;
	NSString *raceRestrictions;
	NSString *professionRestrictions;
	NSString *damageType;
	NSString *reputationRestrictions;
	int strikeCost;
	NSString *costModifier;
	NSString *format;
	NSString *block;
}

/* unique numeric id for the card */
@property (assign) int cardId;

/* Card Name*/
@property (retain) NSString *cardName;

/* The series / set that the card is included in */
@property (retain) NSString *series;

/* Card Number within the series*/
@property (assign) int cardNumber;

/* The Card type, such as Item, Hero, Ally, etc... */
@property (retain) NSString *type;

/* The Class type, if any of the card */
@property (retain) NSString *className;

/* The race, if any of the card */
@property (retain) NSString *race;

/* Card profession type, if any */
@property (retain) NSString *professions;

/* Card talents, if any */
@property (retain) NSString *talent;

/* Card faction, such as Horde, Allies, Neutral */
@property (retain) NSString *faction;

/* Data from the tags field (under the image) on the card */
@property (retain) NSString *keywords;

/* Rarity of the card */
@property (assign) int rarity;

/* Cost to play the card */
@property (assign) int cost;

/* Any cost modifiers, applies to the cost, such as +x */
@property (retain) NSString *costModifier;

/* Cost of striking with weapon */
@property (assign) int strikeCost;

/* Attack value, if any, of card */
@property (assign) int attack;

/* Type of attack (Melee, Fire, etc...), if any, the card does.*/
@property (retain) NSString *damageType;

/* Defense value, if any, of card */
@property (assign) int defense;

/* Health, if any, of card */
@property (assign) int health;

/* Rules / text field of card */
@property (retain) NSString *rules;

/* ID That reference the card in the online wowtcgdb.com database */
@property (retain) NSString *urlID;

/* Name of image associated with the card */
@property (retain) NSString *cardImageName;

/* Type of series that the card belongs to, such as Core, Raid, etc... */
@property (retain) NSString *seriesType;

/* The ally faction, if any, of the card */
@property (retain) NSString *allyFaction;

/* Talent restrictions required by the card, if any */
@property (retain) NSString *talentRestrictions;

/* Race restrictions required by the card, if any */
@property (retain) NSString *raceRestrictions;

/* Professiona restrictions required by the card, if any */
@property (retain) NSString *professionRestrictions;

/* Reputation restrictions required by the card, if any */
@property (retain) NSString *reputationRestrictions;


/* Format (Core and / or Classic) that the card is included in */
@property (retain) NSString *format;

/* Card set block that the card is associated with */
@property (retain) NSString *block;


@end
