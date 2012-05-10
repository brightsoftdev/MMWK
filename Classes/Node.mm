//
//  untitled.m
//  DragonEye
//
//  Created by alkaiser on 4/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Node.h"


@implementation Node

- (CGFloat) distanceFrom:(CGPoint) point1 to:(CGPoint)point2 {
	CGFloat x1 = point1.x;
	CGFloat x2 = point2.x;
	CGFloat y1 = point1.y;
	CGFloat y2 = point2.y;
	
	CGFloat distance = sqrt(pow(y2-y1, 2) + pow(x2-x1, 2));
	DLOG("Distance %f", distance);
	return distance;
}

- (bool) isPressed:(CGPoint)point {
	DLOG("Touched (%f, %f), node position(%f, %f), height %f", point.x, point.y, self.position.x, self.position.y, size.height);
	return [self distanceFrom:point to:self.position] < size.height;
}

@end
