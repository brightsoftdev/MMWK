//
//  TexCoords.h
//  DragonEye
//
//  Created by alkaiser on 4/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

// A class to encapsulate texture coordinates used by OpenGL
// Only supports square shaped ones at the moment
@interface TexCoords : NSObject {
	NSArray *textureCoords;
}

@property (nonatomic, retain) NSArray *textureCoords;

+ (TexCoords *) defaultTexCoords;
+ (TexCoords *) texCoordsWithTopLeft:(CGPoint)topLeft bottomRight:(CGPoint)bottomRight;

- (void) setLeft:(GLfloat)x;
- (GLfloat) getLeft;

- (void) setRight:(GLfloat)x;
- (GLfloat) getRight;

- (void) setTop:(GLfloat)y;
- (GLfloat) getTop;

- (void) setBottom:(GLfloat)y;
- (GLfloat) getBottom;

- (void) convertToCArray:(GLfloat *) textureVertices;

@end
