//
//  PowersWebView.m
//  WoWTCGUtility
//
//  Created by Mike Chambers on 1/18/10.
//  Copyright 2010 Mike Chambers. All rights reserved.
//

#import "PowersWebView.h"
#import "GTMRegex.h"

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
	[replaceDict setObject:@"<b>Inspire</b>" forKey:@"Inspire" ];
	[replaceDict setObject:@"<b>Sabotage</b>" forKey:@"Sabotage" ];	
	
	[replaceDict setObject:@"<b>Long-Range</b>" forKey:@"Long-Range" ];
	[replaceDict setObject:@"<b>Reward</b>" forKey:@"Reward" ];
	[replaceDict setObject:@"<b>Trap</b>" forKey:@"Trap" ];
	[replaceDict setObject:@"<i>(" forKey:@"(" ];
	[replaceDict setObject:@")</i>" forKey:@")" ];
	[replaceDict setObject:activateImageHTML forKey:@"[Activate]" ];
	[replaceDict setObject:paymentResultImageHTML forKey:@">>>" ];

	for(NSString *key in replaceDict)
	{
		out = [out stringByReplacingOccurrencesOfString:key withString:[replaceDict objectForKey:key]];
	}

	out = [NSString stringWithFormat:@"<p>%@</p>", out];
	
	GTMRegex *mendRegex = [GTMRegex regexWithPattern:@"(Mend [0-9]|Mend [0-9][0-9])" options:kGTMRegexOptionSupressNewlineSupport];
	out = [mendRegex stringByReplacingMatchesInString:out withReplacement:@"<b>\\1</b>"];

	GTMRegex *paysRegex = [GTMRegex regexWithPattern:@"(Pay[s]? )([0-9]|[x])|(Pay[s]? )([0-9][0-9]))" options:kGTMRegexOptionSupressNewlineSupport|kGTMRegexOptionIgnoreCase];
	out = [paysRegex stringByReplacingMatchesInString:out withReplacement:@"\\1<span class='payCircle'>&nbsp;<b>\\2</b>&nbsp;</span>"];	
	
	GTMRegex *assaultRegex = [GTMRegex regexWithPattern:@"(Assault [0-9]|Assault [0-9][0-9])" options:kGTMRegexOptionSupressNewlineSupport];
	out = [assaultRegex stringByReplacingMatchesInString:out withReplacement:@"<b>\\1</b>"];	
	

	GTMRegex *requiredHeroRegex = [GTMRegex regexWithPattern:@"([[:<:]][A-Z][a-z]*[[:>:]] [[:<:]][A-Z][a-z]*[[:>:]]|[[:<:]][A-Z][a-z]*[[:>:]])( Hero Required)"];
	out = [requiredHeroRegex stringByReplacingMatchesInString:out withReplacement:@"<b>\\1\\2</b>"];		

	GTMRegex *resistanceRegex = [GTMRegex regexWithPattern:@"([[:<:]][A-Z][a-z]*[[:>:]])( Resistance)" options:kGTMRegexOptionSupressNewlineSupport];
	out = [resistanceRegex stringByReplacingMatchesInString:out withReplacement:@"<b>\\1\\2</b>"];
	
	GTMRegex *reputationRegex = [GTMRegex regexWithPattern:@"([[:<:]][A-Z][a-z]*[[:>:]])( Reputation)" options:kGTMRegexOptionSupressNewlineSupport];
	out = [reputationRegex stringByReplacingMatchesInString:out withReplacement:@"<b>\\1\\2</b>"];
	
	NSLog(@"%@", out);
	
	//horde / alliance tokens
	//[Ranged]
	//[Alliance] [Horce] -- need to replace on Spectral Tiger, Nazgrel, x-51 nether rocket, Kurzon the false, Consul Rhys Lorgrand, Medallion
	//of the Alliance, Medallion of the Horde, Glacial Blade, Establishing New Outposts, Southshore, Rehgar Earthfury, Kelm Harguth, Whiteout Staff,
	//Next Stop, Menethil Harbor, Spectral Kitten, Force Command Death Trollbane, Famish the Binder, Blood Guard Gulmok, Electrified Dagger, Bolstering Our Defenses,
	//Tarren Mill, Talisman of the Horde, Illiyana Moonblaze, All Aboard for Undercity
	
	//[Nature]
	//stopped at Servant of the Betrayer
	//Shadow Resistance
	//fire damage - [FIRE]
	//marksman boris - wrong bold long-range
	//robotic homing chicken there is a period after elusive
	
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
