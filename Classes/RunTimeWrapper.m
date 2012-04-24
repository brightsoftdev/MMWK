//
//  RunTimeWrapper.m
//  DragonEye
//
//  Created by Mark Mikhail on 4/15/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "RunTimeWrapper.h"


@implementation RunTimeWrapper


+ (void) callWithNoArgs:(NSString *) prefix
				 object:(NSObject *) object {
		
	NSString * runTimeTypeOfProp = NSStringFromClass([object class]);
	NSString * runTimeMethod = [NSString stringWithFormat:
								@"%@%@",
								prefix,
								runTimeTypeOfProp];
	
	SEL callback = NSSelectorFromString(runTimeMethod);
	
	[object performSelector:callback];
	
}

@end
