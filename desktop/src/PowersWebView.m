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
@synthesize paymentResultImageHTML;

-(void)dealloc
{
	[paymentResultImageHTML release];
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
	
	NSString *paymentResultPath = [[[NSBundle mainBundle] resourcePath] 
							  stringByAppendingPathComponent:@"/assets/payment_result.png"];
	NSURL *paymentResultURL = [NSURL fileURLWithPath: paymentResultPath isDirectory:FALSE];
	self.paymentResultImageHTML = [NSString stringWithFormat:@"<img src=\"%@\" />", paymentResultURL.absoluteString];	
	
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
	
	[replaceDict setObject:@"<b>Stealth</b>" forKey:@"Stealth" ];
	[replaceDict setObject:@"<b>Untargetable</b>" forKey:@"Untargetable" ];
	[replaceDict setObject:@"<b>Thrown</b>" forKey:@"Thrown" ];
	[replaceDict setObject:@"<b>Shadowmeld</b>" forKey:@"Shadowmeld" ];
	[replaceDict setObject:@"<b>Death Rattle</b>" forKey:@"Death Rattle" ];
	[replaceDict setObject:@"<b>Conspicuous</b>" forKey:@"Conspicuous" ];	
	
	[replaceDict setObject:@"<b>Long-Range</b>" forKey:@"Long-Range" ];
	[replaceDict setObject:@"<b>long-range</b>" forKey:@"long-range" ];
	[replaceDict setObject:@"<b>Reward</b>" forKey:@"Reward" ];
	[replaceDict setObject:@"<b>Trap</b>" forKey:@"Trap" ];
	[replaceDict setObject:@"<i>(" forKey:@"(" ];
	[replaceDict setObject:@")</i>" forKey:@")" ];
	[replaceDict setObject:activateImageHTML forKey:@"[Activate]" ];
	[replaceDict setObject:paymentResultImageHTML forKey:@">>>" ];
	
	
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
	//Death Rattle
	//Assault 5
	//Mend 5
	//Aldor Reputation
	//[Ranged]
	//[Alliance] [Horce] -- need to replace on Spectral Tiger, Nazgrel, x-51 nether rocket, Kurzon the false, Consul Rhys Lorgrand, Medallion
	//of the Alliance, Medallion of the Horde, Glacial Blade, Establishing New Outposts, Southshore, Rehgar Earthfury, Kelm Harguth, Whiteout Staff,
	//Next Stop, Menethil Harbor, Spectral Kitten, Force Command Death Trollbane, Famish the Binder, Blood Guard Gulmok, Electrified Dagger, Bolstering Our Defenses,
	//Tarren Mill, Talisman of the Horde, Illiyana Moonblaze, All Aboard for Undercity
	
	//[Nature]
	//stopped at March of the Legion
	//Shadow Resistance

	
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
