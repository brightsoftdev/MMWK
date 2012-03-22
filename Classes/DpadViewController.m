    //
//  DpadViewController.m
//  DragonEye
//
//  Created by alkaiser on 3/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DpadViewController.h"


@implementation DpadViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (void)awakeFromNib
{
	NSLog(@"Got here");
	//[dpadButton addTarget:self action:@selector(myButtonClick:) forControlEvents:(UIControlEvents)UIControlEventTouchDown];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	NSLog(@"Got here");
    if (self) {
	NSLog(@"Got here2");        // Custom initialization.
    }
    return self;
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	NSLog(@"View did load");
    [super viewDidLoad];
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || 
			interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

-  (void)myButtonClick:(id)sender {
	NSLog(@"Clicked");
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [[touches allObjects] objectAtIndex:0];
	CGPoint point = [touch locationInView:self.view];
	NSLog(@"Dpad touched %.2f, %.2f", point.x, point.y);
	[super touchesBegan:touches withEvent:event];
	//obj.moveTo(point.x, point.y);
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
