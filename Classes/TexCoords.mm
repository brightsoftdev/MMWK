//
//  TexCoords.mm
//  DragonEye
//
//  Created by alkaiser on 4/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "TexCoords.h"


@implementation TexCoords

@synthesize textureCoords;

static const int TOP_LEFT = 0;
static const int TOP_RIGHT = 1;
static const int BOTTOM_LEFT = 2;
static const int BOTTOM_RIGHT = 3;

+ (TexCoords *) defaultTexCoords {
	return [TexCoords texCoordsWithTopLeft:CGPointMake(0.0, 0.0) bottomRight:CGPointMake(1.0, 1.0)];
}

+ (TexCoords *) texCoordsWithTopLeft:(CGPoint)topLeft bottomRight:(CGPoint)bottomRight {
	TexCoords *texCoords = [[TexCoords alloc] init];
	texCoords.textureCoords = [NSArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(topLeft.x, topLeft.y)],
													    [NSValue valueWithCGPoint:CGPointMake(bottomRight.x, topLeft.y)],
														[NSValue valueWithCGPoint:CGPointMake(topLeft.x, bottomRight.y)],
														[NSValue valueWithCGPoint:CGPointMake(bottomRight.x, bottomRight.y)],
														nil];
	
	return texCoords;
}

- (void) setLeft:(GLfloat)x {
	[[textureCoords objectAtIndex:TOP_LEFT] CGPointValue].x = x;
	[[textureCoords objectAtIndex:BOTTOM_LEFT] CGPointValue].x = x;
}

- (GLfloat) getLeft {
	return [[textureCoords objectAtIndex:TOP_LEFT] CGPointValue].x;
}

- (void) setRight:(GLfloat)x {
	[[textureCoords objectAtIndex:TOP_RIGHT] CGPointValue].x = x;
	[[textureCoords objectAtIndex:BOTTOM_RIGHT] CGPointValue].x = x;
}

- (GLfloat) getRight {
	return [[textureCoords objectAtIndex:TOP_RIGHT] CGPointValue].x;
}

- (void) setTop:(GLfloat)y {
	[[textureCoords objectAtIndex:TOP_LEFT] CGPointValue].y = y;
	[[textureCoords objectAtIndex:TOP_RIGHT] CGPointValue].y = y;
}
   
- (GLfloat) getTop {
	return [[textureCoords objectAtIndex:TOP_LEFT] CGPointValue].y;
}
	   
- (void) setBottom:(GLfloat)y {
	[[textureCoords objectAtIndex:BOTTOM_LEFT] CGPointValue].y = y;
	[[textureCoords objectAtIndex:BOTTOM_RIGHT] CGPointValue].y = y;
}
   
- (GLfloat) getBottom {
	return [[textureCoords objectAtIndex:BOTTOM_LEFT] CGPointValue].y;
}

- (void) convertToCArray:(GLfloat *) textureVertices {
	for (uint i = 0; i < 4; i++) {
		textureVertices[(i*2)] = [[textureCoords objectAtIndex:i] CGPointValue].x;
		textureVertices[(i*2)+1] = [[textureCoords objectAtIndex:i] CGPointValue].y;
	}
}

@end
