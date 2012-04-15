//
//  Background.mm
//  DragonEye
//
//  Created by alkaiser on 4/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Background.h"

@implementation Background

@synthesize texture, 
			rightBoundary,
			scrollSpeed,
			scrollDirection,
			displayLink;

+ (Background *) backgroundWithTexture:(Texture *) texture scrollSpeed:(GLfloat)scrollSpeed {
	Background *background = [[Background alloc] init];
	background.texture = texture;
	background.rightBoundary = 1.0;
	background.scrollSpeed = 0.01;
	background.scrollDirection = NO_WHERE;
	
	[background startAnimation];
	return background;
}

- (void) draw {
	TexCoords *texCoords = [TexCoords defaultTexCoords];
	
	/* PERF: Don't draw the side of the background that is not on the screen
	   Maybe taken care of by OpenGL already */
	
	// Drawing the left side of the background
	GLfloat shift = 1.0 - rightBoundary;
	CGPoint position = CGPointMake(-shift, 0.0);

	[GraphicsEngine drawTexture:texture 
					  texCoords:texCoords 
					   position:position
						   size:CGSizeMake(1.0, 1.0) 
					orientation:ORIENTATION_FORWARD];
	
	// Drawing the right side of the background
	position.x += 2.0;
	[GraphicsEngine drawTexture:texture 
					  texCoords:texCoords 
					   position:position 
						   size:CGSizeMake(1.0, 1.0) 
					orientation:ORIENTATION_FORWARD];
}

- (void) startAnimation {
	CADisplayLink *aDisplayLink = [[CADisplayLink displayLinkWithTarget:self 
															   selector:@selector(animate)] 
								   retain];
	[aDisplayLink setFrameInterval:1];
	[aDisplayLink addToRunLoop:[NSRunLoop currentRunLoop] 
					   forMode:NSDefaultRunLoopMode];
	
	self.displayLink = aDisplayLink;
}

- (GLfloat) wrapBoundary:(GLfloat) boundary {
	if (boundary < -1.0) {
		GLfloat shift = 1.0 + boundary;
		boundary = 1.0 + shift;
	} else if (boundary > 1.0) {
		GLfloat shift = 1.0 - boundary;
		boundary = -1.0 + shift;
	}	
	
	return boundary;
}

- (void) update {
}

- (void) animate {
	if (scrollDirection == LEFT) {
		rightBoundary -= scrollSpeed;
	} else if (scrollDirection == RIGHT) {
		rightBoundary += scrollSpeed;
	}
	
	rightBoundary = [self wrapBoundary:rightBoundary];
}
	 
- (void) scroll:(Direction) direction {
	scrollDirection = direction;
}

- (void) stopScrolling {
	scrollDirection = NO_WHERE;
}

@end
