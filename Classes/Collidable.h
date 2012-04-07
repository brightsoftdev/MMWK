//
//  Collidable.h
//  DragonEye
//
//  Created by Mark Mikhail on 4/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

//forward declaration to allow recursive relationship
@class Collidable;

@protocol Collidable <NSObject>
- (BOOL) collidesWith:(Collidable *) otherObject;
@end
