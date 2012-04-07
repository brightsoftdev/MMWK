//
//  Prop.m
//  DragonEye
//
//  Created by alkaiser on 3/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Prop.h"

@implementation Prop

- (BOOL) collidesWith:(Collidable *) otherObject {
	return NO;
}

@synthesize position, 
			size;

@end
