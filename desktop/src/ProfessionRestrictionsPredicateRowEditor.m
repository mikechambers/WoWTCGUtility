//
//  ProfessionRestrictionsPredicateRowEditor.m
//  WoWTCGUtility
//
//  Created by Mike Chambers on 1/18/10.
//  Copyright 2010 Mike Chambers. All rights reserved.
//

#import "ProfessionRestrictionsPredicateRowEditor.h"


@implementation ProfessionRestrictionsPredicateRowEditor

-(id)initWithArray:(NSArray *)arr
{
	if(![super initWithArray:arr forKeyPath:@"professionRestrictions" 
					andTitle:@"Profession Restrictions" 
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
