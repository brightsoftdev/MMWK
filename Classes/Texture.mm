/*
 *  Texture.mm
 *  DragonEye
 *
 *  Created by alkaiser on 2/19/12.
 *  Copyright 2012 __MyCompanyName__. All rights reserved.
 *
 */

#import "Texture.h"

static const UInt8 ALPHA_THRESHOLD = 99;

@implementation Texture

@synthesize textureId, width, height;


+ (NSArray *) setCollisionMap:(Texture *) texture 
				  spriteImage:(CGImageRef) spriteImage {
	
	// get all the image information we need
	CGFloat pixelMaskWidth	= texture.width;
	CGFloat pixelMaskHeight = texture.height;
	CGFloat pixelMaskSize	= pixelMaskWidth * pixelMaskHeight;
	
	// allocate and clear the pixelMask buffer
	BOOL * pixelMask = (BOOL *) malloc(pixelMaskSize * sizeof(BOOL));
	memset(pixelMask, 0, pixelMaskSize * sizeof(BOOL));	
	
	CFDataRef imageData = CGDataProviderCopyData(CGImageGetDataProvider(spriteImage));
	const UInt32* imagePixels = (const UInt32*)CFDataGetBytePtr(imageData);
	
	UInt32 alphaValue = 0, x = 0, y = pixelMaskHeight - 1;
	UInt8 alpha = 0; 
	
	for (NSUInteger i = 0; i < pixelMaskSize; i++) {
		// ensure that the pixelMask is created in top to bottom orientation
		NSUInteger index = y * pixelMaskWidth + x;
		x++;
		if (x == pixelMaskWidth) {
			x = 0;
			y--;
		}
		// mask out the colors so that only the alpha value remains (upper 8 bits)
		alphaValue = imagePixels[i] & 0xff000000;
		if (alphaValue > 0) {
			// get the alpha value, then compare alpha with the alpha threshold
			alpha = (UInt8)(alphaValue >> 24);
			if (alpha > ALPHA_THRESHOLD) {
				pixelMask[index] = YES;
			}
		}
	}
	
	for (NSUInteger i = 0; i < pixelMaskSize; i++) {
		
		NSUInteger index = y * pixelMaskWidth + x;
		printf("%d", pixelMask[index]);
		
		x++;
		if (x == pixelMaskWidth) {
			printf("\n");
			x = 0;
			y--;
		}

	}
	
	CFRelease(imageData);
	imageData = nil;
	
	return nil;
	
}
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
	
    CGContextRef spriteContext = CGBitmapContextCreate(spriteData, 
													   width, height, 8, width*4, 
													   CGImageGetColorSpace(spriteImage), 
													   kCGImageAlphaPremultipliedLast);    
	
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
	
	glEnable(GL_BLEND);
	//source factor -- the color you want.
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	//load image data into memory -- referenced by texName
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, spriteData);
		
    
	texture.textureId = texName; 
	texture.width = width;
	texture.height = height;
	
	/*
	[Texture setCollisionMap:texture 
				 spriteImage:spriteImage];
	 */
	
	free(spriteData);        
    spriteData = NULL;
	
	return texture;
}

@end
