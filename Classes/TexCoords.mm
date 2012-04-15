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

+ (TexCoords *) texCoordsWithTopLeft:(CGPoint)topLeft 
						 bottomRight:(CGPoint)bottomRight {
	TexCoords *texCoords = [[TexCoords alloc] init];
	texCoords.textureCoords = new CGPoint[4];
	texCoords.textureCoords[TOP_LEFT] = CGPointMake(topLeft.x, topLeft.y);
	texCoords.textureCoords[TOP_RIGHT] = CGPointMake(bottomRight.x, topLeft.y);
	texCoords.textureCoords[BOTTOM_LEFT] = CGPointMake(topLeft.x, bottomRight.y);
	texCoords.textureCoords[BOTTOM_RIGHT] = CGPointMake(bottomRight.x, bottomRight.y);
	
	return texCoords;
}

+ (TexCoords *) copyOfTexCoords:(TexCoords *) texCoords {
	return [TexCoords texCoordsWithTopLeft:texCoords.textureCoords[TOP_LEFT] 
							   bottomRight:texCoords.textureCoords[BOTTOM_RIGHT]
			];
}

- (void) setLeft:(GLfloat)x {
	textureCoords[TOP_LEFT].x = x;
	textureCoords[BOTTOM_LEFT].x = x;
}

- (GLfloat) getLeft {
	return textureCoords[TOP_LEFT].x;
}

- (void) setRight:(GLfloat)x {
	textureCoords[TOP_RIGHT].x = x;
	textureCoords[BOTTOM_RIGHT].x = x;
}

- (GLfloat) getRight {
	return textureCoords[TOP_RIGHT].x;
}

- (void) setTop:(GLfloat)y {
	textureCoords[TOP_LEFT].y = y;
	textureCoords[TOP_RIGHT].y = y;
}
   
- (GLfloat) getTop {
	return textureCoords[TOP_LEFT].y;
}
	   
- (void) setBottom:(GLfloat)y {
	textureCoords[BOTTOM_LEFT].y = y;
	textureCoords[BOTTOM_RIGHT].y = y;
}
   
- (GLfloat) getBottom {
	return textureCoords[BOTTOM_LEFT].y;
}

- (void) convertToCArray:(GLfloat *) textureVertices {
	for (uint i = 0; i < 4; i++) {
		textureVertices[(i*2)] = textureCoords[i].x;
		textureVertices[(i*2)+1] = textureCoords[i].y;
	}
}

@end
