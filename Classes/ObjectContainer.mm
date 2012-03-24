//
//  ObjectContainer.m
//  DragonEye
//
//  Created by alkaiser on 3/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ObjectContainer.h"


@implementation ObjectContainer

@synthesize objArray;

static ObjectContainer *singleContainer;

+ (void) initialize {
	singleContainer = [[ObjectContainer alloc] init];
}

+ (ObjectContainer *) singleton {
	if (!singleContainer) {
		[ObjectContainer initialize];
	}
	
	return singleContainer;
}
						   
- (id) init {
	if (self = [super init]) {
		[self setObjArray:[NSMutableArray arrayWithCapacity:10]];
	}
	return self;
}

- (void) addObject:(id)object {
	[objArray addObject:object];
}

- (id) getObject:(NSUInteger)index {
	return [objArray objectAtIndex:index];
}
@end
