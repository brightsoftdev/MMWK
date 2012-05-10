//
//  ObjectContainer.m
//  DragonEye
//
//  Created by alkaiser on 3/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ObjectContainer.h"

@implementation ObjectContainer

@synthesize objArray,
			player,
			node,
			background;

static ObjectContainer *singleContainer;

//don't worry -- we will need to change this.

+ (ObjectContainer *) singleton {
	if (!singleContainer) {
		singleContainer = [[ObjectContainer alloc] init];
	}
	
	return singleContainer;
}
						   
- (id) init {
	if (self = [super init]) {
		self.objArray = [NSMutableArray arrayWithCapacity:10];
	}
	return self;
}

- (void) addObject:(id)object {
	[objArray addObject:object];
		
	// Store player in a singleton player object
	if ([[object class] isSubclassOfClass:[Player class]]) {
		if (!player) {
			player = (Player *) object;
		} else {
			DLOG("ERROR! More than one player!");
		}
	}
	
	// Store background in a singleton background object
	if ([[object class] isSubclassOfClass:[Background class]]) {
		if (!background) {
			background = (Background *) object;
		} else {
			DLOG("ERROR! More than one background!");
		}
	}
	
	if([[object class] isSubclassOfClass:[Node class]]) {
		if (!node) {
			node = (Node *) object;
		} 
	}
}

- (id) getObject:(NSUInteger)index {
	return [objArray objectAtIndex:index];
}

@end
