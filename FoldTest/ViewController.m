//
//  ViewController.m
//  FoldTest
//
//  Created by Dana Smith on 8/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "QuartzCore/CALayer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
	    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	} else {
	    return YES;
	}
}

- (IBAction)flip:(id)sender
{
	UIView *flipView = [self.view viewWithTag:1];
	
	UIGraphicsBeginImageContext(flipView.bounds.size);
	[flipView.layer renderInContext:UIGraphicsGetCurrentContext()];
	
	UIImageView *topView = [[UIImageView alloc] initWithFrame:flipView.frame];
	topView.image = UIGraphicsGetImageFromCurrentImageContext();;
	[self.view addSubview:topView];
	
	UIImageView *bottomView = [[UIImageView alloc] initWithFrame:flipView.frame];
	bottomView.image = UIGraphicsGetImageFromCurrentImageContext();
	[self.view addSubview:bottomView];
	
	UIGraphicsEndImageContext();

	CGFloat angle;
	if (flipView.hidden == NO)
	{
		flipView.hidden = YES;
		angle = M_PI_2;
	}
	else 
	{
		topView.layer.transform = CATransform3DMakeRotation(M_PI_2, 0.0, 1.0, 0.0);
		bottomView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0.0, 1.0, 0.0);
		angle = 0;
	}

	[UIView animateWithDuration:2.0 animations:^{
		CATransform3D xform = CATransform3DMakeRotation(angle, 0.0, 1.0, 0.0);
		xform.m34 = 1.0/300.0;
		topView.layer.transform = xform;
		
		xform = CATransform3DMakeRotation(-angle, 0.0, 1.0, 0.0);
		xform.m34 = 1.0/300.0;
		bottomView.layer.transform = xform;
	} completion:^(BOOL finished) {
		if (angle == 0)
		{
			flipView.hidden = NO;
			
		}
		[topView removeFromSuperview];
		[bottomView removeFromSuperview];
	}];
}
@end
