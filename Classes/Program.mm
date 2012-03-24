/*
 *  Program.mm
 *  DragonEye
 *
 *  Created by alkaiser on 2/19/12.
 *  Copyright 2012 __MyCompanyName__. All rights reserved.
 *
 */

#import "Program.h"

static Program * program = nil;

@implementation Program
@synthesize programId;

+ (id) getProgram {
	if(!program) {
		program = [[Program alloc] init];
		program.programId = 0;
	}
	return program;
}

- (void) createProgram {
	self.programId = glCreateProgram();
}

- (BOOL) linkProgram {
	GLint status;
    
    glLinkProgram(self.programId);
    
#if defined(DEBUG)
    GLint logLength;
    glGetProgramiv(self.programId, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(self.programId, logLength, &logLength, log);
        NSLog(@"Program link log:\n%s", log);
        free(log);
    }
#endif
    
    glGetProgramiv(self.programId, GL_LINK_STATUS, &status);
	return status != 0;
}

- (BOOL) validateProgram {
	GLint logLength, status;
    
    glValidateProgram(self.programId);
    glGetProgramiv(self.programId, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(self.programId, logLength, &logLength, log);
        NSLog(@"Program validate log:\n%s", log);
        free(log);
    }
    
    glGetProgramiv(self.programId, GL_VALIDATE_STATUS, &status);
    return status != 0;
}

- (BOOL) dispose {
	if (self.programId) {
		glDeleteProgram(self.programId);
		self.programId = 0;
	}
	return true;
}

@end