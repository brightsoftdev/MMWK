//
//  Overlay.mm
//  DragonEye
//
//  Created by alkaiser on 4/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Overlay.h"
#import "Node.h"

@implementation Overlay

@synthesize sprite, currentState, position, size;

+ (void) initialize:(Overlay *)overlay position:(CGPoint)position size:(CGSize)size spriteSheet:(SpriteSheet *)spriteSheet {
	overlay.position = position;
	overlay.size = size;
	overlay.sprite = spriteSheet;
	overlay.currentState = OVERLAY_SHOWN;
}

+ (Overlay *) overlayAtPosition:(CGPoint)position size:(CGSize)size spriteSheet:(SpriteSheet *)spriteSheet {
	Overlay *overlay = [[Overlay alloc] init];
	[Overlay initialize:overlay position:position size:size spriteSheet:spriteSheet];
	
	return overlay;
}

+ (Node *) nodeAtPosition:(CGPoint)position size:(CGSize)size spriteSheet:(SpriteSheet *)spriteSheet {
	Node *node = [[Node alloc] init];
	[Overlay initialize:node position:position size:size spriteSheet:spriteSheet];
	
	return node;
}

- (void) draw {
	if (currentState == OVERLAY_SHOWN) {
		[GraphicsEngine drawTexture:sprite.sheet 
					texCoords:[Texture createDefaultTexCoords] 
					position:position 
					size:size
					orientation:ORIENTATION_FORWARD];
	}
}

- (void) update {
}

- (void) animate {
}

- (void) hide {
	currentState = OVERLAY_HIDDEN;
}

- (void) show {
	currentState = OVERLAY_SHOWN;
}


@end
