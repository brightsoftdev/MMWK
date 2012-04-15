//
//  Background.h
//  DragonEye
//
//  Created by alkaiser on 4/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Drawable.h"
#import "Texture.h"
#import "PropState.h"
#import "GraphicsEngine.h"
#import "Loggers.h"

@interface Background : NSObject <Drawable> {
	CADisplayLink *displayLink;
	Texture *texture;
	GLfloat rightBoundary; 
	GLfloat scrollSpeed;
	Direction scrollDirection;
}

@property (nonatomic, retain) CADisplayLink *displayLink;
@property (nonatomic, retain) Texture *texture;
@property (nonatomic, assign) GLfloat rightBoundary, scrollSpeed;
@property (nonatomic, assign) Direction scrollDirection;

+ (Background *) backgroundWithTexture:(Texture *) texture scrollSpeed:(GLfloat)scrollSpeed;

- (void) startAnimation;
- (GLfloat) wrapBoundary:(GLfloat) boundary;

// From Drawable protocol
- (void) draw;
- (void) update;
- (void) animate;

- (void) scroll:(Direction) direction;
- (void) stopScrolling;

@end
