//
//  ZAGuideView.h
//  ZAGuideView
//
//  Created by Zac Altman on 12/12/12.
//  Copyright (c) 2012 Zac Altman. All rights reserved.
//

#import <Foundation/Foundation.h>

// Settings
#define ZAGUIDE_DARK_THEME YES

//----------------------------//
//---- External Interface ----//
//----------------------------//

@interface ZAGuideView : NSObject

+ (void) showGuideWithURLString:(NSString *)urlString;
+ (void) showGuideWithTitle:(NSString *)title URLString:(NSString *)urlString;

@end
