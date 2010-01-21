//
//  PDFViewPanel.m
//  WoWTCGUtility
//
//  Created by Mike Chambers on 1/21/10.
//  Copyright 2010 Mike Chambers. All rights reserved.
//

#import "PDFViewWindowController.h"


@implementation PDFViewWindowController

@synthesize pdfView;
@synthesize pdfPath;

-(void)dealloc
{
	[pdfPath release];
	[pdfView dealloc];
	[super dealloc];
}

-(id)initWithPath:(NSString *)path
{
	if(![super initWithWindowNibName:@"PDFViewWindow"])
	{
		return nil;
	}
	
	self.pdfPath = path;
	
	return self;
}

-(void)awakeFromNib
{
	if(!pdfPath)
	{
		return;
	}
	
	NSURL *pdfURL = [NSURL fileURLWithPath:pdfPath];
	
	PDFDocument *pdf = [[PDFDocument alloc] initWithURL:pdfURL];
	
	pdfView.document = pdf;
	
}

@end
