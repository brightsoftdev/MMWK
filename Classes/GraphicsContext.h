//
//  GraphicsContext.h
//  DragonEye
//
//  Created by alkaiser on 4/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol GraphicsContext <NSObject>

@required
- (void) draw;
- (void) animate;
- (void) update;

@end
