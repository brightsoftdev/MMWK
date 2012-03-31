//
//  DpadButton.m
//  DragonEye
//
//  Created by alkaiser on 3/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DpadButton.h"
#import "macros.h"
#import <math.h>

bool (^between)(double, double, double) =  ^(double x, double a, double b) { return x > a && x <= b; };

@implementation DpadButton

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [[touches allObjects] objectAtIndex:0];
	CGPoint point  = [touch locationInView:self];
	
	NSInteger dPadWidth  = self.frame.size.width / 2;
	NSInteger dPadHeight = self.frame.size.height / 2;
	
	ObjectContainer *singleton = [ObjectContainer singleton];
	Player *player = [singleton getObject:0];

	
	//
	//normalize x to origin by subtracting it
	point.x -= dPadWidth;
	//normalize y to origin by flipping substraction.
	point.y = dPadHeight - point.y;
	
	LOGGER("DpadPoint touched %.2f, %.2f", point.x, point.y);
	
			
	float angle = atan(point.y / point.x);

	LOGGER("Polar in degrees: ?= %lf\n", TO_DEGREES(angle));
	
	//TODO: use factory NSNumber.
	double degrees = 0;	
	if(FIRST_QUADRANT(point.x, point.y)) {
		degrees = TO_DEGREES(angle);
	} else if(SECOND_QUADRANT(point.x, point.y) || THIRD_QUADRANT(point.x, point.y)) {
		degrees = TO_DEGREES(angle) + 180;
	} else {
		degrees = TO_DEGREES(angle) + 360;
	}
		
	
	if (between(degrees, 25, 70)) {
		[player startMoving:(UP_RIGHT)];
	} else if (degrees > 70 && degrees <= 115) {
		[player startMoving:UP];
	} else if (degrees > 115 && degrees <= 150) {
		[player startMoving:(UP_LEFT)];
	} else if (degrees > 150 && degrees <= 195) {
		[player startMoving:LEFT];
	} else if (degrees > 195 && degrees <= 240) {
		[player startMoving:(DOWN_LEFT)];
	} else if (degrees > 240 && degrees <= 295) {
		[player startMoving:DOWN];
	} else if (degrees > 295 && degrees <= 340) {
		[player startMoving:(DOWN_RIGHT)];
	} else {
		[player startMoving:RIGHT];
	}
	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	ObjectContainer *singleton = [ObjectContainer singleton];
	Player *obj = [singleton getObject:0];
	
	[obj stopMoving];
}
@end
