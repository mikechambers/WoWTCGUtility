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

#import "WoWTCGDataParser.h"
#import "Card.h"
#import "Rarity.h"

#define CARD_ID_INDEX 0
#define SERIES_INDEX 1
#define CARD_NUMBER_INDEX 2
#define CARD_NAME_INDEX 3
#define TYPE_INDEX 4
#define CLASS_NAME_INDEX 5
#define RACE_INDEX 6
#define PROFESSIONS_INDEX 7
#define TALENT_INDEX 8
#define FACTION_INDEX 9
#define KEYWORDS_INDEX 10
#define RARITY_INDEX 11
#define COST_INDEX 12
#define COST_MODIFIER_INDEX 13
#define ATTACK_INDEX 14
#define STRIKE_COST_INDEX 15
#define DAMAGE_TYPE_INDEX 16
#define DEFENSE_INDEX 17
#define HEALTH_INDEX 18
#define RULES_INDEX 19
#define URL_INDEX 20
#define CARD_IMAGE_INDEX 21
#define SERIES_TYPE_INDEX 22
#define ALLY_FACTION_INDEX 23
#define TALENT_RESTRICTIONS_INDEX 24
#define RACE_RESTRICTIONS_INDEX 25
#define PROFESSION_RESTRICTIONS_INDEX 26
#define REPUTATION_RESTRICTIONS_INDEX 27


#define SERIES_COUNT 10
#define TYPES_COUNT 6

@implementation WoWTCGDataParser

@synthesize dataStore;
@synthesize classesByNames;
@synthesize classesByAbbreviations;
@synthesize allClassNames;

-(void)dealloc
{
	[dataStore release];
	[allClassNames dealloc];
	[classesByNames dealloc];
	[classesByAbbreviations dealloc];
	[super dealloc];
}


-(id)init
{
	if(![super init])
	{
		return nil;
	}
	
	NSArray *classNames = [NSArray arrayWithObjects:
					  @"Death Knight",
					  @"Demon",
					  @"Druid",
					  @"Hunter",
					  @"Mage",
					  @"Paladin",
					  @"Priest",
					  @"Rogue",
					  @"Shaman",
					  @"Warlock", 
					  @"Warrior",nil];
	
	NSArray *classAbbreviations = [NSArray arrayWithObjects:
							  @"Dk",
							  @"De",
							  @"Dr",
							  @"Hu",
							  @"Mg",
							  @"Pa",
							  @"Pr",
							  @"Ro",
							  @"Sh",
							  @"Wk",
							  @"Wr", nil];
	
	self.classesByAbbreviations = [NSDictionary dictionaryWithObjects: classNames			
															  forKeys: classAbbreviations
								   ];
	
	self.classesByNames = [NSDictionary dictionaryWithObjects: classAbbreviations			
													  forKeys: classNames
						   ];	
	
	self.allClassNames = [classNames componentsJoinedByString:@","];
	
	return self;
}

