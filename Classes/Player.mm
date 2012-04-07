//
//  Player.m
//  DragonEye
//
//  Created by alkaiser on 3/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Player.h"
#import "Loggers.h"
#import <Foundation/NSDictionary.h>
#import "ObjectContainer.h"

static CGPoint cgPoints[NUM_OF_DIRECTIONS]; 
static NSMutableDictionary * directionToOpposite = [NSMutableDictionary new];


@implementation Player

// Texture row indexes in the sprite sheet
static const uint STANDING_ROW_INDEX = 0; 
static const uint MOVEMENT_ROW_INDEX = 3;

//Private method
- (void) moveTowards:(Direction) dir{
	[self move:cgPoints[dir]];
}

+ (Character *) characterAtPosition:(CGPoint)position 
							   size:(CGSize)size 
						spriteSheet:(SpriteSheet *)spriteSheet {
	
	Player *player = [[Player alloc] init];
	
	player.position = position;
	player.size = size;
	player.sprite = spriteSheet;
	player.spsheetRowInd = STANDING_ROW_INDEX;
	player.spsheetColInd = 0;
	player.currentState = STOP_STATE;
	player.physicsEngine = [PhysicsEngine getInstance];
	
	//TODO: move to PropState.h
	[directionToOpposite setObject:[NSNumber numberWithInt:RIGHT] 
							forKey:[NSNumber numberWithInt:LEFT]]; 
	
	[directionToOpposite setObject:[NSNumber numberWithInt:LEFT] 
							forKey:[NSNumber numberWithInt:RIGHT]];
	
	[directionToOpposite setObject:[NSNumber numberWithInt:UP] 
							forKey:[NSNumber numberWithInt:DOWN]]; 
	[directionToOpposite setObject:[NSNumber numberWithInt:DOWN] 
							forKey:[NSNumber numberWithInt:UP]]; 
	
	[directionToOpposite setObject:[NSNumber numberWithInt:UP_RIGHT] 
							forKey:[NSNumber numberWithInt:DOWN_LEFT]];
	[directionToOpposite setObject:[NSNumber numberWithInt:DOWN_LEFT] 
							forKey:[NSNumber numberWithInt:UP_RIGHT]];
	
	[directionToOpposite setObject:[NSNumber numberWithInt:UP_LEFT] 
							forKey:[NSNumber numberWithInt:DOWN_RIGHT]]; 
	[directionToOpposite setObject:[NSNumber numberWithInt:DOWN_RIGHT] 
							forKey:[NSNumber numberWithInt:UP_LEFT]];
	
	[player startAnimation];
	
	//TODO: change to map?
	cgPoints[NO_WHERE]   = CGPointMake(0, 0);
	cgPoints[RIGHT]      = CGPointMake( 0.01f, 0); 
	cgPoints[LEFT]       = CGPointMake(-0.01f, 0); 
	cgPoints[UP]         = CGPointMake(0,       0.01f); 
	cgPoints[DOWN]       = CGPointMake(0,      -0.01f); 
	cgPoints[UP_RIGHT]   = CGPointMake( 0.01f,  0.01f); 
	cgPoints[UP_LEFT]    = CGPointMake(-0.01f,  0.01f); 
	cgPoints[DOWN_RIGHT] = CGPointMake( 0.01f, -0.01f); 
	cgPoints[DOWN_LEFT]  = CGPointMake(-0.01f, -0.01f); 
	
	return player;
}

- (void) startAnimation {
	CADisplayLink *aDisplayLink = [[CADisplayLink displayLinkWithTarget:self 
															   selector:@selector(animate)] 
								   retain];

	[aDisplayLink addToRunLoop:[NSRunLoop currentRunLoop] 
					   forMode:NSDefaultRunLoopMode];
	
	self.displayLink = aDisplayLink;
}

- (bool) hasSprite {
	return sprite != nil;
}

-(void) update {
	
	switch(self.currentState) {
		case MOVING_STATE:
			[self moveTowards:currentDirection];
			[self.displayLink setFrameInterval:2];
			break;
			
		default:
			[self.displayLink setFrameInterval:8];
			break;
	}
}

- (void) animate {
	if (spsheetColInd++ >= sprite.maxColumns - 1) {
		spsheetColInd = 0;
	}
}

- (void) draw {
	static const GLfloat squareVertices[] = {
        -0.1f,  0.1f,
         0.1f,  0.1f,
        -0.1f, -0.1f,
         0.1f, -0.1f,
    };
    
	CGPoint texCoords = [sprite getTextureCoordsWithRowInd:spsheetRowInd 
													colInd:spsheetColInd];
	const GLfloat textureVertices[] = {
        texCoords.x, texCoords.y,
        texCoords.x + sprite.sizeTexX, texCoords.y,
        texCoords.x,  texCoords.y + sprite.sizeTexY,
        texCoords.x + sprite.sizeTexX,  texCoords.y + sprite.sizeTexY,
    };
	
	glBindTexture(GL_TEXTURE_2D, sprite.sheet.textureId);
	
	//glUniform1i(ShaderConstants::uniforms[UNIFORM_TEXTURE_SAMPLER], 0);
	glUniform2f(ShaderConstants::uniforms[UNIFORM_TRANSLATE], position.x, position.y);
	glUniform2f(ShaderConstants::uniforms[UNIFORM_SCALE], size.width, size.height);
    glVertexAttribPointer(ATTRIB_VERTEX, 2, GL_FLOAT, GL_FALSE, 0, squareVertices);
    glEnableVertexAttribArray(ATTRIB_VERTEX);
    glVertexAttribPointer(ATTRIB_TEXTURE, 2, GL_FLOAT, GL_FALSE, 0, textureVertices);
    glEnableVertexAttribArray(ATTRIB_TEXTURE);
	
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);	
}

- (void) runTo:(Direction) dir {
	currentState = MOVING_STATE;
	currentDirection = dir;
	spsheetRowInd = MOVEMENT_ROW_INDEX;
	//don't reset spsheet.
}

- (void) stand {
	currentState = STOP_STATE;
	spsheetRowInd = STANDING_ROW_INDEX;
}

- (void) move:(CGPoint)movement {
	position.x += movement.x;
	position.y += movement.y;
}

// physics
- (void) resolveCollisions {
	if([physicsEngine isTheirACollision:self 
							  otherProp:[[ObjectContainer singleton] getObject:1]]) {
		
		[self moveTowards:(Direction)([[directionToOpposite objectForKey:[NSNumber 
																		  numberWithInt:currentDirection]] intValue])];
	}
}

@end
