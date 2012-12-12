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
#define ZAGUIDE_DEFAULT_TITLE @"Guide"

// Advanced Settings
#define ZAGUIDE_TITLE_KEY @"title"
#define ZAGUIDE_ITEMS_KEY @"items"
#define ZAGUIDE_CONTENT_KEY @"content"
#define ZAGUIDE_TYPE_KEY @"type"

#define ZAGUIDE_TYPE_IMAGES @"images"
#define ZAGUIDE_TYPE_HTML @"html"
#define ZAGUIDE_TYPE_LINK @"link"

//----------------------------//
//---- External Interface ----//
//----------------------------//

@interface ZAGuideView : NSObject

// Using locally
+ (void) showGuideWithData:(NSArray *)data;
+ (void) showGuideWithTitle:(NSString *)title data:(NSArray *)data;

// Using remotely (not working)
+ (void) showGuideWithURLString:(NSString *)urlString;
+ (void) showGuideWithTitle:(NSString *)title URLString:(NSString *)urlString;

@end
