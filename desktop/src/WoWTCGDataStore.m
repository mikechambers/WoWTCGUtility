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

#import "WoWTCGDataStore.h"


@implementation WoWTCGDataStore

@synthesize cards;
@synthesize series;
@synthesize types;
@synthesize damageTypes;
@synthesize reputationRestrictionTypes;
@synthesize races;
@synthesize talents;
@synthesize professions;

-(void)dealloc
{
	[professions release];
	[talents release];
	[races release];
	[reputationRestrictionTypes release];
	[damageTypes release];
	[types release];
	[cards release];
	[series release];
	[super dealloc];
}

- (id) initWithCoder: (NSCoder *)coder
{
	if (![super init])
	{
		return nil;
	}
	
	self.types = [coder decodeObjectForKey:@"types"];
	self.cards = [coder decodeObjectForKey:@"cards"];
	self.series = [coder decodeObjectForKey:@"series"];
	self.damageTypes = [coder decodeObjectForKey:@"damageTypes"];
	self.reputationRestrictionTypes = [coder decodeObjectForKey:@"reputationRestrictionTypes"];
	self.races = [coder decodeObjectForKey:@"races"];
	self.talents = [coder decodeObjectForKey:@"talents"];
	self.professions = [coder decodeObjectForKey:@"professions"];
	
	return self;
}

- (void) encodeWithCoder: (NSCoder *)coder
{
	[coder encodeObject: types forKey:@"types"];
	[coder encodeObject: cards forKey:@"cards"];
	[coder encodeObject: series forKey:@"series"];
	[coder encodeObject: damageTypes forKey:@"damageTypes"];
	[coder encodeObject: reputationRestrictionTypes forKey:@"reputationRestrictionTypes"];
	[coder encodeObject: races forKey:@"races"];
	[coder encodeObject: talents forKey:@"talents"];
	[coder encodeObject: professions forKey:@"professions"];
}

@end
