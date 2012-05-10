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
static NSMutableDictionary * directionToOpposite = [NSMutableDictionary new];

@implementation Player

- (id) init:(CGPoint)pos 
	   size:(CGSize)sz 
spriteSheet:(SpriteSheet *)spriteSheet {
	
	if(self = [super init:pos 
					 size:sz 
			  spriteSheet:spriteSheet]) {
	   
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
	}
	
	return self;
	
}
+ (Player *) create:(CGPoint)position 
			   size:(CGSize)size 
		spriteSheet:(SpriteSheet *)spriteSheet {
	
	Player *player = [[Player alloc] init:position 
									 size:size 
							  spriteSheet:spriteSheet];
	
	DLOG("initializing player...");	
	return player;
}

// physics
- (void) resolveCollisions {
	[physicsEngine detectScreenCollision:[ObjectContainer singleton].player];
		
	/*
	[physicsEngine detectRectangleCollision:[ObjectContainer singleton].player 
								  otherProp:[[ObjectContainer singleton] getObject:2]];
	 */
	
}

- (void) collidesWithPlayer {
	[super moveTowards:(Direction)([[directionToOpposite 
									objectForKey:[NSNumber 
												  numberWithInt:currentDirection]] intValue])];
	
}

- (void) collidesWithScreen {
	[super moveTowards:(Direction)([[directionToOpposite 
									objectForKey:[NSNumber 
												  numberWithInt:currentDirection]] intValue])];
	
}

@end
