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

#import "Rarity.h"


@implementation Rarity

+(NSArray *)rarityNames
{
	NSArray *out = [NSArray arrayWithObjects:
						COMMON_DESCRIPTION,
					UNCOMMON_DESCRIPTION,
					RARE_DESCRIPTION,
					EPIC_DESCRIPTION,
					LEGENDARY_DESCRIPTION,
					nil
					];
	
	return out;
}

+(int) getRarityTypeForDescription:(NSString *)description
{
	if([description compare:COMMON_DESCRIPTION] == NSOrderedSame)
	{
		return COMMON;
	}
	else if([description compare:UNCOMMON_DESCRIPTION] == NSOrderedSame)
	{
		return UNCOMMON;
	}
	else if([description compare:RARE_DESCRIPTION] == NSOrderedSame)
	{
		return RARE;
	}
	else if([description compare:EPIC_DESCRIPTION] == NSOrderedSame)
	{
		return EPIC;
	}
	else if([description compare:LEGENDARY_DESCRIPTION] == NSOrderedSame)
	{
		return LEGENDARY;
	}
	else
	{
		return COMMON;
	}
}

+(int) getRarityTypeForAbbreviation:(NSString *)abbreviation
{
	if([abbreviation compare:COMMON_ABR] == NSOrderedSame)
	{
		return COMMON;
	}
	else if([abbreviation compare:UNCOMMON_ABR] == NSOrderedSame)
	{
		return UNCOMMON;
	}
	else if([abbreviation compare:RARE_ABR] == NSOrderedSame)
	{
		return RARE;
	}
	else if([abbreviation compare:EPIC_ABR] == NSOrderedSame)
	{
		return EPIC;
	}
	else if([abbreviation compare:LEGENDARY_ABR] == NSOrderedSame)
	{
		return LEGENDARY;
	}
	else
	{
		return COMMON;
	}
}

+(NSString *) getRarityAbbreviationForType:(int)type;
{
	switch (type)
	{
		case COMMON:
		{
			return COMMON_ABR;
		}
		case UNCOMMON:
		{
			return UNCOMMON_ABR;
		}
		case RARE:
		{
			return RARE_ABR;
		}
		case EPIC:
		{
			return EPIC_ABR;
		}
		case LEGENDARY:
		{
			return LEGENDARY_ABR;
		}
		default:
		{
			return COMMON_ABR;
		}
	}
}

+(NSString *) getRarityDescriptionForType:(int)type;
{
	switch (type)
	{
		case COMMON:
		{
			return COMMON_DESCRIPTION;
		}
		case UNCOMMON:
		{
			return UNCOMMON_DESCRIPTION;
		}
		case RARE:
		{
			return RARE_DESCRIPTION;
		}
		case EPIC:
		{
			return EPIC_DESCRIPTION;
		}
		case LEGENDARY:
		{
			return LEGENDARY_DESCRIPTION;
		}
		default:
		{
			return COMMON_DESCRIPTION;
		}
	}
}


@end
