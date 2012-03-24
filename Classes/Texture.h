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

@interface Texture : NSObject {
    GLuint textureId;
}

@property (nonatomic, assign) GLuint textureId;

+ (Texture *) textureWithFilename: (NSString *)filename,...;

@end