//
//  CoordinateSystem.m
//  DragonEye
//
//  Created by Mark Mikhail on 4/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CoordinateSystem.h"
#import "PolarCoordinates.h"
#import "Loggers.h"

@implementation CoordinateSystem
@synthesize width, height;

static Direction indexToDirection[MAX_DIRECTIONS + 1];
static BOOL withinCenterOfDPad(float, float, float);

//Private Method (alternative style for private fxns; although there's no clean way of doing private methods
//in Objective-C)
- (id) init:(NSInteger)imgWidth imgHeight:(NSInteger)imgHeight {
	
	if (self = [super init]) {
		self.width  = imgWidth / 2;
		self.height = imgHeight / 2;
	}
	return self;
	
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

- (Direction) decideDirectionFromCartestian:(CGFloat)xCoordinate 
								yCoordinate:(CGFloat)yCoordinate {
	
	//normalize x to origin by subtracting it
	CGFloat pointX = xCoordinate - self.width;
	//normalize y to origin by flipping substraction
	CGFloat pointY = self.height - yCoordinate;
	
	//find radius using pythag. d thm
	CGFloat radius = PYTHAG(self.width, self.height);
	
	CGFloat degrees = 0; 
	
	NSNumber * angle = [NSNumber numberWithFloat:atan2f(pointY, pointX)];
    degrees = TO_DEGREES([angle floatValue]);
	degrees += UP_RIGHT_DIRECTION_STARTS_AT_DEGREE;
	
	if (degrees < 0) {
		degrees += FULL_CYCLE_IN_DEGREES;
	}
	
	if (withinCenterOfDPad(pointX, pointY, radius)) {
		return NO_WHERE;
		
	} else {
		//This will find the correct direction to go to including diagonals.
	    NSInteger index = ((int) degrees) / DEGREES_PER_DIRECTION;
		return indexToDirection[index];
	}
}

@end

static BOOL withinCenterOfDPad(CGFloat pointX, CGFloat pointY, CGFloat radius) {
	
	float radiusPrime = RADIUS_PCT_TO_STAND_STILL_IN_CENTER * radius;
	return fabsf(pointX) < radiusPrime && fabsf(pointY) < radiusPrime;
}
