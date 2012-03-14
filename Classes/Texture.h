#ifndef TEXTURE_H
#define TEXTURE_H

/*
 *  Texture.h
 *  DragonEye
 *
 *  Created by alkaiser on 2/19/12.
 *  Copyright 2012 __MyCompanyName__. All rights reserved.
 *
 */

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

class Texture {
    private:
	/*static const GLfloat squareVertices[] = {
        -0.5f, 0.33f,
        0.5f, 0.33f,
        -0.5f, -0.33f,
        0.5f,  -0.33f,
    };
	
	static const GLfloat textureVertices[] = {
        0.0f, 0.0f,
        1.0f, 0.0f,
        0.0f,  1.0f,
        1.0f,  1.0f,
    };*/
	
    GLuint textureId;
 
    GLuint setupTexture(NSString *filename);

    public:
        Texture(NSString *filename);
        GLuint getTextureId();
        
		~Texture();
		bool dispose();
};
#endif
