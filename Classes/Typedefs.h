/*
 *  Typedefs.h
 *  DragonEye
 *
 *  Created by alkaiser on 3/10/12.
 *  Copyright 2012 __MyCompanyName__. All rights reserved.
 *
 */

#ifndef TYPEDEFS_H
#define TYPEDEFS_H

typedef unsigned int uint;

typedef struct Center {
	
	CGPoint origin;
	
} Center;


typedef struct Rectangle {
	
	CGPoint topLeft;
	CGPoint bottomRight;
	
} Rectangle;

/**
 * Positive dimensions
 */
typedef struct PositiveDimension {
	
	NSUInteger width;
	NSUInteger height;
	
} PositiveDimension;

/**
 * Denotes Game boundaries
 */

typedef struct Boundary {
	
	NSUInteger left;
	NSUInteger right;
	
} Boundary;

typedef struct Coordinate {
	
	NSInteger x;
	NSInteger y;
	
} Coordinate;

#endif