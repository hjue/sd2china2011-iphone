//
//  HomeDataSource.h
//  sd2china2011
//
//  Created by Yu Hao on 11/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeData : NSObject

@property(nonatomic,copy) NSString* phone;
@property(nonatomic,copy)NSDictionary* location;
@property(nonatomic,copy)NSDictionary* share;

- (id)init;

@end
