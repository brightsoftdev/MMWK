//
//  Overlay.h
//  DragonEye
//
//  Created by alkaiser on 4/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Drawable.h"
#import "GraphicsEngine.h"
#import "SpriteSheet.h"
#import "PropState.h"

@class Node;

@interface Overlay : NSObject <Drawable> {
	SpriteSheet *sprite;
	OverlayState currentState;
	CGPoint position;
	CGSize size;
}

@property (nonatomic, retain) SpriteSheet *sprite;
@property (nonatomic, assign) OverlayState currentState;
@property (nonatomic, assign) CGPoint position;
@property (nonatomic, assign) CGSize size;

// Factory methods
+ (Overlay *) overlayAtPosition:(CGPoint)position 
						 size:(CGSize)size 
				  spriteSheet:(SpriteSheet *)spriteSheet;

+ (Node *) nodeAtPosition:(CGPoint)position 
					 size:(CGSize)size 
			  spriteSheet:(SpriteSheet *)spriteSheet;

// From GraphicsContext protocol
- (void) draw;
- (void) update;
- (void) animate;

- (void) show;
- (void) hide;


@end
