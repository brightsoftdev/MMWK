//
//  Loggers.h
//  DragonEye
//
//  Created by Mark Mikhail on 4/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#ifdef DEBUG
#   define DLOG(format, ...) NSLog(@"%s:%d " @ @format, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLOG(...)
#endif

#define LOG(format, ...) NSLog(@"%s:%d " @ @format, __FUNCTION__, __LINE__, ##__VA_ARGS__);

