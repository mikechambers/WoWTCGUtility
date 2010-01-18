//
//  PowersWebView.m
//  WoWTCGUtility
//
//  Created by Mike Chambers on 1/18/10.
//  Copyright 2010 Mike Chambers. All rights reserved.
//

#import "PowersWebView.h"


@implementation PowersWebView

@synthesize webView;
@synthesize tempData;
@synthesize activateImageHTML;

-(void)dealloc
{
	[activateImageHTML release];
	[tempData release];
	[webView release];
	[super dealloc];
}

-(void)awakeFromNib
{	
	//undocumented API
	//http://lists.apple.com/archives/webkitsdk-dev/2005/Apr/msg00065.html
	[self setDrawsBackground:FALSE];
	
	[self setFrameLoadDelegate:self];
	
	NSString *activatePath = [[[NSBundle mainBundle] resourcePath] 
							  stringByAppendingPathComponent:@"/assets/activate.png"];
	NSURL *activateURL = [NSURL fileURLWithPath: activatePath isDirectory:FALSE];
	self.activateImageHTML = [NSString stringWithFormat:@"<img src=\"%@\" alt=\"[Activate]\" />", activateURL.absoluteString];
	
	
	
	NSString *path = [[[NSBundle mainBundle] resourcePath] 
					   stringByAppendingPathComponent:@"/powers_template.html"];
	
	
	NSURL *url = [NSURL fileURLWithPath: path isDirectory:FALSE];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	
	[[self mainFrame] loadRequest:request];	
}

-(void)setPowersText:(NSString *)data
{
	if(!hasLoaded)
	{
		self.tempData = data;
		return;
	}

	
	[self renderPowerText:data];
}

-(void)renderPowerText:(NSString *)data
{
	DOMHTMLElement *contentElement = (DOMHTMLElement *)[[[self mainFrame] DOMDocument] getElementById:@"contentElement"];
	
	NSLog(@"%@", [self formatPower:data]);
	
	[contentElement setInnerHTML: [self formatPower:data]];	
}

-(NSString *)formatPower:(NSString *)data
{
	NSString *out = [data mutableCopy];

	NSMutableDictionary *replaceDict = [NSMutableDictionary dictionaryWithCapacity:10];
	[replaceDict setObject:@"</p><p>" forKey:@"\n" ];
	[replaceDict setObject:@"<b>Ongoing</b>" forKey:@"Ongoing" ];
	[replaceDict setObject:@"<b>Protector</b>" forKey:@"Protector" ];
	[replaceDict setObject:@"<b>Ferocity</b>" forKey:@"Ferocity" ];
	[replaceDict setObject:@"<b>Elusive</b>" forKey:@"Elusive" ];
	[replaceDict setObject:@"<b>Totem</b>" forKey:@"Totem" ];
	[replaceDict setObject:@"<b>Long-Range</b>" forKey:@"Long-Range" ];
	[replaceDict setObject:@"<i>(" forKey:@"(" ];
	[replaceDict setObject:@")</i>" forKey:@")" ];
	[replaceDict setObject:activateImageHTML forKey:@"[Activate]" ];
	[replaceDict setObject:@"" forKey:@"" ];
	[replaceDict setObject:@"" forKey:@"" ];
	[replaceDict setObject:@"" forKey:@"" ];
	[replaceDict setObject:@"" forKey:@"" ];
	[replaceDict setObject:@"" forKey:@"" ];
	
	
	//[string stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]]

	for(NSString *key in replaceDict)
	{
		out = [out stringByReplacingOccurrencesOfString:key withString:[replaceDict objectForKey:key]];
	}
	
	
	out = [NSString stringWithFormat:@"<p>%@</p>", out];
	
	
	//Marksmanship Hero Required <-- needs to be bold.
	//pay|s
	//pay
	//horde / alliance tokens
	//Long-Range
	//Death Rattle
	//Assault 5
	//Aldor Reputation
	
	return out;	
}
						  

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame
{
	NSLog(@"didFinishLoadForFrame");
	if(tempData)
	{
		[self renderPowerText:tempData];
		self.tempData == nil;
		[self setFrameLoadDelegate:nil];
	}
	
	hasLoaded = TRUE;
}

@end
