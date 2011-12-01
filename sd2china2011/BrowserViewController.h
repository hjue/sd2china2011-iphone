//
//  BrowserViewController.h
//  sd2china2011
//
//  Created by Yu Hao on 11/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrowserViewController : UIViewController<UIWebViewDelegate>

@property(nonatomic,copy) NSString* url;
@property(nonatomic,copy) NSString* title;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loading;
@property (strong, nonatomic) IBOutlet UIWebView *webview;

@end
