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

static CGPoint cgPoints[NUM_OF_DIRECTIONS]; 

@implementation Player


@synthesize position, size, sprite, spsheetRowInd, spsheetColInd, displayLink, 
			currentState, currentDirection, currentOrientation;

// Texture row indexes in the sprite sheet
static const uint STANDING_ROW_INDEX = 0; 
static const uint MOVEMENT_ROW_INDEX = 3;
static const uint MAX_COLUMNS = 8;

//Private method
- (void) moveTowards:(Direction) dir{
	[self move:cgPoints[dir]];
}

+ (Player *) playerAtPosition:(CGPoint)position size:(CGSize)size spriteSheet:(SpriteSheet *)spriteSheet {
	Player *player = [[Player alloc] init];
	player.position = position;
	player.size = size;
	player.sprite = spriteSheet;
	player.spsheetRowInd = STANDING_ROW_INDEX;
	player.spsheetColInd = 0;
	player.currentState = STOP_STATE;
	player.currentDirection = RIGHT;
	player.currentOrientation = ORIENTATION_FORWARD;
	
	[player startAnimation];
		
	//change to map, and use enum.
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
	//[self.displayLink setFrameInterval:4];
	[aDisplayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
	self.displayLink = aDisplayLink;
}

- (bool) hasSprite {
	return sprite != nil;
}

-(void) update {
	switch(currentState) {
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
	if (spsheetColInd++ >= MAX_COLUMNS) {
		spsheetColInd = 0;
	}
}

- (void) draw {
	[GraphicsEngine drawCharacter:self];
}

- (void) runTo:(Direction) dir {
	currentState = MOVING_STATE;
	currentDirection = dir;
	
	if (currentDirection != UP && currentDirection != DOWN) {
		currentOrientation = getOrientationFromDirection(currentDirection);
	}
	
	spsheetRowInd = MOVEMENT_ROW_INDEX;
}

- (void) stand {
	currentState = STOP_STATE;
	spsheetRowInd = STANDING_ROW_INDEX;
}

- (void) move:(CGPoint)movement {
	position.x += movement.x;
	position.y += movement.y;
}

@end
