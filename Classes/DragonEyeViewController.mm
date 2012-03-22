//
//  DragonEyeViewController.m
//  DragonEye
//
//  Created by alkaiser on 2/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "DragonEyeViewController.h"
#import "EAGLView.h"
#import "Texture.h"
#import "Program.h"
#import "Object.h"
#import "Character.h"
#import "ShaderConstants.h"
#import "ObjectContainer.h"

#include <iostream>
using namespace std;

//C++ objects undefinable in .h file
static Program program;
static Character obj(0, 0, 1.0, 1.0);

@interface DragonEyeViewController ()
@property (nonatomic, retain) EAGLContext *context;
@property (nonatomic, assign) CADisplayLink *displayLink;
- (BOOL)loadShaders;
- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file;
@end

@implementation DragonEyeViewController

@synthesize animating, context, displayLink;

- (void)awakeFromNib
{
    EAGLContext *aContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    if (!aContext)
    {
        aContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
    }
    
    if (!aContext)
        NSLog(@"Failed to create ES context");
    else if (![EAGLContext setCurrentContext:aContext])
        NSLog(@"Failed to set ES context current");
    
    self.context = aContext;
    [aContext release];
    
    [(EAGLView *)self.view setContext:context];
    [(EAGLView *)self.view setFramebuffer];
    
    if ([context API] == kEAGLRenderingAPIOpenGLES2)
        [self loadShaders];
    
    animating = FALSE;
    animationFrameInterval = 1;
    self.displayLink = nil;
	
	NSValue *val = [NSValue valueWithPointer:(const void *)(&obj)];
	[[ObjectContainer singleton] addObject:val];
}

- (void)dealloc
{
    // Tear down context.
    if ([EAGLContext currentContext] == context)
        [EAGLContext setCurrentContext:nil];
    
    [context release];
    
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self startAnimation];
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self stopAnimation];
    
    [super viewWillDisappear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Tear down context.
    if ([EAGLContext currentContext] == context)
        [EAGLContext setCurrentContext:nil];
    self.context = nil; 
}

- (NSInteger)animationFrameInterval
{
    return animationFrameInterval;
}

- (void)setAnimationFrameInterval:(NSInteger)frameInterval
{
    /*
     Frame interval defines how many display frames must pass between each time the display link fires.
     The display link will only fire 30 times a second when the frame internal is two on a display that refreshes 60 times a second. 
     The default frame interval setting of one will fire 60 times a second when the display refreshes at 60 times a second. 
     A frame interval setting of less than one results in undefined behavior.
     */
    if (frameInterval >= 1)
    {
        animationFrameInterval = frameInterval;
        
        if (animating)
        {
            [self stopAnimation];
            [self startAnimation];
        }
    }
}

