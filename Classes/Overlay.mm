//
//  Overlay.mm
//  DragonEye
//
//  Created by alkaiser on 4/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Overlay.h"


@implementation Overlay

@synthesize sprite, position, size;

+ (Overlay *) overlayAtPosition:(CGPoint)position size:(CGSize)size spriteSheet:(SpriteSheet *)spriteSheet {
	Overlay *overlay = [[Overlay alloc] init];
	overlay.position = position;
	overlay.size = size;
	overlay.sprite = spriteSheet;
	
	return overlay;
}

- (void) draw {
	[GraphicsEngine drawTexture:sprite.sheet 
					texCoords:[Texture createDefaultTexCoords] 
					position:position 
					size:size
					orientation:ORIENTATION_FORWARD];
}

- (void) update {
}

- (void) animate {
}

@end
