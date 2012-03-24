//
//  DragonEyeViewController.h
//  DragonEye
//
//  Created by alkaiser on 2/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import <QuartzCore/QuartzCore.h>
#import "EAGLView.h"
#import "Texture.h"
#import "Program.h"
#import "Player.h"
#import "ShaderConstants.h"
#import "ObjectContainer.h"


@interface DragonEyeViewController : UIViewController
{
    EAGLContext *context;
    
    BOOL animating;
    NSInteger animationFrameInterval;
    CADisplayLink *displayLink;
}

@property (readonly, nonatomic, getter=isAnimating) BOOL animating;
@property (nonatomic) NSInteger animationFrameInterval;

- (void)startAnimation;
- (void)stopAnimation;

@end
