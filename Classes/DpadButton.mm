//
//  DpadButton.m
//  DragonEye
//
//  Created by alkaiser on 3/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DpadButton.h"

@implementation DpadButton

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [[touches allObjects] objectAtIndex:0];
	CGPoint point = [touch locationInView:self];
	
	NSLog(@"DpadPoint touched %.2f, %.2f", point.x, point.y);
	
	ObjectContainer *singleton = [ObjectContainer singleton];
	NSValue *val = [singleton getObject:0];
	Character *obj = (Character *)[val pointerValue];
	
	if (point.x < self.frame.size.width/2) {
		obj->startMoving(LEFT);
	} else {
		obj->startMoving(RIGHT);
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	ObjectContainer *singleton = [ObjectContainer singleton];
	NSValue *val = [singleton getObject:0];
	Character *obj = (Character *)[val pointerValue];
	obj->stopMoving();
}
@end
