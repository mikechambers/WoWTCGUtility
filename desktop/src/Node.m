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

#import "Node.h"

@implementation Node

@synthesize label;
@synthesize children;
@synthesize data;

-(id)initWithLabel:(NSString *)value
{
	if(![super init])
	{
		return nil;
	}
	
	self.label = value;
	
	return self;
}

-(void)dealloc
{
	[data release];
	[children release];
	[label release];
	[super dealloc];
}

- (NSString *)description
{
	return [self label];
}

- (id) initWithCoder: (NSCoder *)coder
{
	if (![super init])
	{
		return nil;
	}
	
	self.label = [coder decodeObjectForKey:@"label"];
	self.children = [coder decodeObjectForKey:@"children"];
	self.data = [coder decodeObjectForKey:@"data"];
	
	return self;
}

- (void) encodeWithCoder: (NSCoder *)coder
{
	[coder encodeObject: label forKey:@"label"];
	[coder encodeObject: children forKey:@"children"];
	[coder encodeObject: data forKey:@"data"];
}

@end
