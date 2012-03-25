/*
 *  Texture.mm
 *  DragonEye
 *
 *  Created by alkaiser on 2/19/12.
 *  Copyright 2012 __MyCompanyName__. All rights reserved.
 *
 */

#import "Texture.h"

@implementation Texture

@synthesize textureId, width, height;

+ (Texture *) textureWithFilename: (NSString *)filename{
	Texture *texture = [[Texture alloc] init];
	
	// 1
    CGImageRef spriteImage = [UIImage imageWithContentsOfFile:filename].CGImage;
    if (!spriteImage) {
        NSLog(@"Failed to load image %@", filename);
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
	//glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
	
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, spriteData);
	
    free(spriteData);        
    
	texture.textureId = texName; 
	texture.width = width;
	texture.height = height;
	
	return texture;
}

@end
