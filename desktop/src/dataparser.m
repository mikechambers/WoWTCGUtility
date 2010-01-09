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

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

#import "WoWTCGDataParser.h"
#import "WoWTCGDataStore.h"
#import "NSString+CSVCategory.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	NSUserDefaults *args = [NSUserDefaults standardUserDefaults];
	
	NSString *inputPath = [args stringForKey:@"i"];
	NSString *outputPath = [args stringForKey:@"o"];
	
	if(inputPath == nil || outputPath == nil)
	{
		NSLog(@"dataparser -i INPUT_FILE -o OUTPUT_FILE");
		[pool drain];
		return 0;
	}
	
	NSError *error;
	
	NSString *data = [NSString stringWithContentsOfFile:inputPath
											   encoding:NSUTF8StringEncoding error:&error];
	
	WoWTCGDataParser *parser = [[WoWTCGDataParser alloc] init];
	
	[parser parseData:data];
	
	WoWTCGDataStore *dataStore = [[WoWTCGDataStore alloc] init];
	
	dataStore.cards = parser.cards;
	dataStore.types = parser.types;
	dataStore.series = parser.series;
	dataStore.damageTypes = parser.damageTypes;
	
	NSMutableDictionary *rootObject = [NSMutableDictionary dictionary];
    	
	[rootObject setValue:dataStore forKey:DATA_STORE_KEY];
	BOOL success = [NSKeyedArchiver archiveRootObject: [rootObject copy] toFile: [outputPath stringByExpandingTildeInPath]];
	
	if(!success)
	{
		NSLog(@"Could not write output file. Please check path.");
	}
	
    [pool drain];
    return 0;
}