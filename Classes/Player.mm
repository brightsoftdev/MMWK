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

//TODO: move these to a better location
static CGPoint cgPoints[MAX_DIRECTIONS]; 
static NSMutableDictionary * directionToOpposite = [NSMutableDictionary new];

@implementation Player

@synthesize distanceTraveled;

// Texture row indexes in the sprite sheet
static const uint STANDING_ROW_INDEX = 0; 
static const uint MOVEMENT_ROW_INDEX = 3;

//Private method
- (void) moveTowards:(Direction) dir{
	[self move:cgPoints[dir]];
}

+ (Character *) characterAtPosition:(CGPoint) position 
							   size:(CGSize)size 
						spriteSheet:(SpriteSheet *)spriteSheet {
	
	Player *player = [[Player alloc] init];
	
	player.position = position;
	player.size = size;
	player.sprite = spriteSheet;
	player.spsheetRowInd = STANDING_ROW_INDEX;
	player.spsheetColInd = 0;
	player.currentState = STOP_STATE;
	player.currentDirection = RIGHT;
	player.currentOrientation = ORIENTATION_FORWARD;
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
	cgPoints[NO_WHERE]   = CGPointMake( 0.00f,   0.00f);
	cgPoints[RIGHT]      = CGPointMake( 1.00f,   0.00f); 
	cgPoints[LEFT]       = CGPointMake(-1.00f,   0.00f); 
	cgPoints[UP]         = CGPointMake( 0.00f,   1.00f); 
	cgPoints[DOWN]       = CGPointMake( 0.00f,  -1.00f); 
	cgPoints[UP_RIGHT]   = CGPointMake( 1.00f,   1.00f); 
	cgPoints[UP_LEFT]    = CGPointMake(-1.00f,   1.00f); 
	cgPoints[DOWN_RIGHT] = CGPointMake( 1.00f,  -1.00f); 
	cgPoints[DOWN_LEFT]  = CGPointMake(-1.00f,  -1.00f); 
	
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
	if (spsheetColInd++ >= [[sprite getTextureCoords:spsheetRowInd] count] - 1) {
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
	distanceTraveled += movement.x;
	position.x += movement.x;
	position.y += movement.y;
	
}

- (void) attack {
}

// physics
- (void) resolveCollisions {
	[physicsEngine detectScreenCollision:[ObjectContainer singleton].player];
	
	[physicsEngine detectCircleCollision:[ObjectContainer singleton].player 
							   otherProp:[[ObjectContainer singleton] getObject:2]];
	
	[physicsEngine detectStageAdvance:[ObjectContainer singleton].player];
	
	
	
}

- (void) collidesWithPlayer {
	[self moveTowards:(Direction)([[directionToOpposite 
									objectForKey:[NSNumber 
												  numberWithInt:currentDirection]] intValue])];
	
}

- (void) collidesWithScreen {
	[self moveTowards:(Direction)([[directionToOpposite 
									objectForKey:[NSNumber 
												  numberWithInt:currentDirection]] intValue])];
	
}

@end
