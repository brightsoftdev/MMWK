//
//  macros.h
//  DragonEye
//
//  Created by Mark Mikhail on 3/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#define LOGGER(format, ...) NSLog(@"%s:%d " @ @format, __FUNCTION__, __LINE__, ##__VA_ARGS__);

//#define DLOGGER..
#define TO_DEGREES(radians) ((radians) * 180 / M_PI)

#define FIRST_QUADRANT(x, y)  ((x) > 0 && ((y) > 0))
#define SECOND_QUADRANT(x, y) ((x) < 0 && ((y) > 0))
#define THIRD_QUADRANT(x, y)  ((x) < 0 && ((y) < 0))
#define FOURTH_QUADRANT(x, y) ((x) > 0 && ((y) < 0))
