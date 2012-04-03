//
//  macros.h
//  DragonEye
//
//  Created by Mark Mikhail on 3/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

//TODO: rename this file.

#define HALF_CYCLE_IN_DEGREES 180
#define FULL_CYCLE_IN_DEGREES 360

#define TO_DEGREES(radians) ((radians) * HALF_CYCLE_IN_DEGREES / M_PI)

#define REALLY(__angle__) ((__angle__) * 57.29577951f)

#define FIRST_QUADRANT(x, y)  ((x) > 0 && ((y) > 0))
#define SECOND_QUADRANT(x, y) ((x) < 0 && ((y) > 0))
#define THIRD_QUADRANT(x, y)  ((x) < 0 && ((y) < 0))
#define FOURTH_QUADRANT(x, y) ((x) > 0 && ((y) < 0))
