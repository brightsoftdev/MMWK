#ifndef OBJECT_H
#define OBJECT_H
/*
 *  Object.h
 *  DragonEye
 *
 *  Created by alkaiser on 2/19/12.
 *  Copyright 2012 __MyCompanyName__. All rights reserved.
 *
 */
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import "Typedefs.h"

class Object {
	protected:
	GLfloat x;
	GLfloat y;
	GLfloat sizex;
	GLfloat sizey;
	
	public:
	Object(GLfloat x, GLfloat y, GLfloat sizex = 1.0f, GLfloat sizey = 1.0f);
	virtual ~Object();
	virtual void move(GLfloat diffX, GLfloat diffY);
	virtual void moveTo(GLfloat x, GLfloat y);
	virtual void draw() = 0;
	
    GLfloat getX();
    GLfloat getY();
	GLfloat getSizex();
	GLfloat getSizey();
};

#endif
