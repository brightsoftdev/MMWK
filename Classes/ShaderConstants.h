/*
 *  Constants.h
 *  DragonEye
 *
 *  Created by alkaiser on 3/11/12.
 *  Copyright 2012 __MyCompanyName__. All rights reserved.
 *
 */
#ifndef SHADER_CONSTANTS_H
#define SHADER_CONSTANTS_H

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

//Shader Uniform index.
enum {
    UNIFORM_TRANSLATE,
    UNIFORM_TEXTURE_SAMPLER,
    NUM_UNIFORMS
};

//Shader Attribute index.
enum {
    ATTRIB_VERTEX,
    ATTRIB_TRANSLATE,
    ATTRIB_TEXTURE,
    NUM_ATTRIBUTES
};

class ShaderConstants {
	public:
	static GLint uniforms[];
};

#endif