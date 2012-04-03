//
//  GraphicsEngine.h
//  DragonEye
//
//  Created by alkaiser on 4/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import "PropState.h"
#import "SpriteSheet.h"
#import "ShaderConstants.h"
#import "Player.h"

@class Player;

@interface GraphicsEngine : NSObject {

}

// Does not support UP and DOWN
+ (void) drawCharacter:(Player *) character;

@end