- (void)startAnimation
{
    if (!animating)
    {
        CADisplayLink *aDisplayLink = [[UIScreen mainScreen] displayLinkWithTarget:self selector:@selector(drawFrame)];
        [aDisplayLink setFrameInterval:animationFrameInterval];
        [aDisplayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        self.displayLink = aDisplayLink;
        
        animating = TRUE;
    }
}

- (void)stopAnimation
{
    if (animating)
    {
        [self.displayLink invalidate];
        self.displayLink = nil;
        animating = FALSE;
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [[touches allObjects] objectAtIndex:0];
	CGPoint point = [touch locationInView:self.view];
	//EAGLView *eaglView = (EAGLView *) self.view;
	//CGPoint dpadPoint = [touch locationInView:eaglView.dpadButton];
	NSLog(@"Point touched %.2f, %.2f", point.x, point.y);
	
	/*CGRect frame = eaglView.dpadButton.frame;
	if (CGRectContainsPoint(frame, point)) {
		NSLog(@"Dpad touched %.2f, %.2f", dpadPoint.x, dpadPoint.y);
		
		if (dpadPoint.x < frame.size.width/2) {
			obj.move(-0.01f, 0.0f);
		} else {
			obj.move(0.01f, 0.0f);
		}
	}*/
	//NSLog(@"Origin %f, size %f", eaglView.dpadButton.frame.origin.x, eaglView.dpadButton.frame.size.width);
	[super touchesBegan:touches withEvent:event];
	//obj.moveTo(point.x, point.y);
}

- (void)drawFrame
{
    [(EAGLView *)self.view setFramebuffer];

    
    glClearColor(0.5f, 0.5f, 0.5f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);
	static Texture texture1([[NSBundle mainBundle] pathForResource:@"cabban1" ofType:@"jpg"]);
	static Texture texture2([[NSBundle mainBundle] pathForResource:@"cabban2" ofType:@"jpg"]);
    static Texture *textures[] = { &texture1, 
								  &texture2
								};
	
	if (!obj.hasTextures()) {
		obj.initializeTextures(textures, 2);
	}
 
    // Use shader program.
    glUseProgram(program.getProgramId());
    
    // Animate and draw all objects
	for (NSValue *val in [ObjectContainer singleton].objArray) {
		Object *obj = (Object *)[val pointerValue];
		obj->draw();   
		obj->animate();
	}

    
    
    // Validate program before drawing. This is a good check, but only really necessary in a debug build.
    // DEBUG macro must be defined in your debug configurations if that's not already the case.
#if defined(DEBUG)
    if (!program.validateProgram())
    {
        NSLog(@"Failed to validate program: %d", program.getProgramId());
        return;
    }
#endif
    
    [(EAGLView *)self.view presentFramebuffer];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file
{
    GLint status;
    const GLchar *source;
    
    source = (GLchar *)[[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil] UTF8String];
    if (!source)
    {
        NSLog(@"Failed to load vertex shader");
        return FALSE;
    }
    
    *shader = glCreateShader(type);
    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);
    
#if defined(DEBUG)
    GLint logLength;
    glGetShaderiv(*shader, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetShaderInfoLog(*shader, logLength, &logLength, log);
        NSLog(@"Shader compile log:\n%s", log);
        free(log);
    }
#endif
    
    glGetShaderiv(*shader, GL_COMPILE_STATUS, &status);
    if (status == 0)
    {
        glDeleteShader(*shader);
        return FALSE;
    }
    
    return TRUE;
}

- (BOOL)loadShaders
{
    GLuint vertShader, fragShader;
    NSString *vertShaderPathname, *fragShaderPathname;
    
    // Create shader program.
    program.createProgram();
    
    // Create and compile vertex shader.
    vertShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"vsh"];
    if (![self compileShader:&vertShader type:GL_VERTEX_SHADER file:vertShaderPathname])
    {
        NSLog(@"Failed to compile vertex shader");
        return FALSE;
    }
    
    // Create and compile fragment shader.
    fragShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"fsh"];
    if (![self compileShader:&fragShader type:GL_FRAGMENT_SHADER file:fragShaderPathname])
    {
        NSLog(@"Failed to compile fragment shader");
        return FALSE;
    }
    
    // Attach vertex shader to program.
    glAttachShader(program.getProgramId(), vertShader);
    
    // Attach fragment shader to program.
    glAttachShader(program.getProgramId(), fragShader);
    
    // Bind attribute locations.
    // This needs to be done prior to linking.
    glBindAttribLocation(program.getProgramId(), ATTRIB_VERTEX, "position");
    glBindAttribLocation(program.getProgramId(), ATTRIB_TEXTURE, "texture_coord");
    
    // Link program.
    if (!program.linkProgram())
    {
        NSLog(@"Failed to link program: %d", program.getProgramId());
        
        if (vertShader)
        {
            glDeleteShader(vertShader);
            vertShader = 0;
        }
        if (fragShader)
        {
            glDeleteShader(fragShader);
            fragShader = 0;
        }
        
        return FALSE;
    }
    
    // Get uniform locations.
	ShaderConstants::uniforms[UNIFORM_TEXTURE_SAMPLER] = glGetUniformLocation(program.getProgramId(), "textureSampler");
	ShaderConstants::uniforms[UNIFORM_TRANSLATE] = glGetUniformLocation(program.getProgramId(), "translate");
	ShaderConstants::uniforms[UNIFORM_SCALE] = glGetUniformLocation(program.getProgramId(), "scale");
	
    
    // Set vertex and fragment shaders up for deletion when glDetachShader gets called.
    if (vertShader)
        glDeleteShader(vertShader);
    if (fragShader)
        glDeleteShader(fragShader);
    
    return TRUE;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || 
		interfaceOrientation == UIInterfaceOrientationLandscapeRight)
        return YES;
    
    return NO;
}

@end
