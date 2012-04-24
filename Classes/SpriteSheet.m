//
//  SpriteSheet.m
//  DragonEye
//
//  Created by alkaiser on 3/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SpriteSheet.h"

@implementation SpriteSheet

@synthesize sheet, 
			sizeX, 
			sizeY, 
			sizeTexX, 
			sizeTexY, 
			texCoordsArray;

+ (SpriteSheet *) createWithTexture:(Texture *) texture 
						  numOfRows:(uint) rows
						    columns:(NSArray *) columns {
	
	assert([columns count] == rows);
	uint maxNumOfColumns = [[columns valueForKeyPath:@"@max.intValue"] intValue];
	
	SpriteSheet *spriteSheet = [[SpriteSheet alloc] init];
	spriteSheet.sheet = texture;
	spriteSheet.sizeX = (texture.width / maxNumOfColumns);
	spriteSheet.sizeY = (texture.height / rows);
	spriteSheet.sizeTexX = 1.0 / maxNumOfColumns;
	spriteSheet.sizeTexY = 1.0 / rows;
	[spriteSheet initTexCoordsArray:columns];
	
	return spriteSheet;
}

- (void) initTexCoordsArray:(NSArray *) columns {
	uint numOfRows = [columns count];
	self.texCoordsArray = [NSMutableArray arrayWithCapacity:numOfRows];
	
	for (uint rowInd = 0; rowInd < numOfRows; rowInd++) {
		uint numOfColumns = [[columns objectAtIndex:rowInd] integerValue];
		NSMutableArray *texCoordsForRow = [NSMutableArray arrayWithCapacity:numOfColumns];
		
		for (uint colInd = 0; colInd < numOfColumns; colInd++) {
			GLfloat topLeftX = colInd * sizeTexX;
			GLfloat topLeftY = rowInd * sizeTexY;
			GLfloat bottomRightX = (colInd+1) * sizeTexX;
			GLfloat bottomRightY = (rowInd+1) * sizeTexY;
			
			TexCoords *texCoords = [TexCoords texCoordsWithTopLeft:CGPointMake(topLeftX, topLeftY) 
													   bottomRight:CGPointMake(bottomRightX, bottomRightY)
									];
			
			[texCoordsForRow addObject:texCoords];
		}
		
		[texCoordsArray addObject:texCoordsForRow];
	}
}

- (NSArray *) getTextureCoords:(uint) rowInd {
	return [texCoordsArray objectAtIndex:rowInd];
}


@end
