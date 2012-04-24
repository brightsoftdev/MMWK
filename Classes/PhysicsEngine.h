//
//  PhysicsEngine.h
//  DragonEye
//
//  Created by Mark Mikhail on 4/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhysicsContext.h"
#import "Prop.h"

/**
 * The Physics Engine
 */
@interface PhysicsEngine : NSObject {
	
}

+ (PhysicsEngine *) getInstance;

/**
 * Sketches a circle around both props and determine if they are colliding
 *
 * if the props are colliding then
 *   [prop collidesWith"Type"] is executed
 * Type is is the runtime type of the 1st parameter which is "prop"
 *
 * @param prop - the first prop
 * @param otherProp - the prop we are colliding with.
 * @return void	
 */
- (void) detectCircleCollision:(Prop *) prop
					 otherProp:(Prop *) otherProp;

/**
 * Sketches a rectangle around both props and determine if they are colliding
 *
 * @param prop - the first prop
 * @param otherProp - the prop we are colliding with.
 * @return void
 */
- (void) detectRectangleCollision:(Prop *) prop
						otherProp:(Prop *) otherProp;

/**
 * Look up the collision map for each prop, and see if they are 
 * colliding. We use the alpha byte to see if part of the props
 * are colliding.
 *
 * @param prop - the first prop
 * @param otherProp - the prop we are colliding with.
 * @return void
 */
- (void) detectPixelCollision:(Prop *) prop 
					otherProp:(Prop *) otherProp;
/**
 * Is the prop going outside the iphone screen?
 * 
 * @param prop - in most cases, this would be the main player.
 * @return void
 */
- (void) detectScreenCollision:(Prop *) prop;


@end
