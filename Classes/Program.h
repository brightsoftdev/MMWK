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

@interface Program : NSObject {
	GLuint programId;
}

@property (nonatomic) GLuint programId;

+ (id) getProgram; //function to return a single instance of program

- (void) createProgram;
- (BOOL) linkProgram;
- (BOOL) validateProgram;
- (BOOL) dispose;

@end