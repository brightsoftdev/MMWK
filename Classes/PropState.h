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

typedef enum {
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
