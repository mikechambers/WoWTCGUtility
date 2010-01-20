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

#import "PowersWebView.h"
#import "GTMRegex.h"

@implementation PowersWebView

@synthesize webView;
@synthesize tempData;
@synthesize activateImageHTML;
@synthesize paymentResultImageHTML;
@synthesize hordeAllyImageHTML;
@synthesize allianceAllyImageHTML;

-(void)dealloc
{
	[allianceAllyImageHTML release];
	[hordeAllyImageHTML release];
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
	
	NSString *hordeAllyPath = [[[NSBundle mainBundle] resourcePath] 
								   stringByAppendingPathComponent:@"/assets/horde_ally.png"];
	NSURL *hordeAllyURL = [NSURL fileURLWithPath: hordeAllyPath isDirectory:FALSE];
	self.hordeAllyImageHTML = [NSString stringWithFormat:@"<img src=\"%@\" />", hordeAllyURL.absoluteString];		
	
	NSString *allianceAllyPath = [[[NSBundle mainBundle] resourcePath] 
							   stringByAppendingPathComponent:@"/assets/alliance_ally.png"];
	NSURL *allianceAllyURL = [NSURL fileURLWithPath: allianceAllyPath isDirectory:FALSE];
	self.allianceAllyImageHTML = [NSString stringWithFormat:@"<img src=\"%@\" />", allianceAllyURL.absoluteString];		
	
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
	[replaceDict setObject:@"<b>Diplomacy</b>" forKey:@"Diplomacy" ];		
	[replaceDict setObject:@"<b>Long-Range</b>" forKey:@"Long-Range" ];
	[replaceDict setObject:@"<b>Reward</b>" forKey:@"Reward" ];
	[replaceDict setObject:@"<b>Trap</b>" forKey:@"Trap" ];
	[replaceDict setObject:@"<b>Sextuple Wield</b>" forKey:@"Sextuple Wield" ];	
	[replaceDict setObject:@"<b>Finishing Move</b>" forKey:@"Finishing Move" ];	 	
	[replaceDict setObject:@"<b>War Stomp</b>" forKey:@"War Stomp" ];	 	
	[replaceDict setObject:@"<b>Berserking</b>" forKey:@"Berserking" ];	 	
	[replaceDict setObject:@"<b>AWESOME</b>" forKey:@"AWESOME" ];		
	[replaceDict setObject:@"<b>Inspiring Presence</b>" forKey:@"Inspiring Presence" ];	
	[replaceDict setObject:@"<b>Hardiness</b>" forKey:@"Hardiness" ];	
	[replaceDict setObject:@"<b>Arcane Torrent</b>" forKey:@"Arcane Torrent" ];		
	[replaceDict setObject:@"<b>Escape Artist</b>" forKey:@"Escape Artist" ];		
	[replaceDict setObject:@"<b>Find Treasure</b>" forKey:@"Find Treasure" ];	
	[replaceDict setObject:@"<b>Will of the Forsaken</b>" forKey:@"Will of the Forsaken" ];
	[replaceDict setObject:@"<b>irradiated</b>" forKey:@"irradiated" ];	
	[replaceDict setObject:@"<b>Preparation</b>" forKey:@"Preparation" ];		
	[replaceDict setObject:@"<b>Invincible</b>" forKey:@"Invincible" ];	
	
	
	[replaceDict setObject:@"<i>(" forKey:@"(" ];
	[replaceDict setObject:@")</i>" forKey:@")" ];
	[replaceDict setObject:activateImageHTML forKey:@"[Activate]" ];
	[replaceDict setObject:paymentResultImageHTML forKey:@">>>" ];
	[replaceDict setObject:hordeAllyImageHTML forKey:@"[Horde]" ];
	[replaceDict setObject:allianceAllyImageHTML forKey:@"[Alliance]" ];	
	
	for(NSString *key in replaceDict)
	{
		out = [out stringByReplacingOccurrencesOfString:key withString:[replaceDict objectForKey:key]];
	}

	out = [NSString stringWithFormat:@"<p>%@</p>", out];
	
	GTMRegex *mendRegex = [GTMRegex regexWithPattern:@"Mend ([0-9]|[0-9][0-9]|X)" options:kGTMRegexOptionSupressNewlineSupport];
	out = [mendRegex stringByReplacingMatchesInString:out withReplacement:@"<b>Mend \\1</b>"];

	GTMRegex *paysRegex = [GTMRegex regexWithPattern:@"(Pay[s]? )([0-9]|[x])|(Pay[s]? )([0-9][0-9]))" options:kGTMRegexOptionSupressNewlineSupport|kGTMRegexOptionIgnoreCase];
	out = [paysRegex stringByReplacingMatchesInString:out withReplacement:@"\\1<span class='payCircle'>&nbsp;<b>\\2</b>&nbsp;</span>"];	
	
	GTMRegex *assaultRegex = [GTMRegex regexWithPattern:@"Assault ([0-9]|[0-9][0-9]|X)" options:kGTMRegexOptionSupressNewlineSupport];
	out = [assaultRegex stringByReplacingMatchesInString:out withReplacement:@"<b>Assault \\1</b>"];	
	

	GTMRegex *requiredHeroRegex = [GTMRegex regexWithPattern:@"([[:<:]][A-Z][a-z]*[[:>:]] [[:<:]][A-Z][a-z]*[[:>:]]|[[:<:]][A-Z][a-z]*[[:>:]])( Hero Required)"];
	out = [requiredHeroRegex stringByReplacingMatchesInString:out withReplacement:@"<b>\\1\\2</b>"];		

	GTMRegex *resistanceRegex = [GTMRegex regexWithPattern:@"([[:<:]][A-Z][a-z]*[[:>:]])( Resistance)" options:kGTMRegexOptionSupressNewlineSupport];
	out = [resistanceRegex stringByReplacingMatchesInString:out withReplacement:@"<b>\\1\\2</b>"];
	
	GTMRegex *reputationRegex = [GTMRegex regexWithPattern:@"([[:<:]][A-Z][a-z]*[[:>:]])( Reputation)" options:kGTMRegexOptionSupressNewlineSupport];
	out = [reputationRegex stringByReplacingMatchesInString:out withReplacement:@"<b>\\1\\2</b>"];
	
	//NSLog(@"%@", out);
	
	//[Ranged], [Health], Boots of Whirling mist
	//[Nature]
	//fire damage - [FIRE]
	//robotic homing chicken there is a period after elusive
	//sister remba elusive and untergetable lower case are bolded
	//Two-Handed dual wield
	//lady katrana payment
	//bear form, cat form, Cat Form, protector, long-range, resistance, stealth, elusive, ferocity, dual wield, thown, untargetable
	//Totems
	//Mend - by itself
	//Assault X Garrosh Hellscream
	return out;	
}
						  

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame
{
	if(tempData)
	{
		[self renderPowerText:tempData];
		self.tempData == nil;
		[self setFrameLoadDelegate:nil];
	}
	
	hasLoaded = TRUE;
}

@end
