/*
 *  Object.mm
 *  DragonEye
 *
 *  Created by alkaiser on 2/19/12.
 *  Copyright 2012 __MyCompanyName__. All rights reserved.
 *
 */

#include "Object.h"

Object::Object(GLfloat x, GLfloat y, GLfloat sizex, GLfloat sizey) {
	this->x = x;
    this->y = y;
	this->sizex = sizex;
	this->sizey = sizey;
}

Object::~Object() {
    // TO BE WRITTEN
};

void Object::move(GLfloat diffX, GLfloat diffY) {
    this->x += diffX;
    this->y += diffY;
}

void Object::moveTo(GLfloat x, GLfloat y) {
    this->x = x;
    this->y = y;
}

GLfloat Object::getX() {
    return this->x;
}

GLfloat Object::getY() {
    return this->y;
}

GLfloat Object::getSizex() {
	return this->sizex;
}

GLfloat Object::getSizey() {
	return this->sizey;
}
