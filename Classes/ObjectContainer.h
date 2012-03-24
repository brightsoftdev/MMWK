//
//  ObjectContainer.h
//  DragonEye
//
//  Created by alkaiser on 3/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjectContainer : NSObject {
	NSMutableArray *objArray;
}

@property (nonatomic, retain) NSMutableArray *objArray;

+ (ObjectContainer *) singleton;
- (id) init;
- (void) addObject:(id)object;
- (id) getObject:(NSUInteger) index;


@end
