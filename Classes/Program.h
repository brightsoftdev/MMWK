#ifndef PROGRAM_H
#define PROGRAM_H
/*
 *  Program.h
 *  DragonEye
 *
 *  Created by alkaiser on 2/19/12.
 *  Copyright 2012 __MyCompanyName__. All rights reserved.
 *
 */
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

class Program {
	private:
	GLuint programId;
	
	public:
	Program();
	~Program();
	
	GLuint getProgramId();
	void createProgram();
	bool linkProgram();
	bool validateProgram();
	bool dispose();
};

#endif