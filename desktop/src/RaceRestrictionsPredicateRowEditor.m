//
//  RaceRestrictionsPredicateRowEditor.m
//  WoWTCGUtility
//
//  Created by Mike Chambers on 1/18/10.
//  Copyright 2010 Mike Chambers. All rights reserved.
//

#import "RaceRestrictionsPredicateRowEditor.h"


@implementation RaceRestrictionsPredicateRowEditor

-(id)initWithArray:(NSArray *)arr
{
	if(![super initWithArray:arr forKeyPath:@"raceRestrictions" 
					andTitle:@"Race Restrictions" 
			   withOperators:[NSArray arrayWithObjects:
							  [NSNumber numberWithInt: NSEqualToPredicateOperatorType],
							  [NSNumber numberWithInt: NSNotEqualToPredicateOperatorType],
							  [NSNumber numberWithInt: NSContainsPredicateOperatorType],
							  nil]])
	{
		return nil;
	}
	
	return self;
}

@end
