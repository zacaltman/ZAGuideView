//
//  ZAGuideView.m
//  ZAGuideView
//
//  Created by Zac Altman on 12/12/12.
//  Copyright (c) 2012 Zac Altman. All rights reserved.
//

#import "ZAGuideView.h"

static BOOL contentLoaded = NO;

#define ZAGUIDE_DEFAULT_TITLE @"Guide"

#define ZAGUIDE_TITLE_KEY @"title"
#define ZAGUIDE_ITEMS_KEY @"items"
#define ZAGUIDE_CONTENT_KEY @"content"
#define ZAGUIDE_TYPE_KEY @"type"

#define ZAGUIDE_TYPE_IMAGES @"images"
#define ZAGUIDE_TYPE_HTML @"html"
#define ZAGUIDE_TYPE_LINK @"link"

@interface ZAGuideTableViewController : UITableViewController {
    NSArray *_data;
}
@end

@interface ZAWebViewController : UIViewController {
    UIWebView *_webView;
}
@end

@interface ZAImageViewer : UIViewController <UIScrollViewDelegate> {
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    NSArray *_images;
}
@end

///////////////////////////////////////////////////////////////////////////////

@implementation ZAGuideView

///////////////////////////////////////////////////////////////////////////////

#pragma mark - External Methods

+ (void) showGuideWithURLString:(NSString *)urlString {
    [self showGuideWithTitle:ZAGUIDE_DEFAULT_TITLE URLString:urlString];
}

+ (void) showGuideWithTitle:(NSString *)title URLString:(NSString *)urlString {
        
    // Get the view to present the Guide from
    UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    
    // Get the guide
    UINavigationController *navigationController = [self getNavigationControllerWithTitle:title];
    
    // Present it
    [rootViewController presentViewController:navigationController
                                     animated:YES
                                   completion:nil];
    
}

///////////////////////////////////////////////////////////////////////////////

#pragma mark - Internal Methods

+ (UINavigationController *) getNavigationControllerWithTitle:(NSString *)title {
    
    // Setup the controllers
    UINavigationController *navigationController = [UINavigationController new];
    ZAGuideTableViewController *guideView = [ZAGuideTableViewController new];
    [navigationController setViewControllers:@[guideView]];
    
    // Set the title
    [guideView setTitle:title];
    
    // Make sure it doesn't take up the entire screen
    [navigationController setModalPresentationStyle:UIModalPresentationFormSheet];
    [navigationController setModalInPopover:YES];
    
    // Everyone likes animations
    [navigationController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    
    return navigationController;
}

///////////////////////////////////////////////////////////////////////////////

#pragma mark -
@end

///////////////////////////////////////////////////////////////////////////////

@implementation ZAWebViewController

///////////////////////////////////////////////////////////////////////////////

#pragma mark - External Methods

- (void) setURLString:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [_webView loadRequest:request];
}

- (void) setHTMLString:(NSString *)htmlString {
    [_webView loadHTMLString:htmlString baseURL:nil];
}

///////////////////////////////////////////////////////////////////////////////

#pragma mark - Internal Methods

- (id)init {
    self = [super init];
    if (self) {
        [self setupWebview];
    }
    return self;
}

