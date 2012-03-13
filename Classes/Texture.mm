/*
 *  Texture.mm
 *  DragonEye
 *
 *  Created by alkaiser on 2/19/12.
 *  Copyright 2012 __MyCompanyName__. All rights reserved.
 *
 */

#include "Texture.h"

GLuint Texture::setupTexture(NSString *fileName) {
	// 1
    CGImageRef spriteImage = [UIImage imageWithContentsOfFile:fileName].CGImage;
    if (!spriteImage) {
        NSLog(@"Failed to load image %@", fileName);
        exit(1);
    }
	
    // 2
    size_t width = CGImageGetWidth(spriteImage);
    size_t height = CGImageGetHeight(spriteImage);
	
    GLubyte * spriteData = (GLubyte *) calloc(width*height*4, sizeof(GLubyte));
	
    CGContextRef spriteContext = CGBitmapContextCreate(spriteData, width, height, 8, width*4, 
													   CGImageGetColorSpace(spriteImage), kCGImageAlphaPremultipliedLast);    
	
    // 3
    CGContextDrawImage(spriteContext, CGRectMake(0, 0, width, height), spriteImage);
	
    CGContextRelease(spriteContext);
	
    // 4
    GLuint texName;
    glGenTextures(1, &texName);
	//glActiveTexture(GL_TEXTURE1);
    glBindTexture(GL_TEXTURE_2D, texName);
	
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST); 
	
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, spriteData);
	
    free(spriteData);        
    return texName; 
}

Texture::Texture(NSString *filename) {
    this->textureId = setupTexture(filename);
}

GLuint Texture::getTextureId() {
    return this->textureId;
}

Texture::~Texture() {
    dispose();
}

bool Texture::dispose() {
	// To be written
	return true;
}
