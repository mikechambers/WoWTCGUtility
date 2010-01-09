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
	NSString *cardName;
	NSString *series;
	int cardNumber;
	NSString *seriesAbbreviation;
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
	int quantity;
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
}

@property (retain) NSString *cardName;
@property (retain) NSString *series;
@property (assign) int cardNumber;
@property (retain) NSString *seriesAbbreviation;
@property (retain) NSString *type;		
@property (retain) NSString *className;
@property (retain) NSString *race;
@property (retain) NSString *professions;
@property (retain) NSString *talent;
@property (retain) NSString *faction;
@property (retain) NSString *keywords;
@property (assign) int rarity;
@property (assign) int cost;
@property (assign) int attack;
@property (assign) int defense;
@property (assign) int health;
@property (assign) int quantity;
@property (retain) NSString *rules;
@property (retain) NSString *urlID;
@property (retain) NSString *cardImageName;
@property (retain) NSString *seriesType;
@property (retain) NSString *allyFaction;
@property (retain) NSString *talentRestrictions;
@property (retain) NSString *raceRestrictions;
@property (retain) NSString *professionRestrictions;
@property (retain) NSString *damageType;
@property (retain) NSString *reputationRestrictions;
@property (assign) int strikeCost;
@property (retain) NSString *costModifier;
@end
