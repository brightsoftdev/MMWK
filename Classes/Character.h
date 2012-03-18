#ifndef CHARACTER_H
#define CHARACTER_H

/*
 *  Character.h
 *  DragonEye
 *
 *  Created by alkaiser on 2/27/12.
 *  Copyright 2012 __MyCompanyName__. All rights reserved.
 *
 */

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import "Texture.h"
#import "Object.h"
#import "ShaderConstants.h"

class Character : public Object {
	private:
	Texture **textures;
	uint numOfTextures;
	uint curTextureIndex;
	uint frameCount;
	
	void releaseTextures();
	
	public:
	Character(GLfloat x, GLfloat y, GLfloat sizex = 1.0f, GLfloat sizey = 1.0f);
	~Character();
	
	void initializeTextures(Texture *textures[], uint numOfTextures);
	bool hasTextures();
	void animate();
	virtual void draw();
	Texture *getActiveTexture();
	
};

#endif