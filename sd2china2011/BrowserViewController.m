//
//  BrowserViewController.m
//  sd2china2011
//
//  Created by Yu Hao on 11/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BrowserViewController.h"

@implementation BrowserViewController
@synthesize loading;
@synthesize webview;
@synthesize url,title;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *aURL = [NSURL URLWithString:self.url];
    NSURLRequest *aRequest = [NSURLRequest requestWithURL:aURL];
    [self.webview setDelegate:self];
    [self.webview setScalesPageToFit:YES];
    [self.webview loadRequest:aRequest];    
    
    self.loading.hidesWhenStopped  = YES;
    self.navigationItem.title = self.title;

}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.loading startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.loading stopAnimating];

}


- (void)viewDidUnload
{
    [self setLoading:nil];
    [self setWebview:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
