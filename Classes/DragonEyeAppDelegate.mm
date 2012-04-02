//
//  DragonEyeAppDelegate.m
//  DragonEye
//
//  Created by alkaiser on 2/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DragonEyeAppDelegate.h"
#import "GameController.h"
#import "Loggers.h"
@implementation DragonEyeAppDelegate

@synthesize window;
@synthesize viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window.rootViewController = self.viewController;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [self.viewController stopGame];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	DLOG("Calling startGame");
    [self.viewController startGame];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	DLOG("Calling stopGame");
    [self.viewController stopGame];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Handle any background procedures not related to animation here.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Handle any foreground procedures not related to animation here.
}

- (void)dealloc
{
    [viewController release];
    [window release];
    
    [super dealloc];
}

@end
