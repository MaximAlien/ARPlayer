//
//  AppDelegate.m
//  ARPlayer
//
//  Created by Maxim Makhun on 9/21/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

#import "AppDelegate.h"

// View Controllers
#import "PlayerViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    PlayerViewController *playerViewController = [PlayerViewController new];
    self.window.rootViewController = playerViewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
