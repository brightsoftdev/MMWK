//
//  Loggers.h
//  DragonEye
//
//  Created by Mark Mikhail on 4/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

extern NSUInteger gblTicks;

#ifdef DEBUG
#   define DLOG(format, ...) NSLog(@"%s:%d " @ @format, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLOG(...);
#endif

#define LOG(format, ...) NSLog(@"%s:%d " @ @format, __FUNCTION__, __LINE__, ##__VA_ARGS__);

#define TLOG(format, ...) \
	if(gblTicks % (960 * 2) == 0) { \
		NSLog(@"%s:%d " @ @format, __FUNCTION__, __LINE__, ##__VA_ARGS__); \
	}

#define TLOGWithSec(seconds, format, ...) \
	if(gblTicks % (int)(60 * (seconds)) == 0) { \
		NSLog(@"%s:%d " @ @format, __FUNCTION__, __LINE__, ##__VA_ARGS__); \
	}
//NOTE: new line must be here at end of file.