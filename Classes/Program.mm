/*
 *  Program.mm
 *  DragonEye
 *
 *  Created by alkaiser on 2/19/12.
 *  Copyright 2012 __MyCompanyName__. All rights reserved.
 *
 */

#include "Program.h"

Program::Program() {
	this->programId = 0;
}

Program::~Program() {
	dispose();
}

GLuint Program::getProgramId() {
	return this->programId;
}

void Program::createProgram() {
	this->programId = glCreateProgram();
}

bool Program::linkProgram() {
	GLint status;
    
    glLinkProgram(this->programId);
    
#if defined(DEBUG)
    GLint logLength;
    glGetProgramiv(this->programId, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(this->programId, logLength, &logLength, log);
        NSLog(@"Program link log:\n%s", log);
        free(log);
    }
#endif
    
    glGetProgramiv(this->programId, GL_LINK_STATUS, &status);
    if (status == 0)
        return FALSE;
    
    return TRUE;
	
};

bool Program::validateProgram() {
	GLint logLength, status;
    
    glValidateProgram(this->programId);
    glGetProgramiv(this->programId, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(this->programId, logLength, &logLength, log);
        NSLog(@"Program validate log:\n%s", log);
        free(log);
    }
    
    glGetProgramiv(this->programId, GL_VALIDATE_STATUS, &status);
    if (status == 0)
        return FALSE;
    
    return TRUE;
}

bool Program::dispose() {
	if (this->programId) {
		glDeleteProgram(this->programId);
		this->programId = 0;
	}
	return true;
}