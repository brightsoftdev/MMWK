//
//  Background.mm
//  DragonEye
//
//  Created by alkaiser on 4/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Background.h"
#import "Camera.h"

static Camera * camera = [Camera getInstance];

@implementation Background

@synthesize texture, 
			rightBoundary,
			scrollSpeed,
			scrollDirection,
			displayLink;

+ (Background *) backgroundWithTexture:(Texture *) texture 
						   scrollSpeed:(GLfloat)scrollSpeed {
	
	Background *background = [[Background alloc] init];
	background.texture = texture;
	background.rightBoundary = 100;
	background.scrollSpeed = scrollSpeed;
	background.scrollDirection = NO_WHERE;
	
	[background startAnimation];
	return background;
}

- (void) draw {
	TexCoords *texCoords = [TexCoords defaultTexCoords];
	
	/* PERF: Don't draw the side of the background that is not on the screen
	   Maybe taken care of by OpenGL already */
	
	// Drawing the left side of the background
	NSInteger shift = rightBoundary - (camera.frameDimension.width / 2);
	CGPoint position = CGPointMake(shift, camera.frameDimension.width / 2);
	
	//DLOG("rightBoundary :%lf", rightBoundary);
	
	[GraphicsEngine drawTextureInGameCoordinates:texture 
									   texCoords:texCoords 
										position:position
											size:CGSizeMake(100, 100) 
									 orientation:ORIENTATION_FORWARD];
	
	// Drawing the right side of the background
	position.x += 100;
	[GraphicsEngine drawTextureInGameCoordinates:texture 
									   texCoords:texCoords 
										position:position 
											size:CGSizeMake(100, 100)
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

	if (boundary < camera.frameBoundary.left) {
		GLfloat shift = boundary;
		boundary = camera.frameDimension.width + shift;
		
		DLOG("scroll left: wrap it by %lf !!!!!", shift);
		DLOG("scroll left: boundary is now %lf", boundary);

	} 
	
	/*else if (boundary > worldCoordinates.frameBoundary.right) {
		GLfloat shift = boundary - worldCoordinates.frameBoundary.right;
		DLOG("scroll right: wrap it by %lf !!!!!", shift);
		boundary = worldCoordinates.frameBoundary.width + shift;
		DLOG("scroll right: boundary is now %lf", boundary);

	}	*/
	
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