- (void) setupWebview {
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [_webView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [self.view addSubview:_webView];
}

///////////////////////////////////////////////////////////////////////////////

#pragma mark -
@end

///////////////////////////////////////////////////////////////////////////////

@implementation ZAImageViewer

///////////////////////////////////////////////////////////////////////////////

#pragma mark - External Methods

- (void) setImages:(NSArray *)images {
    _images = images;
    [self displayContent];
}

///////////////////////////////////////////////////////////////////////////////

#pragma mark - Internal Methods

- (id)init {
    self = [super init];
    if (self) {
        [self setupScrollView];
    }
    return self;
}

- (void) setupScrollView {

    // Setup scroll view
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [_scrollView setDelegate:self];
    [_scrollView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [_scrollView setPagingEnabled:YES];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [self.view addSubview:_scrollView];
    
    // Page control size
    CGRect controlRect = self.view.bounds;
    float height = 40.0f;
    controlRect.size.height = height;
    controlRect.origin.y = self.view.bounds.size.height - height;
    
    // Setup page control
    _pageControl = [[UIPageControl alloc] initWithFrame:controlRect];
    [_pageControl setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth];
    [self.view addSubview:_pageControl];

}

- (void) displayContent {
    
    // Let's make sure the Scrollview has no content:
    for (UIView *view in _scrollView.subviews) {
        [view removeFromSuperview];
    }
    
    // Sort out the UI elements
    NSInteger count = _images.count;
    float width = _scrollView.frame.size.width;
    float height = _scrollView.frame.size.height;

    // The size of the scrollview should fit all of the images
    CGSize contentSize = CGSizeMake(width * count, height);
    [_scrollView setContentSize:contentSize];
    [_pageControl setNumberOfPages:count];
    
    // Now let's iterate through and add the images to the scrollview.
    for (NSString *urlString in _images) {
        NSUInteger index = [_images indexOfObject:urlString];
        CGRect frame = CGRectMake(width * index, 0, width, height);

        UIImageView *imageView = [UIImageView new];
//        [imageView setURLString:urlString];
        [imageView setContentMode:UIViewContentModeScaleAspectFit]; // We always want the content to show.
        [imageView setFrame:frame];
        
        [_scrollView addSubview:imageView];
    }
}

///////////////////////////////////////////////////////////////////////////////

#pragma mark - ScrollView Methods

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // We want the control to switch as soon as the image is 50% showing.
    NSInteger page = (scrollView.contentOffset.x + (scrollView.bounds.size.width / 2)) / scrollView.bounds.size.width;
    [_pageControl setCurrentPage:page];
    
}

///////////////////////////////////////////////////////////////////////////////

#pragma mark -
@end

///////////////////////////////////////////////////////////////////////////////

@implementation ZAGuideTableViewController

///////////////////////////////////////////////////////////////////////////////

static NSString *tableCellIdentifier = @"tableCellId";

///////////////////////////////////////////////////////////////////////////////

#pragma mark - Internal Methods

- (id)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        [self setupNavigation];
        
        _data = @[
        @{ZAGUIDE_TITLE_KEY:@"Title A",ZAGUIDE_ITEMS_KEY:@[
        @{ZAGUIDE_TITLE_KEY:@"Link",ZAGUIDE_CONTENT_KEY:@"http://www.collusionapp.com/",ZAGUIDE_TYPE_KEY:ZAGUIDE_TYPE_LINK},
        @{ZAGUIDE_TITLE_KEY:@"Images",ZAGUIDE_CONTENT_KEY:@[@"https://collusionapp.com/wp-content/uploads/2012/10/logo.png",@"https://collusionapp.com/wp-content/uploads/2012/10/logo.png"],ZAGUIDE_TYPE_KEY:ZAGUIDE_TYPE_IMAGES},
        @{ZAGUIDE_TITLE_KEY:@"Html",ZAGUIDE_CONTENT_KEY:@"Content <strong>C</strong>",ZAGUIDE_TYPE_KEY:ZAGUIDE_TYPE_HTML},
        @{ZAGUIDE_TITLE_KEY:@"Html",ZAGUIDE_CONTENT_KEY:@"Content D",ZAGUIDE_TYPE_KEY:ZAGUIDE_TYPE_HTML}
        ]
        },
        @{ZAGUIDE_TITLE_KEY:@"Title B",ZAGUIDE_ITEMS_KEY:@[
        @{ZAGUIDE_TITLE_KEY:@"Link",ZAGUIDE_CONTENT_KEY:@"http://www.collusionapp.com/",ZAGUIDE_TYPE_KEY:ZAGUIDE_TYPE_LINK},
        @{ZAGUIDE_TITLE_KEY:@"Images",ZAGUIDE_CONTENT_KEY:@"https://collusionapp.com/wp-content/uploads/2012/10/logo.png",ZAGUIDE_TYPE_KEY:ZAGUIDE_TYPE_IMAGES},
        @{ZAGUIDE_TITLE_KEY:@"Html",ZAGUIDE_CONTENT_KEY:@"Content <strong>C</strong>",ZAGUIDE_TYPE_KEY:ZAGUIDE_TYPE_HTML}
        ]
        }];
    }
    return self;
}

