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
#import "Character.h"
#import "GraphicsEngine.h"

@interface Player : Character<PhysicsContext> {
	

}

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
- (void) resolveCollisions;

+ (Character *) characterAtPosition:(CGPoint)position 
							   size:(CGSize)size 
						spriteSheet:(SpriteSheet *)spriteSheet;

@end
