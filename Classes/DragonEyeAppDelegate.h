//
//  DragonEyeAppDelegate.h
//  DragonEye
//
//  Created by alkaiser on 2/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameController;

@interface DragonEyeAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    GameController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet GameController *viewController;

@end

