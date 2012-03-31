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
	int currentDirection;
	Sprite *sprite;
}

@property (nonatomic, assign) CGPoint position;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, retain) Sprite *sprite;
@property (nonatomic, assign) PlayerState currentState;

+ (Player *) playerAtPosition:(CGPoint)position withSize:(CGSize)size;

- (void) initSprite:(Sprite *)spriteParam;
- (bool) hasSprite;
- (void) animate;
- (void) draw;

// Actions
- (void) startMoving:(int) dir;
- (void) stopMoving;
- (void) moveTowards:(int) dir;
- (void) move:(CGPoint)movement;

@end
