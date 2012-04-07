//
//  SpriteSheet.m
//  DragonEye
//
//  Created by alkaiser on 3/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SpriteSheet.h"

@implementation SpriteSheet

@synthesize sheet, sizeX, sizeY, sizeTexX, sizeTexY, maxColumns;

+ (SpriteSheet *) createWithTexture:(Texture *) texture numOfCols:(uint)columns numOfRows:(uint)rows {
	
	SpriteSheet *spriteSheet = [[SpriteSheet alloc] init];
	spriteSheet.sheet = texture;
	spriteSheet.sizeX = (texture.width / columns);
	spriteSheet.sizeY = (texture.height / rows);
	spriteSheet.sizeTexX = 1.0 / columns;
	spriteSheet.sizeTexY = 1.0 / rows;
	
	spriteSheet.maxColumns = columns;

	return spriteSheet;
}

- (NSArray *) getTextureCoordsWithRowInd:(uint)rowInd colInd:(uint)colInd {
	NSNumber *s1 = [NSNumber numberWithFloat:(colInd * sizeTexX)];
	NSNumber *t1 = [NSNumber numberWithFloat:(rowInd * sizeTexY)];
	NSNumber *s2 = [NSNumber numberWithFloat:((colInd+1) * sizeTexX)];
	NSNumber *t2 = [NSNumber numberWithFloat:((rowInd+1) * sizeTexY)];
	
	return [NSArray arrayWithObjects:s1,t1,
							         s2,t1,
							         s1,t2,
							         s2,t2,
									 nil];
}

@end
