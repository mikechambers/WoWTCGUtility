//
//  NumberPredicateEditorRowTemplate.h
//  WoWTCGUtility
//
//  Created by Mike Chambers on 1/17/10.
//  Copyright 2010 Mike Chambers. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface TemplatesModifierPredicateEditorRowTemplateBase : NSPredicateEditorRowTemplate
{
	NSArray *currentTemplateViews;
}

@property (retain) NSArray *currentTemplateViews;

@end
