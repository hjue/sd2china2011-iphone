//
//  AppDelegate.m
//  sd2china2011
//
//  Created by Yu Hao on 11/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "ScheduleViewController.h"

#import "PlaceViewController.h"

#import "HomeViewController.h"

#import "WeiboViewController.h"
#import "MoreViewController.h"
#import "LectorViewController.h"
#import "JsonDataSource.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    UIViewController *scheduleViewController = [[ScheduleViewController alloc] initWithNibName:@"ScheduleViewController" bundle:nil];
    
//    UIViewController *viewController2 = [[PlaceViewController alloc] initWithNibName:@"PlaceViewController" bundle:nil];
    
    UIViewController* homeViewController = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
    UITableViewController* weiboViewController = [[WeiboViewController alloc]initWithNibName:@"WeiboViewController" bundle:nil];
    UITableViewController* moreViewController = [[MoreViewController alloc]initWithNibName:@"MoreViewController" bundle:nil];
    UITableViewController* lectorViewController = [[LectorViewController alloc]initWithNibName:@"LectorViewController" bundle:nil];
    
    UINavigationController *navWeibo = [[UINavigationController alloc]initWithRootViewController:weiboViewController];

    UINavigationController *navSchedule = [[UINavigationController alloc]initWithRootViewController:scheduleViewController];

    UINavigationController *navLector = [[UINavigationController alloc]initWithRootViewController:lectorViewController];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:homeViewController,navSchedule, navLector, navWeibo,moreViewController,nil];
    
    self.tabBarController.selectedIndex = 0;
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
