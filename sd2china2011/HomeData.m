//
//  HomeDataSource.m
//  sd2china2011
//
//  Created by Yu Hao on 11/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "HomeData.h"
#import "SBJson.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1
#define kLatestKivaLoansURL [NSURL URLWithString: @"http://api.kivaws.org/v1/loans/search.json?status=fundraising"] //2

@implementation HomeData

@synthesize phone;

@synthesize location;

@synthesize share;

//just available in ios5
- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization 
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions 
                          error:&error];
    
    NSArray* latestLoans = [json objectForKey:@"loans"]; //2
    
    NSLog(@"loans: %@", latestLoans); //3
}

- (void)testLocalization
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *currentLanguage = [languages objectAtIndex:0];
    
    NSLog(@"Current Locale: %@", [[NSLocale currentLocale] localeIdentifier]);
    NSLog(@"Current language: %@", currentLanguage);
    NSLog(@"Welcome Text: %@", NSLocalizedString(@"WelcomeKey", @""));    
}

-(id)init
{
    self = [super init]; 
    if(self){
        
        
        NSString* jsonString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"home" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
        
        NSDictionary* data = [jsonString JSONValue];
        self.phone = [NSString stringWithFormat:@"%@",[data valueForKey:@"phone"]];
        self.location = (NSDictionary*)[data valueForKey:@"location"];
        self.share = (NSDictionary*)[data valueForKey:@"share"];

    }


    
    
//    NSString* istr = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"search" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
                    
//    NSData* bdata = [NSData dataWithContentsOfURL:kLatestKivaLoansURL];
//    [self fetchedData:[istr dataUsingEncoding:NSUTF8StringEncoding]];
//    [self fetchedData:bdata];
     
    return self;
}


@end
