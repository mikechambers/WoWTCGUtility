//
//  NumberPredicateEditorRowTemplate.m
//  WoWTCGUtility
//
//  Created by Mike Chambers on 1/17/10.
//  Copyright 2010 Mike Chambers. All rights reserved.
//

#import "TemplatesModifierPredicateEditorRowTemplateBase.h"


@implementation TemplatesModifierPredicateEditorRowTemplateBase

@synthesize currentTemplateViews;

-(void)dealloc
{
	[currentTemplateViews release];
	[super dealloc];
}

- (id)copyWithZone:(NSZone *)zone
{
    return [self retain]; //we are immutable
}

@end
