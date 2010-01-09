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

#import "HyperlinkNSTextField.h"


@implementation HyperlinkNSTextField


@synthesize thumbCursor;
@synthesize underlined;
@synthesize notUnderlined;

-(void)dealloc
{
	[notUnderlined release];
	[underlined release];
	[thumbCursor release];
	[super dealloc];
}

//string
-(void)awakeFromNib
{
	[self setAction:@selector(handleResourceClick:)];
	
	NSTrackingArea *trackingArea = [[NSTrackingArea alloc] initWithRect:[self bounds]
																options: (NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveInKeyWindow)
																  owner:self userInfo:nil];
	[self addTrackingArea:trackingArea];	
	
	[trackingArea release];
	
	NSString *value = [self stringValue];

	self.underlined = [[NSMutableAttributedString alloc] initWithString: value];
    NSRange range = NSMakeRange(0, [underlined length]);
	[underlined addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSSingleUnderlineStyle] range:range];
	
	[super.cell setAttributedStringValue:underlined];
	
	self.thumbCursor = [NSCursor pointingHandCursor];
}

- (void)resetCursorRects
{
	[self addCursorRect:[self bounds] cursor:thumbCursor];
}

- (void)mouseEntered:(NSEvent *)event
{		
	if(!notUnderlined)
	{
		NSString *value = [self stringValue];

		self.notUnderlined = [[NSMutableAttributedString alloc] initWithString: value];
		NSRange range = NSMakeRange(0, [notUnderlined length]);
		
		[notUnderlined addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSNoUnderlineStyle] range:range];
	}	
	
	[super.cell setAttributedStringValue:notUnderlined];
	
	[super mouseEntered:event];
}

- (void)mouseExited:(NSEvent *)event
{
	[super.cell setAttributedStringValue:underlined];	
	
	[super mouseExited:event];
}

- (void)mouseDown:(NSEvent *)event
{
	[[self target] performSelector:[self action] withObject:self];
}


@end
