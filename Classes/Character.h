//
//  Character.h
//  DragonEye
//
//  Created by Mark Mikhail on 4/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Prop.h"
#import "PropState.h"
#import "PhysicsEngine.h"
#import "SpriteSheet.h"

@interface Character : Prop {
	
	PhysicsEngine * physicsEngine;
	
	PlayerState currentState;
	Direction currentDirection;
	Orientation currentOrientation;
	SpriteSheet *sprite;
	CADisplayLink *displayLink;
	
	// Current matrix index in the sprite sheet
	uint spsheetRowInd, spsheetColInd;
}

@property (nonatomic, assign) PlayerState currentState;
@property (nonatomic, retain) SpriteSheet *sprite;
@property (nonatomic, assign) uint spsheetRowInd, spsheetColInd;
@property (nonatomic, assign) CADisplayLink *displayLink;
@property (nonatomic, retain) PhysicsEngine *physicsEngine;
@property (nonatomic, assign) Direction currentDirection;
@property (nonatomic, assign) Orientation currentOrientation;


@end
