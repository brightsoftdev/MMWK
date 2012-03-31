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

#define LEFT  0x01
#define RIGHT 0x02
#define UP    0x04
#define DOWN  0x08

typedef enum {
	MOVING_STATE,
	STOP_STATE
} PlayerState;

#endif
