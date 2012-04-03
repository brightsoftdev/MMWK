//
//  untitled.m
//  DragonEye
//
//  Created by alkaiser on 4/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PropState.h"

bool isDirectionRight(Direction direction) {
	return direction == UP_RIGHT || 
	direction == RIGHT ||
	direction == DOWN_RIGHT;
}

bool isDirectionLeft(Direction direction) {
	return direction == UP_LEFT || 
	direction == LEFT || 
	direction == DOWN_LEFT;
}

// TODO: Only handle LEFT and RIGHT directions
Orientation getOrientationFromDirection(Direction direction) {
	if (isDirectionLeft(direction)) {
		return ORIENTATION_BACKWARDS;
	} else {
		return ORIENTATION_FORWARD;
	}
}
