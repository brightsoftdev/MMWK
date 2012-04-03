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

	static const GLfloat squareVertices[] = {
		-0.1f, 0.1f,
		0.1f, 0.1f,
		-0.1f, -0.1f,
		0.1f,  -0.1f,
	};

	SpriteSheet *sprite = character.sprite;
	CGPoint texCoords = [sprite getTextureCoordsWithRowInd:character.spsheetRowInd 
													colInd:character.spsheetColInd];
	GLfloat textureVertices[8]; 
	textureVertices[1] = texCoords.y;
	textureVertices[3] = texCoords.y;
	textureVertices[5] = texCoords.y + sprite.sizeTexY;
	textureVertices[7] = texCoords.y + sprite.sizeTexY;

	if (character.currentOrientation == ORIENTATION_FORWARD) {
		textureVertices[0] = texCoords.x;
		textureVertices[2] = texCoords.x + sprite.sizeTexX;
		textureVertices[4] = texCoords.x; 
		textureVertices[6] = texCoords.x + sprite.sizeTexX;
	} else if (character.currentOrientation == ORIENTATION_BACKWARDS) {
		textureVertices[0] = texCoords.x + sprite.sizeTexX;
		textureVertices[2] = texCoords.x;
		textureVertices[4] = texCoords.x + sprite.sizeTexX;
		textureVertices[6] = texCoords.x;
	}

	glBindTexture(GL_TEXTURE_2D, sprite.sheet.textureId);

	//glUniform1i(ShaderConstants::uniforms[UNIFORM_TEXTURE_SAMPLER], 0);
	glUniform2f(ShaderConstants::uniforms[UNIFORM_TRANSLATE], character.position.x, character.position.y);
	glUniform2f(ShaderConstants::uniforms[UNIFORM_SCALE], character.size.width, character.size.height);
	glVertexAttribPointer(ATTRIB_VERTEX, 2, GL_FLOAT, GL_FALSE, 0, squareVertices);
	glEnableVertexAttribArray(ATTRIB_VERTEX);
	glVertexAttribPointer(ATTRIB_TEXTURE, 2, GL_FLOAT, GL_FALSE, 0, textureVertices);
	glEnableVertexAttribArray(ATTRIB_TEXTURE);

	glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);	
}
@end
