//
//  Overlay.h
//  DragonEye
//
//  Created by alkaiser on 4/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GraphicsContext.h"
#import "GraphicsEngine.h"
#import "SpriteSheet.h"

@interface Overlay : NSObject <GraphicsContext> {
	SpriteSheet *sprite;
	CGPoint position;
	CGSize size;
}

@property (nonatomic, retain) SpriteSheet *sprite;
@property (nonatomic, assign) CGPoint position;
@property (nonatomic, assign) CGSize size;

+ (Overlay *) overlayAtPosition:(CGPoint)position 
						 size:(CGSize)size 
				  spriteSheet:(SpriteSheet *)spriteSheet;

// From GraphicsContext protocol
- (void) draw;
- (void) update;
- (void) animate;

@end
