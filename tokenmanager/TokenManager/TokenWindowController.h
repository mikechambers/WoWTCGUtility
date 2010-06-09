//
//  TokenWindow.h
//  TokenManager
//
//  Created by Mike Chambers on 1/15/10.
//  Copyright 2010 Mike Chambers. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TokenWindowView.h"

typedef enum {
	CounterTokenType,
} TokenType;

@interface TokenWindowController : NSWindowController
{
    NSPoint initialLocation;
	IBOutlet TokenWindowView *contentView;
	
	TokenType tokenType;
}

@property (assign) NSPoint initialLocation;
@property (retain) TokenWindowView *contentView;
@property (assign) TokenType tokenType;

-(id)initWithTokenType:(TokenType)value;
-(void)drawToken;

@end
