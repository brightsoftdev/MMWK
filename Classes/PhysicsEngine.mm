//
//  PhysicsEngine.m
//  DragonEye
//
//  Created by Mark Mikhail on 4/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PhysicsEngine.h"
#import "PolarCoordinates.h"
#import "Loggers.h"
#import "ObjectContainer.h"
#import "Typedefs.h"
#import "RunTimeWrapper.h"

static PhysicsEngine * physicsEngine = nil;
static int count = 0;
static void debug(Prop*, Prop*, CGFloat, CGFloat, CGFloat);
										  
@implementation PhysicsEngine

+ (PhysicsEngine *) getInstance {
	
	if (physicsEngine == nil) {
		physicsEngine = [[PhysicsEngine alloc] init];
	}
	return physicsEngine;
}

	
/**
 * Are we outside the screen?
 */
- (void) detectScreenCollision:(Prop *)prop {
	
	CGFloat radius = PYTHAG(prop.size.width / 2.0f,
							prop.size.height / 2.0f);
							 
	BOOL isWithinLevelBoundary = 
								prop.position.x - radius >= -1 && 
								prop.position.x + radius <= 1  &&
								prop.position.y - radius >= -1 &&
								prop.position.y + radius <= 1;
	
	if (!isWithinLevelBoundary) {
		SEL backgroundCallback = NSSelectorFromString(@"collidesWithScreen");
		[prop performSelector:backgroundCallback];
	}
}
	
/**
 * Circle 2 Circle detection collision
 */
- (void) detectCircleCollision:(Prop *) prop 
					 otherProp:(Prop *) otherProp {
	
	Center center  =  { prop.position.x, 
						prop.position.y };
	
	Center center2 =  { otherProp.position.x, 
						otherProp.position.y };
	
	CGFloat distance = PYTHAG(center.origin.x - center2.origin.y,
							  center.origin.y - center2.origin.y);

	CGFloat radius1  = PYTHAG(prop.size.width / 2.0,
							  prop.size.height / 2.0);
							 
	CGFloat radius2  = PYTHAG(otherProp.size.width / 2.0,
							  otherProp.size.height / 2.0);
		
	if(distance <= (radius1 + radius2)) {
		[RunTimeWrapper callWithNoArgs:@"collidesWith" 
								object:prop];
	}
}

/**
 * Rectangle 2 Rectangle Collision detection
 */

- (void) detectRectangleCollision:(Prop *)prop 
					    otherProp:(Prop *)otherProp {
	
	Rectangle rectA, rectB;
	
	rectA.topLeft.x = prop.position.x - prop.size.width;
	rectA.topLeft.y = prop.position.y + prop.size.height; 
	
	rectA.bottomRight.x = prop.position.x + prop.size.width;
	rectA.bottomRight.y = prop.position.y - prop.size.height;
	
	rectB.topLeft.x = otherProp.position.x - otherProp.size.width;
	rectB.topLeft.y = otherProp.position.y + otherProp.size.height;
	
<<<<<<< Updated upstream
	//debug(center, center2, radius1, radius2, distance);
=======
	rectB.bottomRight.x = otherProp.position.x + otherProp.size.width;
	rectB.bottomRight.y = otherProp.position.y - otherProp.size.height;
>>>>>>> Stashed changes
	
	BOOL notColliding = rectA.topLeft.x >= rectB.bottomRight.x ||
						rectA.topLeft.y <= rectB.bottomRight.y ||
						rectB.topLeft.x >= rectA.bottomRight.x ||
						rectB.topLeft.y <= rectA.bottomRight.y;
	
	if(!notColliding) {		
		[RunTimeWrapper callWithNoArgs:@"collidesWith" 
								object:prop];
	}
}

/**
 * Pixel 2 Pixel Collision detection
 */
- (void) detectPixelCollision:(Prop *)prop 
					otherProp:(Prop *)otherProp {
	
	
	
}
//private functions below

static void debug(Prop * prop1, 
				  Prop * prop2, 
				  CGFloat radius1, 
				  CGFloat radius2, 
				  CGFloat distance) {
	
	count++;
	
	if(count % 120 == 0) {
		
		//DLOG("Previous position of p1 (%lf,%lf)", prop1.prevPosition.x, prop1.prevPosition.y);
		//DLOG("Previous position of p2 (%lf,%lf)", prop2.prevPosition.x, prop2.prevPosition.y);
		
		DLOG("Current position of p1 (%lf,%lf)", 
			 prop1.position.x, 
			 prop1.position.y);
		
		DLOG("Current position of p2 (%lf,%lf)", 
			 prop2.position.x, 
			 prop2.position.y);
		
		DLOG("radius1 %lf", radius1);
		DLOG("radius2 %lf", radius2);
		DLOG("distance ?= %lf", distance);
		DLOG("are we colliding? %d\n", distance <= (radius1 + radius2));
	}
}


@end
