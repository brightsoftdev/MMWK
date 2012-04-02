/*
 *  PropState.h
 *  DragonEye
 *
 *  Created by alkaiser on 3/21/12.
 *  Copyright 2012 __MyCompanyName__. All rights reserved.
 *
 */
#ifndef PROP_STATE_H
#define PROP_STATE_H

#define NUM_OF_DIRECTIONS 9
#define COMPASS_DIRECTIONS 8

typedef enum {
	NO_WHERE,
	UP,
	DOWN,
	LEFT,
	RIGHT,
	UP_LEFT,
	UP_RIGHT,
	DOWN_LEFT,
	DOWN_RIGHT
} Direction;

typedef enum {
	MOVING_STATE,
	STOP_STATE
} PlayerState;

#endif
