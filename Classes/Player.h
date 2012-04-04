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
#import "GraphicsEngine.h"
#import "GraphicsContext.h"

@interface Player : NSObject <GraphicsContext> {
	CGPoint position;
	CGSize size;
	
	PlayerState currentState;
	Direction currentDirection;
	Orientation currentOrientation;
	
	SpriteSheet *sprite;
	CADisplayLink *displayLink;
	
	// Current matrix index in the sprite sheet
	uint spsheetRowInd, spsheetColInd;
}

@property (nonatomic, assign) PlayerState currentState;
@property (nonatomic, assign) Direction currentDirection;
@property (nonatomic, assign) Orientation currentOrientation;
@property (nonatomic, assign) CGPoint position;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, retain) SpriteSheet *sprite;
@property (nonatomic, assign) uint spsheetRowInd, spsheetColInd;
@property (nonatomic, retain) CADisplayLink *displayLink;

+ (Player *) playerAtPosition:(CGPoint)position 
						 size:(CGSize)size 
				  spriteSheet:(SpriteSheet *)spriteSheet;

- (void) startAnimation;
- (bool) hasSprite;

// from GraphicsContext protocol
- (void) draw;
- (void) update;
- (void) animate;


// Actions
- (void) stand;
- (void) runTo:(Direction) dir;
- (void) move:(CGPoint)movement;

@end
