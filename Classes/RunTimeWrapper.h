//
//  RunTimeWrapper.h
//  DragonEye
//
//  Created by Mark Mikhail on 4/15/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RunTimeWrapper : NSObject {

}

+ (void) callWithNoArgs:(NSString *) prefix
				 object:(NSObject *) object;

@end
