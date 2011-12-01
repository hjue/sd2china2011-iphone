//
//  HomeViewController.h
//  sd2china2011
//
//  Created by Yu Hao on 11/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class HomeData;

@interface HomeViewController : UIViewController<MKMapViewDelegate>
{
    NSDictionary * data;
}
@property (strong, nonatomic) IBOutlet UIImageView *bgimage;

- (IBAction)phonePressed:(UIButton*)sender;
- (IBAction)sharePressed:(UIButton*)sender;
- (IBAction)mapPressed:(UIButton*)sender;

@end
