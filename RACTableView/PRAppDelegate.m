//
//  PRAppDelegate.m
//  RACTableView
//
//  Created by Paul Robinson on 2014-04-20.
//  Copyright (c) 2014 Elastic Rat. All rights reserved.
//

#import "PRAppDelegate.h"
#import "ViewController.h"

@implementation PRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    ViewController *viewController = [[ViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    NSLog(@"navController: %@", viewController.navigationController);
    self.window.rootViewController = navigationController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
