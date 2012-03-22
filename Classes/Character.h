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
#import "PropState.h"

class Character : public Object {
	private:
	enum PlayerState {
		MOVING_STATE,
		STOP_STATE
	};
	
	PlayerState currentState;
	Direction currentDirection;
	Texture **textures;
	uint numOfTextures;
	uint curTextureIndex;
	uint frameCount;
	
	void releaseTextures();
	void moveTowards(Direction dir);
	
	public:
	
	Character(GLfloat x, GLfloat y, GLfloat sizex = 1.0f, GLfloat sizey = 1.0f);
	~Character();
	
	void initializeTextures(Texture *textures[], uint numOfTextures);
	bool hasTextures();
	virtual void animate();
	virtual void draw();
	Texture *getActiveTexture();
	
	// Actions
	void startMoving(Direction dir);
	void stopMoving();
	
};

#endif