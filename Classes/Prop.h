//
//  Prop.h
//  DragonEye
//
//  Created by alkaiser on 4/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Typedefs.h"
#import "Collidable.h"
#import "Drawable.h"

@interface Prop : NSObject <Drawable, Collidable> {
	
	CGPoint position;
	CGSize  size;
	
}

@property (nonatomic, assign) CGPoint position;
@property (nonatomic, assign) CGSize size;

@end
