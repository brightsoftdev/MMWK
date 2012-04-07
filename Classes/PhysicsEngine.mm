//
//  PhysicsEngine.m
//  DragonEye
//
//  Created by Mark Mikhail on 4/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PhysicsEngine.h"
#import "Loggers.h"
#import "ObjectContainer.h"
#import "Typedefs.h"

static PhysicsEngine * physicsEngine = NULL;
static int count = 0;
static void debug(Center, Center, float, float, float);


@implementation PhysicsEngine

+ (PhysicsEngine *) getInstance {
	
	if (physicsEngine == NULL) {
		physicsEngine = [[PhysicsEngine alloc] init];
	}
	return physicsEngine;
}

- (BOOL) isWithinBoundary:(float) radius1 
				 thisProp:(Prop*) prop {
	
	return	prop.position.x - radius1 > -1 && 
			prop.position.x + radius1 < 1  &&
			prop.position.y - radius1 > -1 &&
			prop.position.y + radius1 < 1;
	
	
}

//TODO: refactor this.
- (BOOL) isTheirACollision:(Prop *) prop 
				 otherProp:(Prop *) otherProp {
	
	Center center  =  { prop.position.x, prop.position.y };
	Center center2 =  { otherProp.position.x, otherProp.position.y };
	
	float distance = sqrt(
						 pow((center.x - center2.x), 2) +
						 pow((center.y - center2.y), 2)
						);
	
	float radius1 = sqrt(
						 pow((prop.size.width * 0.1f / 2.0), 2) + 
						 pow((prop.size.height * 0.1f / 2.0), 2)
						);
	
	float radius2 = sqrt(
						 pow((otherProp.size.width * 0.1f / 2.0), 2) + 
						 pow((otherProp.size.height * 0.1f / 2.0), 2)
						);
	
	debug(center, center2, radius1, radius2, distance);
	
	if(distance <= (radius1 + radius2)) {
		if(count % 180 == 0) {
			DLOG("Collision!!!");
		}
		return ![self isWithinBoundary:radius1 thisProp:prop] || YES;
	}
	return ![self isWithinBoundary:radius1 thisProp:prop] || NO;

}

static void debug(Center center, Center center2, float radius1, float radius2, float distance) {
	
	count++;
	
	if(count % 60 == 0) {
		
		DLOG("Center of p1 (%lf,%lf)", center.x, center.y);
		DLOG("Center of p2 (%lf,%lf)", center2.x, center2.y);
		DLOG("radius1 %lf", radius1);
		DLOG("radius2 %lf", radius2);
		DLOG("distance ?= %lf", distance);
		DLOG("are we colliding? %d\n", distance <= (radius1 + radius2));
	}
}


@end
