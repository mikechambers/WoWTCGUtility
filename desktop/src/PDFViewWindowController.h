//
//  PDFViewPanel.h
//  WoWTCGUtility
//
//  Created by Mike Chambers on 1/21/10.
//  Copyright 2010 Mike Chambers. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>


@interface PDFViewWindowController : NSWindowController
{
	IBOutlet PDFView *pdfView;
	NSString *pdfPath;
}

@property (retain) IBOutlet PDFView *pdfView;
@property (retain) IBOutlet NSString *pdfPath;

-(id)initWithPath:(NSString *)path;

@end
