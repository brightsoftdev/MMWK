//
//  CoordinateSystem.h
//  DragonEye
//
//  Created by Mark Mikhail on 4/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PropState.h"

//Tweak these parameters to get the feel of the joystick/dpad correct.
//TODO: these can be made as parameters to a setter or a factory method.
#define DEGREES_PER_DIRECTION 45
#define UP_RIGHT_DIRECTION_STARTS_AT_DEGREE 25
#define RADIUS_PCT_TO_STAND_STILL_IN_CENTER 0.20

@interface CoordinateSystem : NSObject {
	//TODO: generalize these names
	NSInteger dPadWidth;
	NSInteger dPadHeight;
}

@property (nonatomic, assign) NSInteger dPadWidth;
@property (nonatomic, assign) NSInteger dPadHeight;


+ (CoordinateSystem *) initWithDimensions:(NSInteger)imgWidth
								imgHeight:(NSInteger)imgHeight;

- (Direction) decideDirectionFromCartestian:(float) xCoordinate
								yCoordinate:(float) yCoordinate;


@end
