//
//  PhysicsEngine.h
//  DragonEye
//
//  Created by Mark Mikhail on 4/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhysicsContext.h"
#import "Player.h"
#import "Prop.h"

@interface PhysicsEngine : NSObject {
	
}

+ (PhysicsEngine *) getInstance;
- (BOOL) isTheirACollision:(Prop *)prop1 
				 otherProp:(Prop *)otherProp;

//resolve collisions
// -- prop (enemy against player), -- zone (level/stage advance)
//gravity for all enemies
//force against player/enemies
//projectile motion ?

@end
