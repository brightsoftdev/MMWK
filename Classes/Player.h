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
#import "ShaderConstants.h"
#import "PropState.h"
#import "Typedefs.h"
#import "Sprite.h"

@interface Player : NSObject {
	CGPoint position;
	CGSize size;
	PlayerState currentState;
	Direction currentDirection;
	Sprite *sprite;
}

@property (nonatomic, assign) CGPoint position;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, retain) Sprite *sprite;

+ (Player *) playerAtPosition:(CGPoint)position withSize:(CGSize)size;

- (void) initSprite:(Sprite *)spriteParam;
- (bool) hasSprite;
- (void) animate;
- (void) draw;

// Actions
- (void) startMoving:(Direction) dir;
- (void) stopMoving;
- (void) moveTowards:(Direction) dir;
- (void) move:(CGPoint)movement;

@end
