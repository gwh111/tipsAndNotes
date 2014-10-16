//
//  AppDelegate.m
//  Tips&Notes
//
//  Created by apple on 9/10/14.
//  Copyright (c) 2014年 ___GWH___. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "FirstLaunchViewController.h"
#import "LaunchWithPasswardViewController.h"
@interface AppDelegate ()
            

@end

@implementation AppDelegate
            

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    FirstLaunchViewController *firstLauchController=[[FirstLaunchViewController alloc]init];
    LaunchWithPasswardViewController *launchWithPasswardViewController=[[LaunchWithPasswardViewController alloc]init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"First"]==nil) {
//        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"1"] forKey:@"YANSE"];
        
        for (UILocalNotification *noti in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
            NSLog(@"info=%@",noti.userInfo);
            [[UIApplication sharedApplication] cancelLocalNotification:noti];
        }
        
        UINavigationController *navController =[[UINavigationController alloc] initWithRootViewController:firstLauchController];
        navController.navigationBarHidden=YES;
        self.window.rootViewController=navController;
    }else{
        UINavigationController *navController =[[UINavigationController alloc] initWithRootViewController:launchWithPasswardViewController];
        navController.navigationBarHidden=YES;
        self.window.rootViewController=navController;
    }
   
    
//    // Handle launching from a notification
	UILocalNotification *localNotif =
	[launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (localNotif) {
		NSLog(@"111Recieved Notification %@",localNotif.alertBody);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:[NSString stringWithFormat:@"'%@' Is Time Up!!",localNotif.alertBody]
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Remove" object:[localNotif alertBody]];
	}
    
    return YES;
}

- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notif {
	// Handle the notificaton when the app is running
	NSLog(@"Recieved Notification %@",notif);
    app.applicationIconBadgeNumber=0;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:[NSString stringWithFormat:@"'%@' Is Time Up!",notif.alertBody]
                                                   delegate:nil
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Remove" object:[notif alertBody]];
    //这里，你就可以通过notification的useinfo，干一些你想做的事情了
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    application.applicationIconBadgeNumber=0;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
