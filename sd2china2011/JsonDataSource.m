//
//  JsonDataSource.m
//  sd2china2011
//
//  Created by Yu Hao on 11/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "JsonDataSource.h"
#import "SBJson.h"

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

-(BOOL) updateDataFromRemote
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString* path = [[NSBundle mainBundle]pathForResource:@"config" ofType:@"plist"];
        NSDictionary* config = [NSDictionary dictionaryWithContentsOfFile:path];
        NSString* refresh_url = [config objectForKey:@"refresh_url"];
        
        NSString* jsonString = [NSString stringWithContentsOfURL:[NSURL URLWithString:refresh_url] encoding:NSUTF8StringEncoding error:nil];
        NSDictionary* jsonObject = [jsonString JSONValue];
        
        [self performSelectorOnMainThread:@selector(handleData:) withObject:jsonObject waitUntilDone:YES];
        
    });
    return YES;
    
    
}



-(void) handleData:(NSDictionary*) jsonObject
{
     [self makeDataFile:jsonObject];
}


- (BOOL)makeDataFile:(NSDictionary*)jsonObject
{
    
    NSFileManager *fileMgr=[NSFileManager defaultManager];
    NSError* error;

    
    NSString* documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    SBJsonWriter* writer = [[SBJsonWriter alloc]init];
    
    for(NSString* strKey in [jsonObject allKeys]){
        NSString* strFilePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.json",strKey]];
        
        NSString* str = [NSString stringWithFormat:@"%@",[writer stringWithObject:[jsonObject objectForKey:strKey]]];
        
        NSString* wrapped = [NSString stringWithFormat:@"{\"%@\":%@}",strKey,str];
        
        [wrapped writeToFile:strFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        
        
        NSLog(@"Documents directory: %@",
              [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:&error]);
        str = nil;
        wrapped = nil;
    }
    
    if(error == nil)
        return NO;
    else
        return YES;
    
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
