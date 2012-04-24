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
#import "Camera.h"


static PhysicsEngine * physicsEngine = nil;
static Camera * camera = [Camera getInstance];

@implementation PhysicsEngine

//private functions below

+ (void) debug:(Prop *) prop1 
		 prop2:(Prop *) prop2 
	   radius1:(CGFloat) radius1
	   radius2:(CGFloat) radius2 
	  distance:(CGFloat) distance {
	
	TLOG("Current position of p1 (%lf,%lf)", 
		 prop1.position.x, 
		 prop1.position.y);
	
	TLOG("Current position of p2 (%lf,%lf)", 
		 prop2.position.x, 
		 prop2.position.y);
	
	TLOG("radius1 %lf", radius1);
	TLOG("radius2 %lf", radius2);
	TLOG("distance ?= %lf", distance);
	//TLOG("are we colliding? %d\n", distance <= (radius1 + radius2));
	
}

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
		//TODO: this should not be radius / 2, but just radius
		prop.position.x - (radius / 2) > camera.frameBoundary.left &&
		//Add a way to open/close right boundary
		//prop.position.x + radius <= 1  &&
		prop.position.y - (radius / 2) >= 0 &&
		prop.position.y + (radius / 2) <= 100;
	
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
	
	CGFloat distance = PYTHAG(center.origin.x - center2.origin.x,
							  center.origin.y - center2.origin.y);

	CGFloat radius1  = PYTHAG(prop.size.width / 2.0,
							  prop.size.height / 2.0);
							 
	CGFloat radius2  = PYTHAG(otherProp.size.width / 2.0,
							  otherProp.size.height / 2.0);
		
	/*[PhysicsEngine debug:prop
				   prop2:otherProp 
				 radius1:radius1
				 radius2:radius2 
				distance:distance];
	*/	
	if(distance <= (radius1 + radius2)) {
		[RunTimeWrapper callWithNoArgs:@"collidesWith" 
								object:prop];
	}
}

/**b
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
	
	rectB.bottomRight.x = otherProp.position.x + otherProp.size.width;
	rectB.bottomRight.y = otherProp.position.y - otherProp.size.height;
	
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


- (void) detectStageAdvance:(Prop *)prop {
	BOOL isScreenAdvance  = false; //prop.position.x >= [WorldCoordinates getInstance].frameBoundary.right / 2;
	BOOL isScreenPrevious = false; //prop.position.x <= 0.0;
	
	
	/*
	if(isScreenAdvance) {
		SEL backgroundCallback = NSSelectorFromString(@"collidesWithStageForward");
		[prop performSelector:backgroundCallback];
	
	} else if(isScreenPrevious) {
		SEL backgroundCallback = NSSelectorFromString(@"collidesWithStageReverse");
		[prop performSelector:backgroundCallback];
	
	}*/
}

@end
