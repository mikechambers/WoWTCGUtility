//
//  PowersWebView.h
//  WoWTCGUtility
//
//  Created by Mike Chambers on 1/18/10.
//  Copyright 2010 Mike Chambers. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface PowersWebView : WebView
{
	WebView *webView;
	NSString *tempData;
	BOOL hasLoaded;
	NSString *activateImageHTML;
	NSString *paymentResultImageHTML;
	NSString *hordeAllyImageHTML;
	NSString *allianceAllyImageHTML;
}

@property (retain) WebView *webView;
@property (retain) NSString *tempData;
@property (retain) NSString *activateImageHTML;
@property (retain) NSString *paymentResultImageHTML;
@property (retain) NSString *hordeAllyImageHTML;
@property (retain) NSString *allianceAllyImageHTML;

-(void)setPowersText:(NSString *)data;
-(void)renderPowerText:(NSString *)data;
-(NSString *)formatPower:(NSString *)data;
@end
