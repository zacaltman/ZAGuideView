//
//  ViewController.m
//  ZAGuideView
//
//  Created by Zac Altman on 12/12/12.
//  Copyright (c) 2012 Zac Altman. All rights reserved.
//

#import "ViewController.h"
#import "ZAGuideView.h"

@implementation ViewController

- (IBAction)showLocalGuide:(id)sender {
    NSArray *data = @[
    @{ZAGUIDE_TITLE_KEY:@"Title A",ZAGUIDE_ITEMS_KEY:@[
    @{ZAGUIDE_TITLE_KEY:@"Link",ZAGUIDE_CONTENT_KEY:@"http://www.collusionapp.com/",ZAGUIDE_TYPE_KEY:ZAGUIDE_TYPE_LINK},
    @{ZAGUIDE_TITLE_KEY:@"Images",ZAGUIDE_CONTENT_KEY:@[@"https://collusionapp.com/wp-content/uploads/2012/10/logo.png",@"https://collusionapp.com/wp-content/uploads/2012/10/logo.png",@"https://collusionapp.com/wp-content/uploads/2012/10/logo.png",@"https://collusionapp.com/wp-content/uploads/2012/10/logo.png"],ZAGUIDE_TYPE_KEY:ZAGUIDE_TYPE_IMAGES},
    @{ZAGUIDE_TITLE_KEY:@"Html",ZAGUIDE_CONTENT_KEY:@"<html></body><h1>SUMO!</h1><p>Magical things</p></body></html>",ZAGUIDE_TYPE_KEY:ZAGUIDE_TYPE_HTML},
    @{ZAGUIDE_TITLE_KEY:@"Html",ZAGUIDE_CONTENT_KEY:@"Content D",ZAGUIDE_TYPE_KEY:ZAGUIDE_TYPE_HTML}
    ]
    },
    @{ZAGUIDE_TITLE_KEY:@"Title B",ZAGUIDE_ITEMS_KEY:@[
    @{ZAGUIDE_TITLE_KEY:@"Link",ZAGUIDE_CONTENT_KEY:@"http://www.collusionapp.com/",ZAGUIDE_TYPE_KEY:ZAGUIDE_TYPE_LINK},
    @{ZAGUIDE_TITLE_KEY:@"Images",ZAGUIDE_CONTENT_KEY:@"https://collusionapp.com/wp-content/uploads/2012/10/logo.png",ZAGUIDE_TYPE_KEY:ZAGUIDE_TYPE_IMAGES},
    @{ZAGUIDE_TITLE_KEY:@"Html",ZAGUIDE_CONTENT_KEY:@"Content <strong>C</strong>",ZAGUIDE_TYPE_KEY:ZAGUIDE_TYPE_HTML}
    ]
    }];
    [ZAGuideView showGuideWithData:data];
}

- (IBAction)showRemoteGuide:(id)sender {
    [ZAGuideView showGuideWithURLString:@"http://appguide.collusionapp.com/apguide.json"];
}

@end
