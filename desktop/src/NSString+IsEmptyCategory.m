//
//  NSString+IsEmptyCategory.m
//  WoWTCGUtility
//
//  Created by Mike Chambers on 1/12/10.
//  Copyright 2010 Mike Chambers. All rights reserved.
//

#import "NSString+IsEmptyCategory.h"


@implementation NSString (IsEmptyExtensions)

-(BOOL)stringIsEmpty
{	
	if([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] 
																		compare:@""] == NSOrderedSame)
	{
		return TRUE;
	}
	
	return FALSE;
}

@end
