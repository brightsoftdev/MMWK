//
//  Player.h
//  DragonEye
//
//  Created by alkaiser on 3/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import <QuartzCore/QuartzCore.h>
#import "ShaderConstants.h"
#import "PropState.h"
#import "Typedefs.h"
#import "SpriteSheet.h"

//Under review
#import "PhysicsContext.h"
#import "PhysicsEngine.h"
#import "Prop.h"

@class PhysicsEngine;

@interface Player : Prop <PhysicsContext> {
	
	PhysicsEngine * physicsEngine;
	
	PlayerState currentState;
	Direction currentDirection;
	SpriteSheet *sprite;
	CADisplayLink *displayLink;
	
	// Current matrix index in the sprite sheet
	uint spsheetRowInd, spsheetColInd;
}

@property (nonatomic, assign) PlayerState currentState;
@property (nonatomic, assign) CGPoint position;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, retain) SpriteSheet *sprite;
@property (nonatomic, assign) uint spsheetRowInd, spsheetColInd;
@property (nonatomic, assign) CADisplayLink *displayLink;
@property (nonatomic, retain) PhysicsEngine *physicsEngine;

+ (Player *) playerAtPosition:(CGPoint)position 
						 size:(CGSize)size 
				  spriteSheet:(SpriteSheet *)spriteSheet;

- (void) startAnimation;
- (bool) hasSprite;
- (void) update;
- (void) animate;
- (void) draw;

// Actions
- (void) stand;
- (void) runTo:(Direction) dir;
- (void) move:(CGPoint)movement;
- (void) resolveCollisions;
@end
