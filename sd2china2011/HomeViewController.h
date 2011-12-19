//
//  HomeViewController.h
//  sd2china2011
//
//  Created by Yu Hao on 11/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@class HomeData;

@interface HomeViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>
{
    NSDictionary * data;
    CLLocationManager *locationManager;
    CLLocation* myLocation;
}
@property (strong, nonatomic) IBOutlet UIImageView *bgimage;
@property (strong, nonatomic) IBOutlet UIButton *btnUpdate;
@property (nonatomic, retain) CLLocationManager *locationManager; 

- (IBAction)phonePressed:(UIButton*)sender;
- (IBAction)sharePressed:(UIButton*)sender;
- (IBAction)mapPressed:(UIButton*)sender;

@end
