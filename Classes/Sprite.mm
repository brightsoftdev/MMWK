//
//  Sprite.m
//  DragonEye
//
//  Created by alkaiser on 3/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Sprite.h"

@implementation Sprite

@synthesize textures, curTextureIndex;

+ (Sprite *) spriteWithTextures: (Texture *) firstTexture, ...{
	Sprite *sprite = [[Sprite alloc] init];
	va_list argList;
	[sprite addTexture:firstTexture];
	va_start(argList, firstTexture);
	Texture *eachTexture;
	while (eachTexture = va_arg(argList, Texture *)) {
		[sprite addTexture:eachTexture];
	}
	va_end(argList);
	return sprite;
}

- (id) init {
	if (self = [super init]) {
		[self setTextures:[NSMutableArray arrayWithCapacity:10]];
	}
	return self;
}
	
- (void) addTexture: (Texture *) texture {
	[textures addObject:texture];
}

- (Texture*) getActiveTexture {
	return [textures objectAtIndex:curTextureIndex];
}

@end