-(NSString *) parseCardName:(NSString *)data
{
	data = [data stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
	if([data compare:@"Any"] == NSOrderedSame)
	{
		return allClassNames;
	}
	
	NSString *k = [classesByNames objectForKey:data];
	
	if(k != nil)
	{
		return data;
	}
	
	int len = [data length];
	
	NSMutableArray *out = [NSMutableArray arrayWithCapacity:2];
	NSString *token;
	NSString *t2;
	//NSRange *range;
	for(int i = 0; i < len; i +=2)
	{
		token = [data substringWithRange:NSMakeRange(i, 2)];
		
		t2 = [classesByAbbreviations objectForKey:token];		 
		
		if(!t2)
		{
			NSLog(@"Unrecognized token name : %@ : --%@--", token, data);
			continue;
		}
		
		[out addObject:t2];
	}
	
	return [out componentsJoinedByString:@","];
}

-(void)parseData:(NSString *)csvData
{

	self.dataStore = [[WoWTCGDataStore alloc] init];
	[self.dataStore release];
	
	
	NSArray *data = [csvData csvRows];
	
	int len = [data count];
	NSMutableArray *out = [NSMutableArray arrayWithCapacity:len];
	
	Card *c;
	
	NSArray *row;
	
	NSMutableDictionary *seriesKey = [NSMutableDictionary dictionaryWithCapacity:SERIES_COUNT];
	NSMutableDictionary *typesKey = [NSMutableDictionary dictionaryWithCapacity:TYPES_COUNT];
	NSMutableDictionary *damageTypesKey = [NSMutableDictionary dictionaryWithCapacity:0];
	NSMutableDictionary *reputationRestrictionTypesKey = [NSMutableDictionary dictionaryWithCapacity:3];
	NSMutableDictionary *racesKey = [NSMutableDictionary dictionaryWithCapacity:2];
	
	NSString *placeHolder = @"";
	
	for(int i = 1; i < len; i++)
	{
		row = [data objectAtIndex:i];
		c = [[Card alloc] init];
		
		c.cardName = [row objectAtIndex:CARD_NAME_INDEX];
		
		//todo: need to remove strings
		c.series = [row objectAtIndex:SERIES_INDEX];
		[seriesKey setValue:placeHolder forKey:c.series];
		
		
		c.cardId = [[row objectAtIndex:CARD_ID_INDEX] intValue];
		c.cardNumber = [[row objectAtIndex:CARD_NUMBER_INDEX] intValue];
		c.type = [row objectAtIndex:TYPE_INDEX];
		[typesKey setValue:placeHolder forKey:c.type];
		
		
		//c.className = [row objectAtIndex:CLASS_NAME_INDEX];
		c.className = [self parseCardName:[row objectAtIndex:CLASS_NAME_INDEX]];
		
		c.race = [row objectAtIndex:RACE_INDEX];
		
		[racesKey setValue:placeHolder forKey:c.race];
		
		c.professions = [row objectAtIndex:PROFESSIONS_INDEX];
		c.talent = [row objectAtIndex:TALENT_INDEX];
		c.faction = [row objectAtIndex:FACTION_INDEX];
		c.keywords = [row objectAtIndex:KEYWORDS_INDEX];
		
		c.rarity = [Rarity getRarityTypeForAbbreviation:[row objectAtIndex:RARITY_INDEX]];
		
		c.cost = [[row objectAtIndex:COST_INDEX] intValue];
		c.attack = [[row objectAtIndex:ATTACK_INDEX] intValue];
		c.damageType = [row objectAtIndex:DAMAGE_TYPE_INDEX];
		
		NSArray *dtArr = [c.damageType componentsSeparatedByString:@", "];
		
		for(NSString *dt in dtArr)
		{
			if([c.damageType compare:@""] == NSOrderedSame)
			{
				continue;
			}
			[damageTypesKey setValue:placeHolder forKey:dt];
		}
		
		c.defense = [[row objectAtIndex:DEFENSE_INDEX] intValue];
		c.health = [[row objectAtIndex:HEALTH_INDEX] intValue];
		c.rules = [row objectAtIndex:RULES_INDEX];
		c.urlID = [row objectAtIndex:URL_INDEX];
		c.cardImageName = [row objectAtIndex:CARD_IMAGE_INDEX];
		
		c.seriesType = [row objectAtIndex:SERIES_TYPE_INDEX];
		c.allyFaction = [row objectAtIndex:ALLY_FACTION_INDEX];
		c.talentRestrictions = [row objectAtIndex:TALENT_RESTRICTIONS_INDEX];
		c.raceRestrictions = [row objectAtIndex:RACE_RESTRICTIONS_INDEX];
		c.professionRestrictions = [row objectAtIndex:PROFESSION_RESTRICTIONS_INDEX];
		

		c.reputationRestrictions = [row objectAtIndex:REPUTATION_RESTRICTIONS_INDEX];

		[reputationRestrictionTypesKey setValue:placeHolder forKey:c.reputationRestrictions];
		
		c.strikeCost = [[row objectAtIndex:STRIKE_COST_INDEX] intValue];

		c.costModifier = [row objectAtIndex:COST_MODIFIER_INDEX];
		
		[out addObject:c];
		
		[c release];
	}
	
	/******** tempSeries ********/
	NSMutableArray *tempSeries = [[seriesKey allKeys] mutableCopy];
	[tempSeries sortUsingSelector:@selector(caseInsensitiveCompare:)];
	dataStore.series = tempSeries;
	
	/******** types ********/
	NSMutableArray *tempTypes = [[typesKey allKeys] mutableCopy];
	[tempTypes sortUsingSelector:@selector(caseInsensitiveCompare:)];
	dataStore.types = tempTypes;	
	
	/******** damageType ********/
	NSMutableArray *tempDamageTypes = [[damageTypesKey allKeys] mutableCopy];
	[tempDamageTypes sortUsingSelector:@selector(caseInsensitiveCompare:)];
	dataStore.damageTypes = tempDamageTypes;	
	
	/******** reputationRestrictionTypes ********/
	NSMutableArray *reputationRestrictionTypes = [[reputationRestrictionTypesKey allKeys] mutableCopy];
	[reputationRestrictionTypes sortUsingSelector:@selector(caseInsensitiveCompare:)];
	
	if([self stringIsEmpty:[reputationRestrictionTypes objectAtIndex:0]])
	{
		[reputationRestrictionTypes removeObjectAtIndex:0];
	}	
	
	dataStore.reputationRestrictionTypes = reputationRestrictionTypes;
	
	/******** races ********/
	NSMutableArray *races = [[racesKey allKeys] mutableCopy];
	
	[races sortUsingSelector:@selector(caseInsensitiveCompare:)];
	if([self stringIsEmpty:[races objectAtIndex:0]])
	{
		[races removeObjectAtIndex:0];
	}
	
	dataStore.races = races;
									
	dataStore.cards = out;
}

//make this a category on NSString
-(BOOL)stringIsEmpty:(NSString *)value
{
	if(!value)
	{
		return TRUE;
	}
	
	if([[value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] compare:@""] == NSOrderedSame)
	{
		return TRUE;
	}
	
	return FALSE;
}

@end
