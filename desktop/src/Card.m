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

#import "Card.h"


@implementation Card

@synthesize cardId;
@synthesize cardName;
@synthesize series;
@synthesize cardNumber;
@synthesize type;		
@synthesize className;
@synthesize race;
@synthesize professions;
@synthesize talent;
@synthesize faction;
@synthesize keywords;
@synthesize rarity;
@synthesize cost;
@synthesize attack;
@synthesize defense;
@synthesize health;
@synthesize rules;
@synthesize urlID;
@synthesize cardImageName;
@synthesize seriesType;
@synthesize allyFaction;
@synthesize talentRestrictions;
@synthesize raceRestrictions;
@synthesize professionRestrictions;
@synthesize damageType;
@synthesize reputationRestrictions;
@synthesize strikeCost;
@synthesize costModifier;

-(void)dealloc
{
	[costModifier release];
	[reputationRestrictions release];
	[damageType release];
	[cardName release];
	[series release];
	[type release];
	[className release];
	[race release];
	[professions release];
	[talent release];
	[faction release];
	[keywords release];
	[rules release];
	[urlID release];
	[cardImageName release];
	[seriesType release];
	[allyFaction release];
	[talentRestrictions release];
	[raceRestrictions release];
	[professionRestrictions release];
	[super dealloc];
}

- (id) initWithCoder: (NSCoder *)coder
{
	if (![super init])
	{
		return nil;
	}
	
	self.cardId = [coder decodeIntForKey:@"cardId"];
	self.cardName = [coder decodeObjectForKey:@"cardName"];
	self.series = [coder decodeObjectForKey:@"series"];
	self.cardNumber = [coder decodeIntForKey:@"cardNumber"];
	self.type = [coder decodeObjectForKey:@"type"];
	self.className = [coder decodeObjectForKey:@"className"];
	self.race = [coder decodeObjectForKey:@"race"];
	self.professions = [coder decodeObjectForKey:@"professions"];
	self.talent = [coder decodeObjectForKey:@"talent"];
	self.faction = [coder decodeObjectForKey:@"faction"];
	self.keywords = [coder decodeObjectForKey:@"keywords"];
	self.rarity = [coder decodeIntForKey:@"rarity"];
	self.cost = [coder decodeIntForKey:@"cost"];
	self.attack = [coder decodeIntForKey:@"attack"];
	self.damageType = [coder decodeObjectForKey:@"damageType"];
	self.defense = [coder decodeIntForKey:@"defense"];
	self.health = [coder decodeIntForKey:@"health"];
	self.rules = [coder decodeObjectForKey:@"rules"];
	self.urlID = [coder decodeObjectForKey:@"urlID"];
	self.cardImageName = [coder decodeObjectForKey:@"cardImageName"];
	self.seriesType = [coder decodeObjectForKey:@"seriesType"];
	self.allyFaction = [coder decodeObjectForKey:@"allyFaction"];
	self.talentRestrictions = [coder decodeObjectForKey:@"talentRestrictions"];
	self.raceRestrictions = [coder decodeObjectForKey:@"raceRestrictions"];
	self.professionRestrictions = [coder decodeObjectForKey:@"professionRestrictions"];
	self.damageType = [coder decodeObjectForKey:@"damageType"];
	self.reputationRestrictions = [coder decodeObjectForKey:@"reputationRestrictions"];
	self.strikeCost = [coder decodeIntForKey:@"strikeCost"];	
	self.costModifier = [coder decodeObjectForKey:@"costModifier"];	
	
	return self;
}

- (void) encodeWithCoder: (NSCoder *)coder
{
	[coder encodeInt:cardId forKey:@"cardId"];
	[coder encodeObject: cardName forKey:@"cardName"];
	[coder encodeObject: series forKey:@"series"];
	[coder encodeInt: cardNumber forKey:@"cardNumber"];
	[coder encodeObject: type forKey:@"type"];
	[coder encodeObject: className forKey:@"className"];
	[coder encodeObject: race forKey:@"race"];
	[coder encodeObject: professions forKey:@"professions"];
	[coder encodeObject: talent forKey:@"talent"];
	[coder encodeObject: faction forKey:@"faction"];
	[coder encodeObject: keywords forKey:@"keywords"];
	[coder encodeInt: rarity forKey:@"rarity"];
	[coder encodeInt: cost forKey:@"cost"];
	[coder encodeInt: attack forKey:@"attack"];
	[coder encodeObject: damageType forKey:@"damageType"];
	[coder encodeInt: defense forKey:@"defense"];
	[coder encodeInt: health forKey:@"health"];
	[coder encodeObject: rules forKey:@"rules"];
	[coder encodeObject: urlID forKey:@"urlID"];
	[coder encodeObject: cardImageName forKey:@"cardImageName"];
	[coder encodeObject: seriesType forKey:@"seriesType"];
	[coder encodeObject: allyFaction forKey:@"allyFaction"];
	[coder encodeObject: talentRestrictions forKey:@"talentRestrictions"];
	[coder encodeObject: raceRestrictions forKey:@"raceRestrictions"];
	[coder encodeObject: professionRestrictions forKey:@"professionRestrictions"];
	[coder encodeObject: reputationRestrictions forKey:@"reputationRestrictions"];
	[coder encodeInt: strikeCost forKey:@"strikeCost"];	
	[coder encodeObject: costModifier forKey:@"costModifier"];	
	
}

@end