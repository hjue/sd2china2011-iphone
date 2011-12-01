//
//  MyAnnotation.h
//  sd2china2011
//
//  Created by Yu Hao on 11/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>

@interface MyAnnotation : NSObject <MKAnnotation>

@property(nonatomic,assign)CLLocationCoordinate2D coordinate;
@property(nonatomic,copy)NSString* title;
@property(nonatomic,copy)NSString* subtitle;
@end
