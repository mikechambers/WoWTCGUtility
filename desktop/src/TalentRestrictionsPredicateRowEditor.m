//
//  TalentRestrictionsPredicateRowEditor.m
//  WoWTCGUtility
//
//  Created by Mike Chambers on 1/18/10.
//  Copyright 2010 Mike Chambers. All rights reserved.
//

#import "TalentRestrictionsPredicateRowEditor.h"


@implementation TalentRestrictionsPredicateRowEditor

-(id)initWithArray:(NSArray *)arr
{
	if(![super initWithArray:arr forKeyPath:@"talentRestrictions" 
					andTitle:@"Talent Restrictions" 
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
