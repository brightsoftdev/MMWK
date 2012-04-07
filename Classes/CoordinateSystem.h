//
//  CoordinateSystem.h
//  DragonEye
//
//  Created by Mark Mikhail on 4/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PropState.h"

//Tweak these parameters to get the feel of the joystick/dpad correct.
//TODO: these can be made as parameters to a setter or a factory method.

static const int DEGREES_PER_DIRECTION				   = 45;
static const int UP_RIGHT_DIRECTION_STARTS_AT_DEGREE   = 25;
static const float RADIUS_PCT_TO_STAND_STILL_IN_CENTER = 0.20f;

@interface CoordinateSystem : NSObject {
	NSInteger width;
	NSInteger height;
}

@property (nonatomic, assign) NSInteger width;
@property (nonatomic, assign) NSInteger height;


+ (CoordinateSystem *) initWithDimensions:(NSInteger)imgWidth
								imgHeight:(NSInteger)imgHeight;

- (Direction) decideDirectionFromCartestian:(float) xCoordinate
								yCoordinate:(float) yCoordinate;


@end
