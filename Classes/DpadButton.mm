//
//  DpadButton.m
//  DragonEye
//
//  Created by alkaiser on 3/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DpadButton.h"
#import "CoordinateSystem.h"
#import "Loggers.h"

//Private fxns.
static void decideHowPlayerShouldMove(CGPoint, NSInteger, NSInteger);

@implementation DpadButton

- (void)touchesBegan:(NSSet *)touches 
		   withEvent:(UIEvent *)event {
	
	UITouch *touch = [[touches allObjects] objectAtIndex:0];
	CGPoint point  = [touch locationInView:self];
	
	decideHowPlayerShouldMove(point, 
							  self.frame.size.width, 
							  self.frame.size.height);
}


- (void) touchesMoved:(NSSet *)touches 
			withEvent:(UIEvent *)event {
	
	UITouch *touch = [[touches allObjects] objectAtIndex:0];
	CGPoint point  = [touch locationInView:self];
	
	decideHowPlayerShouldMove(point,
							  self.frame.size.width,
							  self.frame.size.height);
	
	
}

- (void)touchesEnded:(NSSet *)touches 
		   withEvent:(UIEvent *)event {
	
	ObjectContainer *singleton = [ObjectContainer singleton];
	Player *player = [singleton getPlayer];
	
	[player stand];
}

//pure C-style to how private functions within in a file.
static void decideHowPlayerShouldMove(CGPoint point, NSInteger width, NSInteger height) {
	
	ObjectContainer *singleton = [ObjectContainer singleton];
	Player *player = [singleton getPlayer];
	
	CoordinateSystem * coordinateSystem = [CoordinateSystem initWithDimensions:width 
																	 imgHeight:height];
	
	Direction direction = [coordinateSystem decideDirectionFromCartestian:point.x 
															  yCoordinate:point.y];
	
	if (direction == NO_WHERE) {
		[player stand];
	} else {
		[player runTo:direction];
	}	
}
@end
