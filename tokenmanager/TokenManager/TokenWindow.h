//
//  TokenWindow.h
//  TokenManager
//
//  Created by Mike Chambers on 1/15/10.
//  Copyright 2010 Mike Chambers. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface TokenWindow : NSWindow
{
    NSPoint initialLocation;
}

@property (assign) NSPoint initialLocation;

@end
