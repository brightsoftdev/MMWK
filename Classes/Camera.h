//
//  Camera.h
//  DragonEye
//
//  Created by Mark Mikhail on 4/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Typedefs.h"
#import "Character.h"

//1 <= x <= 80 roughly
static const NSUInteger DISTANCE_FROM_RIGHT_TO_ADVANCE_FRAME = 50;

@interface Camera : NSObject {

	PositiveDimension frameDimension;
	Boundary frameBoundary;
	Character * mainPlayer;
	BOOL lockCamera;

}

@property (nonatomic, assign) PositiveDimension frameDimension;
@property (nonatomic, assign) Boundary frameBoundary;
@property (nonatomic, assign) Character * mainPlayer;
@property (nonatomic, assign, getter=isLocked) BOOL lockCamera;

/**
 *
 * Initializes the camera with the mainPlayer a
 * default frame dimension of 100x100 (width = 100, height = 100)
 *
 * @return single instance of Camera
 */
+ (Camera *) getInstance;

/**
 * Initializes the camera with user-specified frame dimension
 *
 * @return single instance of WorldCoordinates
 */
+ (Camera *) getInstance:(PositiveDimension) positiveDimension;


@end
