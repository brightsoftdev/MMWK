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

static const NSInteger DEGREES_PER_DIRECTION			   = 45;
static const NSInteger UP_RIGHT_DIRECTION_STARTS_AT_DEGREE = 25;
static const CGFloat RADIUS_PCT_TO_STAND_STILL_IN_CENTER   = 0.20f;

@interface CoordinateSystem : NSObject {
	NSInteger width;
	NSInteger height;
}

@property (nonatomic, assign) NSInteger width;
@property (nonatomic, assign) NSInteger height;


/**
 * Sets up a simple 2D coordinate system.
 * NOTE: this mainly used by the dpad/joystick, but could possibly 
 * be used for A.I.
 *
 * @param imgWidth - width of object
 * @param imgHeight - height of object
 * @return CoordinateSystem
 *
 */
+ (CoordinateSystem *) initWithDimensions:(NSInteger)imgWidth
								imgHeight:(NSInteger)imgHeight;

/**
 * Given a point (x,y) relative to the coordinate system,
 * it will specify which direction the point is in.
 *
 * Example:
 *   If one hits the point between the up-arrow and right-arrow 
 *   on the dpad (a coordinate system), it will return UP_RIGHT direction
 *   
 * @param xCoordinate - x coordinate
 * @param yCoordinate - y coordinate
 * @return Direction 
 */
- (Direction) decideDirectionFromCartestian:(CGFloat) xCoordinate
								yCoordinate:(CGFloat) yCoordinate;


@end
