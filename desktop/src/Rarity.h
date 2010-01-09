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

#import <Cocoa/Cocoa.h> 

#define COMMON 0
#define UNCOMMON 1
#define RARE 2
#define EPIC 3
#define LEGENDARY 4

#define COMMON_DESCRIPTION @"Common"
#define UNCOMMON_DESCRIPTION @"Uncommon"
#define RARE_DESCRIPTION @"Rare"
#define EPIC_DESCRIPTION @"Epic"
#define LEGENDARY_DESCRIPTION @"Legendary"

#define COMMON_ABR @"C"
#define UNCOMMON_ABR @"U"
#define RARE_ABR @"R"
#define EPIC_ABR @"E"
#define LEGENDARY_ABR @"L"

@interface Rarity : NSObject
{
}

+(int) getRarityTypeForDescription:(NSString *)description;
+(NSString *) getRarityDescriptionForType:(int)type;
+(NSString *) getRarityAbbreviationForType:(int)type;
+(int) getRarityTypeForAbbreviation:(NSString *)abbreviation;
+(NSArray *)rarityNames;

@end
