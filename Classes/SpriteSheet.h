//
//  SpriteSheet.h
//  DragonEye
//
//  Created by alkaiser on 3/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Texture.h"

@interface SpriteSheet : NSObject {
	// The texture containing the sprite sheet
	Texture *sheet;
	
	// Size of a single image in x,y direction
	uint sizeX;
	uint sizeY;
	
	// Size of a single image in x,y texture coords
	GLfloat sizeTexX;
	GLfloat sizeTexY;
	
	uint maxColumns;
}

@property (nonatomic, retain) Texture *sheet;
@property (nonatomic, assign) uint sizeX, sizeY, maxColumns;
@property (nonatomic, assign) GLfloat sizeTexX, sizeTexY;


+ (SpriteSheet *) createWithTexture:(Texture *) texture numOfCols:(uint)columns numOfRows:(uint)rows;
- (CGPoint) getTextureCoordsWithRowInd:(uint)rowIndex colInd:(uint)colInd;

@end

