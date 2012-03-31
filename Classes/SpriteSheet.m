//
//  SpriteSheet.m
//  DragonEye
//
//  Created by alkaiser on 3/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SpriteSheet.h"

@implementation SpriteSheet

@synthesize sheet, sizeX, sizeY, sizeTexX, sizeTexY;

+ (SpriteSheet *) createWithTexture:(Texture *) texture numOfCols:(uint)columns numOfRows:(uint)rows {
	SpriteSheet *spriteSheet = [[SpriteSheet alloc] init];
	spriteSheet.sheet = texture;
	spriteSheet.sizeX = (texture.width/columns);
	spriteSheet.sizeY = (texture.height/rows);
	spriteSheet.sizeTexX = 1.0/columns;
	spriteSheet.sizeTexY = 1.0/rows;

	return spriteSheet;
}

- (CGPoint) getTextureCoordsWithRowInd:(uint)rowInd colInd:(uint)colInd {
	return CGPointMake(colInd * sizeTexX, rowInd * sizeTexY);
}

@end
