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
    // This is an example of the data
    
    // Example link item
    NSDictionary *linkItem = @{
        ZAGUIDE_TITLE_KEY:@"Link Content",
        ZAGUIDE_TYPE_KEY:ZAGUIDE_TYPE_LINK,
        ZAGUIDE_CONTENT_KEY:@"http://www.collusionapp.com/"
    };
    
    // Example HTML / Text item
    NSDictionary *htmlItem = @{
        ZAGUIDE_TITLE_KEY:@"Html Content",
        ZAGUIDE_TYPE_KEY:ZAGUIDE_TYPE_HTML,
        ZAGUIDE_CONTENT_KEY:@"Can just be text"
    };
    
    // Example image item
    NSString *imageUrl = @"https://collusionapp.com/wp-content/uploads/2012/10/logo.png";
    NSDictionary *imagesItem = @{
        ZAGUIDE_TITLE_KEY:@"A few images",
        ZAGUIDE_TYPE_KEY:ZAGUIDE_TYPE_IMAGES,
        ZAGUIDE_CONTENT_KEY:@[imageUrl,imageUrl,imageUrl]
    };
    
    // Now we add the items to the group
    NSDictionary *group = @{
        ZAGUIDE_TITLE_KEY:@"Random Title",
        ZAGUIDE_ITEMS_KEY:@[linkItem,htmlItem,imagesItem]
    };
    
    // Another group just for fun
    NSDictionary *anotherGroup = @{
        ZAGUIDE_TITLE_KEY:@"What? Another group?",
        ZAGUIDE_ITEMS_KEY:@[imagesItem,linkItem,htmlItem]
    };
    
    // Now we create the data source (just an array of groups)
    NSArray *data = @[group,anotherGroup];
    
    // And... show!
    [ZAGuideView showGuideWithData:data];
}

- (IBAction)showRemoteGuide:(id)sender {
    
    // We're using Collusion as the example here.
    [ZAGuideView showGuideWithURLString:@"http://appguide.collusionapp.com/"];
}

@end
