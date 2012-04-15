//
//  ObjectContainer.h
//  DragonEye
//
//  Created by alkaiser on 3/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import "Background.h";

@interface ObjectContainer : NSObject {
	NSMutableArray *objArray;
	Player *player;
	Background *background;
}

@property (nonatomic, retain) NSMutableArray *objArray;
@property (nonatomic, readonly, retain) Player *player;
@property (nonatomic, readonly, retain) Background *background;

+ (ObjectContainer *) singleton;
- (id) init;
- (void) addObject:(id)object;
- (id) getObject:(NSUInteger) index;


@end
