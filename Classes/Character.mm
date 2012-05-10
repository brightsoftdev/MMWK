//
//  Character.h
//  DragonEye
//
//  Created by Mark Mikhail on 4/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Character.h"
#import "GraphicsEngine.h"

static CGPoint cgPoints[MAX_DIRECTIONS]; 

// Texture row indexes in the sprite sheet
static const uint STANDING_ROW_INDEX = 0; 
static const uint MOVEMENT_ROW_INDEX = 3;

@implementation Character


@synthesize sprite, 
			spsheetRowInd, 
			spsheetColInd, 
			displayLink, 
			currentState, 
			physicsEngine,
			currentDirection,
			currentOrientation;

//Private method
- (void) move:(CGPoint)movement {
	position.x += movement.x;
	position.y += movement.y;
	
}

- (id) init:(CGPoint) pos
	   size:(CGSize) sz
spriteSheet:(SpriteSheet *) spriteSheet {
	
	if(self = [super init]) {
		
		self.position = pos;
		self.size = sz;
		self.sprite = spriteSheet;
		self.currentState = STOP_STATE;
		self.currentDirection = RIGHT;
		self.currentOrientation = ORIENTATION_FORWARD;
		self.physicsEngine = [PhysicsEngine getInstance];
		
		self.spsheetRowInd = STANDING_ROW_INDEX;
		self.spsheetColInd = MOVEMENT_ROW_INDEX;
		
		[self startAnimation];
		
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
		
	}
	
	return self;
	
}

+ (id) create:(CGPoint) position 
		 size:(CGSize)size 
  spriteSheet:(SpriteSheet *)spriteSheet {
	
	Character *character = [[Character alloc] init:position 
											  size:size 
									   spriteSheet:spriteSheet];
	
	return character;
}

- (void) startAnimation {
	CADisplayLink *aDisplayLink = [[CADisplayLink displayLinkWithTarget:self 
															   selector:@selector(animate)] 
								   retain];
	
	[aDisplayLink addToRunLoop:[NSRunLoop currentRunLoop] 
					   forMode:NSDefaultRunLoopMode];
	
	self.displayLink = aDisplayLink;
}


- (void) animate {
	if (spsheetColInd++ >= [[sprite getTextureCoords:spsheetRowInd] count] - 1) {
		spsheetColInd = 0;
	}
}

- (void) update {
	TLOG("Character position: (%lf, %lf)", self.position.x, self.position.y);
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

- (void) moveTowards:(Direction) dir{
	[self move:cgPoints[dir]];
}

- (void) stand {
	currentState = STOP_STATE;
	spsheetRowInd = STANDING_ROW_INDEX;
}

@end
