//
//  Sprite.h
//  DragonEye
//
//  Created by alkaiser on 3/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Texture.h"

@interface Sprite : NSObject {
	NSMutableArray *textures;
	GLuint curTextureIndex;
}

@property (nonatomic, retain) NSMutableArray *textures;
@property (nonatomic, assign) GLuint curTextureIndex;

+ (Sprite *) spriteWithTextures:(Texture *) firstTexture,...;
- (id) init;
- (void) addTexture:(Texture *) texture;
- (Texture*) getActiveTexture;

@end
