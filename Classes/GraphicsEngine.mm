//
//  GraphicsEngine.m
//  DragonEye
//
//  Created by alkaiser on 4/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GraphicsEngine.h"
#import "Camera.h"

static CGPoint convertGameCoordinatesToOpenGL(CGPoint gameCoordinates);
static CGSize convertSizeToOpenGL(CGSize size);

static Camera* camera = [Camera getInstance];

@implementation GraphicsEngine

+ (void) drawTexture:(Texture *) texture 
		   texCoords:(TexCoords *) texCoordsParam
			position:(CGPoint) position 
				size:(CGSize) size 
		 orientation:(Orientation) orientation {
	
	static const GLfloat squareVertices[] = {
		-1.0f,   1.0f,
		 1.0f,   1.0f,
		-1.0f,  -1.0f,
		 1.0f,  -1.0f,
	};
	
	TexCoords *texCoords = [TexCoords copyOfTexCoords:texCoordsParam];
	
	// Swap left and right side 
	if (orientation == ORIENTATION_BACKWARDS) {
		GLfloat left = [texCoords getLeft];
		GLfloat right = [texCoords getRight];
		[texCoords setLeft:right];
		[texCoords setRight:left];
	}
	
	GLfloat textureVertices[8];
	[texCoords convertToCArray:textureVertices];
	
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


+ (void) drawCharacter:(Character *)character {

	SpriteSheet *sprite = character.sprite;
	NSArray *texCoordsArray = [sprite getTextureCoords:character.spsheetRowInd];
	
	TexCoords *texCoords = [texCoordsArray objectAtIndex:character.spsheetColInd];
	
	[self drawTextureInGameCoordinates:sprite.sheet 
			texCoords:texCoords 
			 position:character.position
				 size:character.size
		  orientation:character.currentOrientation];
}

+ (void) drawTextureInGameCoordinates:(Texture *) texture
		   texCoords:(TexCoords *) texCoordsParam
			position:(CGPoint) position
				size:(CGSize) size 
		 orientation:(Orientation) orientation {
	
	CGPoint openGLPoint = convertGameCoordinatesToOpenGL(position);
	CGSize  openGLSize  = convertSizeToOpenGL(size); 
	
	[self drawTexture:texture 
			texCoords:(TexCoords *)texCoordsParam 
			 position:(CGPoint)openGLPoint 
				 size:(CGSize)openGLSize
		  orientation:orientation];
	
}

+ (void) drawTextureInOpenGLCoordinates:(Texture *) texture
							  texCoords:(TexCoords *) texCoordsParam
							   position:(CGPoint) position
								   size:(CGSize) size {
	[self drawTexture:texture
			texCoords:texCoordsParam 
			 position:position 
				 size:size 
		  orientation:ORIENTATION_FORWARD];
	
}

+ (CGPoint) convertPointToGl:(CGPoint)point 
				  screenSize:(CGSize) screenSize {
	
	CGFloat halfwidth = screenSize.width / 2;
	CGFloat halfheight = screenSize.height / 2;
	CGFloat newX = (point.x - halfwidth) / halfwidth;
	CGFloat newY = (halfheight - point.y) / halfheight;
	
	return CGPointMake(newX, newY); 
}

static CGPoint convertGameCoordinatesToOpenGL(CGPoint gameCoordinates) {
		
	CGFloat midWay  = (camera.frameBoundary.right + camera.frameBoundary.left) / 2.0f;
	CGFloat midHigh = camera.frameDimension.height / 2.0f;
	
	CGFloat openGLWidth  = (gameCoordinates.x - midWay)  / (camera.frameDimension.width / 2.0f);
	CGFloat openGLHeight = (gameCoordinates.y - midHigh) / midHigh;
	
	CGPoint openGLPoint = { openGLWidth, openGLHeight };
	
	return openGLPoint;	
}

static CGSize convertSizeToOpenGL(CGSize size) {
	
	CGSize openGLSize = { 
						  size.width  / camera.frameDimension.width, 
						  size.height / camera.frameDimension.height 
						};
	
	return openGLSize;
	
}
	

@end
