//
//  Player.m
//  DragonEye
//
//  Created by alkaiser on 3/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Player.h"

@implementation Player

@synthesize position, size, sprite;

+ (Player *) playerAtPosition:(CGPoint)position withSize:(CGSize)size {
	Player *player = [[Player alloc] init];
	player.position = position;
	player.size = size;
	return player;
}

- (void) initSprite:(Sprite *)spriteParam {
	self.sprite = spriteParam;
}

- (bool) hasSprite {
	return sprite != nil;
}

- (void) animate {
	switch(currentState) {
		case MOVING_STATE:
			[self moveTowards:currentDirection];
			break;
			
		default:
			break;
	}
}

- (void) draw {
	static const GLfloat squareVertices[] = {
        -0.1f, 0.1f,
        0.1f, 0.1f,
        -0.1f, -0.1f,
        0.1f,  -0.1f,
    };
    
    static const GLfloat textureVertices[] = {
        0.0f, 0.0f,
        1.0f, 0.0f,
        0.0f,  1.0f,
        1.0f,  1.0f,
    };
	
	glBindTexture(GL_TEXTURE_2D, [self.sprite getActiveTexture].textureId);
	
	//glUniform1i(ShaderConstants::uniforms[UNIFORM_TEXTURE_SAMPLER], 0);
	glUniform2f(ShaderConstants::uniforms[UNIFORM_TRANSLATE], position.x, position.y);
	glUniform2f(ShaderConstants::uniforms[UNIFORM_SCALE], size.width, size.height);
    glVertexAttribPointer(ATTRIB_VERTEX, 2, GL_FLOAT, GL_FALSE, 0, squareVertices);
    glEnableVertexAttribArray(ATTRIB_VERTEX);
    glVertexAttribPointer(ATTRIB_TEXTURE, 2, GL_FLOAT, GL_FALSE, 0, textureVertices);
    glEnableVertexAttribArray(ATTRIB_TEXTURE);
	
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);	
}

- (void) startMoving:(Direction) dir {
	currentState = MOVING_STATE;
	currentDirection = dir;
}

- (void) stopMoving {
	currentState = STOP_STATE;
}

- (void) moveTowards:(Direction) dir{
	switch(dir) {
		case RIGHT:
		    [self move:CGPointMake(0.01f, 0)];
		    break;
			 
		case LEFT:
			[self move:CGPointMake(-0.01f, 0)];
			break;
			 
		default:
			break;	 
	}
}

- (void) move:(CGPoint)movement {
	position.x += movement.x;
	position.y += movement.y;
}

@end
