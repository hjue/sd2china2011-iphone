//
//  JsonDataSource.m
//  sd2china2011
//
//  Created by Yu Hao on 11/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "JsonDataSource.h"
#import "SBJson.h"
#import "HomeViewController.h"
#import "Reachability.h"


@implementation JsonDataSource


+(NSDictionary* ) jsonObjectWithFile:(NSString*) name
{
    
//    NSArray* files = [[NSArray alloc]initWithObjects:@"forum",@"home",@"lecturer",@"schedule",@"topics",@"weibo", nil];
    
    NSString* documentsDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString* filePath = [documentsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.json",name]];
    
    NSFileManager *fileMgr=[NSFileManager defaultManager];
    NSError* error;
    NSString* jsonString;
    
    if(![fileMgr fileExistsAtPath:filePath])
    {
        NSString* jsonString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:name ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];  
        [jsonString writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error] ;
        
    }
    if(jsonString==nil)
    {
        jsonString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    }
        
    NSDictionary* jsonObject = [jsonString JSONValue] ; 
    return jsonObject;
}

-(BOOL) hasNetwork
{
    BOOL hasNetwork =NO;
    Reachability* r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            hasNetwork = NO;
            break;
        case ReachableViaWWAN:
            hasNetwork = YES;
            break;
        case ReachableViaWiFi:
            hasNetwork = YES;
            break;
            
        default:
            break;
    }
    
    return hasNetwork;
}

-(int) versionWithRemote
{
    NSString* path = [[NSBundle mainBundle]pathForResource:@"config" ofType:@"plist"];
    NSDictionary* config = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSString* version_url = [config objectForKey:@"version_url"];
    //version_url = [version_url stringByAppendingString:@"a"];
        
    NSString* jsonString = [NSString stringWithContentsOfURL:[NSURL URLWithString:version_url] encoding:NSUTF8StringEncoding error:nil];
    NSDictionary* jsonObject = [jsonString JSONValue];    
    NSString* version = [jsonObject objectForKey:@"version"];
    
    int nn = [version intValue];
    return nn;
}

-(int) versionWithLocal
{
    NSInteger ni = [[NSUserDefaults standardUserDefaults]integerForKey:@"version"];
    int ret = ni;
    return  ret;

    
}

-(void) setVersion:(int) versioin
{
    [[NSUserDefaults standardUserDefaults]setInteger:versioin forKey:@"version"];
}

-(BOOL) updateDataFromRemote
{
    if(![self hasNetwork]) return NO;
    
       
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        

        NSString* path = [[NSBundle mainBundle]pathForResource:@"config" ofType:@"plist"];
        NSDictionary* config = [NSDictionary dictionaryWithContentsOfFile:path];
        
        NSString* refresh_url = [config objectForKey:@"refresh_url"];
        
        int localVersion = [self versionWithLocal];
        int remoteVersion = [self versionWithRemote];
        NSLog(@"local:%d,remote:%d",localVersion,remoteVersion);
        if( remoteVersion>localVersion)
        {
        
            NSString* jsonString = [NSString stringWithContentsOfURL:[NSURL URLWithString:refresh_url] encoding:NSUTF8StringEncoding error:nil];
            NSDictionary* jsonObject = [jsonString JSONValue];
            
            
            [self performSelectorOnMainThread:@selector(handleData:) withObject:jsonObject waitUntilDone:YES];
        }
        
    });
    return YES;
    
    
}



-(void) handleData:(NSDictionary*) jsonObject
{
     [self makeDataFile:jsonObject];
    UIWindow* window = [[UIApplication sharedApplication].delegate window];
    UITabBarController* tabcontroller = (UITabBarController*)[window rootViewController];
    UIViewController* controller = [tabcontroller.viewControllers objectAtIndex:tabcontroller.selectedIndex] ;

    if([controller isKindOfClass:[HomeViewController class]])
    {
      
        HomeViewController * hc = (HomeViewController *)controller;
        [hc.btnUpdate setEnabled:YES];
    }
     
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"SD2China" message:@"Update Over!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
}


- (BOOL)makeDataFile:(NSDictionary*)jsonObject
{
    
    NSError* error;

    
    NSString* documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    SBJsonWriter* writer = [[SBJsonWriter alloc]init];
    int version = 0;
    for(NSString* strKey in [jsonObject allKeys]){

        NSString* strFilePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.json",strKey]];
        
        NSString* str = [writer stringWithObject:[jsonObject objectForKey:strKey]];
        
        if([strKey isEqualToString:@"version"])
        {
            //[jsonObject objectForKey:strKey]
            version = [[jsonObject objectForKey:strKey] intValue]; 
        } else
        {
            NSString* wrapped = [NSString stringWithFormat:@"{\"%@\":%@}",strKey,str];
            
            [wrapped writeToFile:strFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
            str = nil;
            wrapped = nil;
        }

    }
    
    
    if(error == nil)
    {
        if(version>0)
            [self setVersion:version];
        return YES;
    }else
        return NO;
    
//  
    
//NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//NSString *documentsDirectory=[paths objectAtIndex:0];    
//    NSString *writableDBPath=[documentsDirectory stringByAppendingPathComponent:DB_NAME];
//    BOOL sucess=[filemanage fileExistsAtPath:writableDBPath];
//    NSError *error;
//    
//    if (sucess) {
//        //return;
//        if (![filemanage removeItemAtPath:writableDBPath error:&error])
//        {
//            NSLog(@"Could not remove old files. Error:%@",error);
//            
//            return ;
//        }
//    }
//    NSString *defaultDBPath=[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DB_NAME];
//    
//    NSLog(@"atPath:%@ toPath:%@",defaultDBPath,writableDBPath);
//    sucess=[filemanage copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
//    if (!sucess) {
//        NSLog(@"create Database error:%@",[error localizedDescription]);
//    }
//    [pool release];
}


@end
