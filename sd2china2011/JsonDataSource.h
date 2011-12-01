//
//  JsonDataSource.h
//  sd2china2011
//
//  Created by Yu Hao on 11/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonDataSource : NSObject

+(NSDictionary* ) jsonObjectWithFile:(NSString*) name;

-(BOOL) updateDataFromRemote;

-(BOOL) makeDataFile:(NSDictionary*) jsonObject;

@end
