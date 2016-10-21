//
//  AppDelegate.m
//  shop
//
//  Created by zhangwenqiang on 16/6/5.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseAPI.h"
#import "ViewController.h"
#import "LaunchViewController.h"
#import "Constants.h"
#import "UserDefault.h"

#import "WXApi.h"
#import "WXApiManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)switchRootViewController{
    
    self.window.rootViewController = nil;
    
    BOOL isFirstLaunch = [[UserDefault share] isFirstLaunch];
    
    if (isFirstLaunch) {
        
        LaunchViewController * launchVC = [[LaunchViewController alloc] init];
    
        self.window.rootViewController  = launchVC;
    }
    else {
    
        UINavigationController* rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
        
        self.window.rootViewController = rootViewController;
        
        //[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(removeLun:) userInfo:nil repeats:NO];
    }
    
     [self.window makeKeyAndVisible];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //向微信注册
    [WXApi registerApp:APP_ID_WX withDescription:@"丁丁云购 1.0"];
    
    [self switchRootViewController];
    
    [NSThread sleepForTimeInterval:1.0f];
    
    //NSLog(@"[[UIDevice currentDevice] name]-->%@",[[UIDevice currentDevice] name]);
    
    //NSLog(@"[[UIScreen mainScreen] bounds].size.height-->%@",@([[UIScreen mainScreen] bounds].size.height));
    
    return YES;
}

- (void)removeLun:(NSTimer*)sender{
    
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
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
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