- (void) setupNavigation {
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                target:self
                                                                                action:@selector(dismiss)];
    [self.navigationItem setRightBarButtonItem:doneButton];
}

- (void) dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

///////////////////////////////////////////////////////////////////////////////

#pragma mark - TableView Methods

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger count = [_data count];
    return count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = [(NSArray *)[[self objectForSection:section] objectForKey:ZAGUIDE_ITEMS_KEY] count];
    return count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:tableCellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableCellIdentifier];
    }
    
    NSString *text = [[self objectAtIndexPath:indexPath] objectForKey:ZAGUIDE_TITLE_KEY];
    [cell.textLabel setText:text];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

    return cell;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *header = [[_data objectAtIndex:section] objectForKey:ZAGUIDE_TITLE_KEY];
    return header;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // Get the data we need
    NSDictionary *object = [self objectAtIndexPath:indexPath];
    NSString *typeString = [object objectForKey:ZAGUIDE_TYPE_KEY];
    BOOL isImageArray = [typeString isEqualToString:ZAGUIDE_TYPE_IMAGES];
    BOOL isHTML = [typeString isEqualToString:ZAGUIDE_TYPE_HTML];
    BOOL isLink = [typeString isEqualToString:ZAGUIDE_TYPE_LINK];
    
    // Handle anything involving a webview.
    if (isHTML || isLink) {
        
        NSString *contentString = [object objectForKey:ZAGUIDE_CONTENT_KEY];
        ZAWebViewController *webView = [ZAWebViewController new];
        [webView setTitle:[object objectForKey:ZAGUIDE_TITLE_KEY]];
        [self.navigationController pushViewController:webView animated:YES];

        if (isHTML) [webView setHTMLString:contentString];
        if (isLink) [webView setURLString:contentString];
        
    }
    
    // Handle the images
    if (isImageArray) {

        id content = [object objectForKey:ZAGUIDE_CONTENT_KEY];
        NSArray *imageArray = nil;
        
        // We should get the content in a consistant format.
        if ([content isKindOfClass:[NSArray class]]) {
            imageArray = (NSArray *)content;
        }
        
        if ([content isKindOfClass:[NSString class]]) {
            imageArray = @[content];
        }
        
        // The data was invalid, bail out.
        if (!imageArray) return;
        
        ZAImageViewer *imageViewer = [ZAImageViewer new];
        [imageViewer setTitle:[object objectForKey:ZAGUIDE_TITLE_KEY]];
        [self.navigationController pushViewController:imageViewer animated:YES];

        [imageViewer setImages:imageArray];
        
    }
}

///////////////////////////////////////////////////////////////////////////////

#pragma mark - Data Methods

- (NSDictionary *) objectForSection:(NSInteger)section {
    NSDictionary *sectionObject = (NSDictionary *)[_data objectAtIndex:section];
    return sectionObject;
}

- (NSDictionary *) objectAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *sectionData = [self objectForSection:indexPath.section];
    NSArray *sectionItems = (NSArray *)[sectionData objectForKey:ZAGUIDE_ITEMS_KEY];
    NSDictionary *object = [sectionItems objectAtIndex:indexPath.row];
    return object;
}

///////////////////////////////////////////////////////////////////////////////

@end