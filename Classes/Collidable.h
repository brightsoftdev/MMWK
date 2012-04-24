//
//  Collidable.h
//  DragonEye
//
//  Created by Mark Mikhail on 4/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

@protocol Collidable <NSObject>

/**
 * Every collidable object should decide what other objects
 * it can collide with.
 *
 * Please use the physicsEngine detectCollisions method
 * for each object you decide that you can collide with.
 *
 * @return void
 */
- (void) resolveCollisions;

@end
