/*
 *  Character.cpp
 *  DragonEye
 *
 *  Created by alkaiser on 2/27/12.
 *  Copyright 2012 __MyCompanyName__. All rights reserved.
 *
 */

#import "Character.h"

Character::Character(GLfloat x, GLfloat y, GLfloat sizex, GLfloat sizey) : Object(x, y, sizex, sizey){
	textures = NULL;
	frameCount = 0;
	numOfTextures = 0;
	curTextureIndex = 0;
}

Character::~Character() {
	releaseTextures();
}

void Character::releaseTextures() {
	if (textures != NULL) {
		delete textures;
		textures = NULL;
	}
	numOfTextures = 0;
	curTextureIndex = 0;
}

void Character::moveTowards(Direction dir) {
	// TODO: Use masks instead of switch case statements to incorporate diagonals
	switch(dir) {
		case LEFT:
			move(-0.01f, 0.0f);
			break;
			
		case RIGHT:
			move(0.01f, 0.0f);
			break;
			
		default:
			break;
	}
}

void Character::initializeTextures(Texture *textures[], uint numOfTextures) {
	releaseTextures();
	this->textures = new Texture *[numOfTextures];
	this->numOfTextures = numOfTextures;
	for (uint i = 0; i < numOfTextures; i++) {
		this->textures[i] = textures[i];
	}
	this->curTextureIndex = 0;
}

bool Character::hasTextures() {
	return textures != NULL;
}

void Character::animate() {
	switch(currentState) {
		case MOVING_STATE:
			moveTowards(currentDirection);
			break;
			
		default:
			break;
	}
	// TODO: throw error if textures == NULL?
	/*if(!(frameCount++ % 10)) {
		if(++curTextureIndex >= numOfTextures) {
			curTextureIndex = 0;
		}
	}*/
}

void Character::draw() {
	
    // Replace the implementation of this method to do your own custom drawing.
	static const GLfloat squareVertices[] = {
        -0.1f, 0.1f,
        0.1f, 0.1f,
        -0.1f, -0.1f,
        0.1f,  -0.1f,
    };
    
    static const GLfloat textureVertices[] = {
        0.0f, 0.0f,
        1.0f, 0.0f,
        0.0f,  1.0f,
        1.0f,  1.0f,
    };
	
	glBindTexture(GL_TEXTURE_2D, getActiveTexture()->getTextureId());

	//glUniform1i(ShaderConstants::uniforms[UNIFORM_TEXTURE_SAMPLER], 0);
	glUniform2f(ShaderConstants::uniforms[UNIFORM_TRANSLATE], getX(), getY());
	glUniform2f(ShaderConstants::uniforms[UNIFORM_SCALE], getSizex(), getSizey());
    glVertexAttribPointer(ATTRIB_VERTEX, 2, GL_FLOAT, GL_FALSE, 0, squareVertices);
    glEnableVertexAttribArray(ATTRIB_VERTEX);
    glVertexAttribPointer(ATTRIB_TEXTURE, 2, GL_FLOAT, GL_FALSE, 0, textureVertices);
    glEnableVertexAttribArray(ATTRIB_TEXTURE);

    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);	
}

Texture * Character::getActiveTexture() {
	return textures[curTextureIndex];
}

void Character::startMoving(Direction dir) {
	currentState = MOVING_STATE;
	currentDirection = dir;
}

void Character::stopMoving() {
	currentState = STOP_STATE;
}
