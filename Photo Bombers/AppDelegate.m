//
//  AppDelegate.m
//  Photo Bombers
//
//  Created by Georgy Marrero on 1/19/15.
//  Copyright (c) 2015 Georgy Marrero. All rights reserved.
//

#import "AppDelegate.h"
#import "PhotosViewController.h"

#import <SimpleAuth/SimpleAuth.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    SimpleAuth.configuration[@"instagram"] = @{
        @"client_id" : @"ID",
        SimpleAuthRedirectURIKey : @"URIKEY"
    };
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    PhotosViewController *photosViewController = [[PhotosViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:photosViewController];
    
    UINavigationBar *navigationBar = navigationController.navigationBar;
    navigationBar.barTintColor = [UIColor colorWithRed:232.0 / 255.0 green:129.0 / 255.0 blue:91.0 / 255.0 alpha:1.0];
    navigationBar.barStyle = UIBarStyleBlackOpaque;
	navigationBar.tintColor = [UIColor whiteColor];
    
    self.window.rootViewController = navigationController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
