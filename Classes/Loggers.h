//
//  Loggers.h
//  DragonEye
//
//  Created by Mark Mikhail on 4/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

extern NSUInteger gblTicks;

#define NUDGE_SCALAR 180

#ifdef DEBUG
#   define DLOG(format, ...) NSLog(@"%s:%d " @ @format, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLOG(...);
#endif

#define LOG(format, ...) NSLog(@"%s:%d " @ @format, __FUNCTION__, __LINE__, ##__VA_ARGS__);

#define TLOG(format, ...) \
	if(gblTicks % (NUDGE_SCALAR * 2) == 0) { \
		NSLog(@"%s:%d " @ @format, __FUNCTION__, __LINE__, ##__VA_ARGS__); \
	}

#define TLOGWithSec(seconds, format, ...) \
	if(gblTicks % (int)(NUDGE_SCALAR * (seconds)) == 0) { \
		NSLog(@"%s:%d " @ @format, __FUNCTION__, __LINE__, ##__VA_ARGS__); \
	}
//NOTE: new line must be here at end of file.