//
//  CardTableView.h
//  WoWTCGUtility
//
//  Created by Mike Chambers on 1/31/10.
//  Copyright 2010 Mike Chambers. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CardTableView : NSTableView
{
}

//todo: move this to a category for NSTableView
-(void)selectTableViewIndex:(int)index;
-(void)redraw;

@end
