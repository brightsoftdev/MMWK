//
//  CoordinateSystem.m
//  DragonEye
//
//  Created by Mark Mikhail on 4/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CoordinateSystem.h"
#import "macros.h"
#import "Loggers.h"

@implementation CoordinateSystem
@synthesize dPadWidth, dPadHeight;

static Direction indexToDirection[COMPASS_DIRECTIONS + 1];
static BOOL withinCenterOfDPad(float, float, float);

//Private Method (alternative style for private fxns; although there's no clean way of doing private methods
//in Objective-C)
- (id) init:(NSInteger)imgWidth imgHeight:(NSInteger)imgHeight {
	
	if (self = [super init]) {
		self.dPadWidth = imgWidth / 2;
		self.dPadHeight = imgHeight / 2;
		return self;
	}
	return nil;
	
}

+ (CoordinateSystem *) initWithDimensions:(NSInteger)imgWidth 
								imgHeight:(NSInteger)imgHeight {
	
	//Data-driven technique to get direction from degrees
	//start counter-clock wise, and have the 0th index be the RIGHT direction
	//and wrap around back to the RIGHT direction on the last index.
	//TODO: initialize this only once.
	indexToDirection[0] = RIGHT;
	indexToDirection[1] = UP_RIGHT;
	indexToDirection[2] = UP;
	indexToDirection[3] = UP_LEFT;
	indexToDirection[4] = LEFT;
	indexToDirection[5] = DOWN_LEFT;
	indexToDirection[6] = DOWN;
	indexToDirection[7] = DOWN_RIGHT;
	indexToDirection[8] = RIGHT;
	
	CoordinateSystem * coordinateSystem = [[CoordinateSystem alloc] init:imgWidth 
															   imgHeight:imgHeight];
	[coordinateSystem autorelease];
	return coordinateSystem;
	
}

- (Direction) decideDirectionFromCartestian:(float)xCoordinate 
								yCoordinate:(float)yCoordinate {
	
	//normalize x to origin by subtracting it
	float pointX = xCoordinate - self.dPadWidth;
	//normalize y to origin by flipping substraction
	float pointY = self.dPadHeight - yCoordinate;
	
	//find radius using pythagarus thm
	float radius = sqrt(pow(self.dPadWidth, 2) + pow(self.dPadHeight, 2));
	double degrees = 0; 

	DLOG("point x: %lf, point y: %lf", pointX, pointY);
	
	NSNumber * angle = [NSNumber numberWithFloat:atan(pointY / pointX)];

	if(FIRST_QUADRANT(pointX, pointY)) {
		degrees = TO_DEGREES([angle floatValue]);
		
	} else if(SECOND_QUADRANT(pointX, pointY) || 
			  THIRD_QUADRANT(pointX, pointY)) {
		degrees = TO_DEGREES([angle floatValue]) + HALF_CYCLE_IN_DEGREES;
		
	} else {
		degrees = TO_DEGREES([angle floatValue]) + FULL_CYCLE_IN_DEGREES;
	}
	
	DLOG("Polar in degrees: ?= %lf\n", degrees);

	if (withinCenterOfDPad(pointX, pointY, radius)) {
		//do nothing, because we are to close to the center of the dpad.
		return NO_WHERE;
		
	} else if (pointX < 0 && pointY == 0) {
		return LEFT;
		
	} else if (pointX == 0 && pointY < 0) {
		return DOWN;
		
	} else if (pointX == 0 && pointY > 0) {
		return UP;
		
	} else if (pointX == 0 && pointY > 0) {
		return RIGHT;
		
	} else {
		//This will find the correct direction to go to including diagonals.
		int index = (degrees + (DEGREES_PER_DIRECTION - UP_RIGHT_DIRECTION_STARTS_AT_DEGREE)) / DEGREES_PER_DIRECTION;
		return indexToDirection[index];
	}
}

@end

static BOOL withinCenterOfDPad(float pointX, float pointY, float radius) {
	float radiusPrime = RADIUS_PCT_TO_STAND_STILL_IN_CENTER * radius;
	return abs(pointX) < radiusPrime && abs(pointY) < radiusPrime;
}
