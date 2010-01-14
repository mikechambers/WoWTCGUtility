//
//  TalentsEditorRowTemplate.m
//  WoWTCGUtility
//
//  Created by Mike Chambers on 1/13/10.
//  Copyright 2010 Mike Chambers. All rights reserved.
//

#import "TalentsEditorRowTemplate.h"


@implementation TalentsEditorRowTemplate

-(id)initWithArray:(NSArray *)arr
{
	if(![super initWithArray:arr forKeyPath:@"talent" 
					andTitle:@"Talent" 
			   withOperators:[NSArray arrayWithObject:[NSNumber numberWithInt: NSEqualToPredicateOperatorType]]])
	{
		return nil;
	}
	
	return self;
}

@end
