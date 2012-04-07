//
//  GraphicsEngine.m
//  DragonEye
//
//  Created by alkaiser on 4/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GraphicsEngine.h"

@implementation GraphicsEngine

+ (void) drawCharacter:(Player *)character {

	SpriteSheet *sprite = character.sprite;
	NSArray *texCoords = [sprite getTextureCoordsWithRowInd:character.spsheetRowInd 
													colInd:character.spsheetColInd];
	
	[self drawTexture:sprite.sheet texCoords:texCoords 
								   position:character.position
								   size:character.size
								   orientation:character.currentOrientation];
}

+ (void) drawTexture:(Texture *) texture texCoords:(NSArray *) texCoords
			position:(CGPoint)position size:(CGSize)size orientation:(Orientation)orientation {
		
	static const GLfloat squareVertices[] = {
		 -1.0f, 1.0f,
		 1.0f, 1.0f,
		 -1.0f, -1.0f,
		 1.0f,  -1.0f,
	};
	
	GLfloat textureVertices[8];
	for (int i = 0; i < 8; i++) {
		textureVertices[i] = [[texCoords objectAtIndex:i] floatValue];
	}
	
	// Swap left and right side 
	if (orientation == ORIENTATION_BACKWARDS) {
		textureVertices[0] = textureVertices[4] = [[texCoords objectAtIndex:2] floatValue];
		textureVertices[2] = textureVertices[6] = [[texCoords objectAtIndex:0] floatValue];
	}
	
	glBindTexture(GL_TEXTURE_2D, texture.textureId);
	
	//glUniform1i(ShaderConstants::uniforms[UNIFORM_TEXTURE_SAMPLER], 0);
	glUniform2f(ShaderConstants::uniforms[UNIFORM_TRANSLATE], position.x, position.y);
	glUniform2f(ShaderConstants::uniforms[UNIFORM_SCALE], size.width, size.height);
	glVertexAttribPointer(ATTRIB_VERTEX, 2, GL_FLOAT, GL_FALSE, 0, squareVertices);
	glEnableVertexAttribArray(ATTRIB_VERTEX);
	glVertexAttribPointer(ATTRIB_TEXTURE, 2, GL_FLOAT, GL_FALSE, 0, textureVertices);
	glEnableVertexAttribArray(ATTRIB_TEXTURE);
	
	glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);	
}

+ (CGPoint) convertPointToGl:(CGPoint)point screenSize:(CGSize) screenSize {
	CGFloat halfwidth = screenSize.width/2;
	CGFloat halfheight = screenSize.height/2;
	CGFloat newX = (point.x - halfwidth) / halfwidth;
	CGFloat newY = (halfheight - point.y) / halfheight;
	return CGPointMake(newX, newY); 
}

@end
