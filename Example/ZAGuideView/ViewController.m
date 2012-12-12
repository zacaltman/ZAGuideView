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

- (IBAction)showGuide:(id)sender {
    [ZAGuideView showGuideWithURLString:nil];
}

@end
