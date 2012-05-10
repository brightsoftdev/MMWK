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
#import "SpriteSheet.h"
#import "Character.h"
#import "GraphicsEngine.h"

@interface Player : Character<Collidable> {
	
	
}

+ (Player *) create:(CGPoint)position 
			   size:(CGSize)size 
		spriteSheet:(SpriteSheet *)spriteSheet;

- (void) resolveCollisions;

// collision reactions
- (void) collidesWithPlayer;
- (void) collidesWithScreen;



@end
