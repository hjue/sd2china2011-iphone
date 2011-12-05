//
//  HomeViewController.m
//  sd2china2011
//
//  Created by Yu Hao on 11/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeData.h"
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"
#import "JsonDataSource.h"

@implementation HomeViewController
@synthesize bgimage;
@synthesize btnUpdate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"首页";
        self.tabBarItem.image = [UIImage imageNamed:@"icon_home.png"];
                      
    }
    
    
    
    
    data = [[JsonDataSource jsonObjectWithFile:@"home"]objectForKey:@"home"];

    
    
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
    [self.bgimage setImage:[UIImage imageNamed:@"Default.png"]];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setBgimage:nil];
    [self setBtnUpdate:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)phonePressed:(UIButton*)sender
{

    NSString* message = @"你的设备没有电话功能";
    UIDevice *device = [UIDevice currentDevice];
    if ([[device model] isEqualToString:@"iPhone"] ) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", [data objectForKey:@"phone"]]]];
    } else {
        UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [Notpermitted show];

    }    
}
- (IBAction)sharePressed:(UIButton*)sender
{
    //NSString* subject = [data.share valueForKey:@"subject"];
    //NSString* content = [data.share valueForKey:@"content"];
    //NSString* url = [data.share valueForKey:@"url"];
    JsonDataSource* jsonDataSource = [[JsonDataSource alloc]init];
    [btnUpdate setEnabled:NO];
    [jsonDataSource updateDataFromRemote];
;    
}

- (IBAction)mapPressed:(UIButton *)sender
{
//    double latitude = [[data.location valueForKey:@"latitude"]doubleValue];
//    double longitude = [[data.location valueForKey:@"longitude"]doubleValue];
    NSString* title = [data objectForKey:@"location"];
    NSString* mapurl = [NSString stringWithFormat:@"http://maps.google.com/maps?saddr=&daddr=%@",[title stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mapurl]];

}
/*
 http://www.edumobile.org/iphone/iphone-programming-tutorials/mapkit-example-in-iphone/
 
*/

- (void)mapPressed2:(UIButton*)sender
{
//    CGRect full = CGRectMake(0, 0, 320, 410);
//    MKMapView* mapView = [[MKMapView alloc] initWithFrame:full];
//    [mapView setMapType:MKMapTypeStandard];
//    [mapView setZoomEnabled:YES];
//    [mapView setScrollEnabled:YES];    
//    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } }; 
//    
//    region.center.latitude = [[data.location valueForKey:@"latitude"]doubleValue];
//    region.center.longitude = [[data.location valueForKey:@"longitude"]doubleValue];
//    region.span.longitudeDelta = 0.01f;
//    region.span.latitudeDelta = 0.01f;
//    [mapView setRegion:region animated:YES]; 
//    
//    [mapView setDelegate:self];
//    
//    MyAnnotation *ann = [[MyAnnotation alloc] init]; 
//    ann.title = [NSString stringWithFormat:@"%@",[data.location valueForKey:@"title"]];
//    ann.subtitle = [NSString stringWithFormat:@"%@",[data.location valueForKey:@"subtitle"]] ;
//    ann.coordinate = region.center; 
//    [mapView addAnnotation:ann];
//
//    
//    [[self view]addSubview:mapView];
    
    
}


@end
