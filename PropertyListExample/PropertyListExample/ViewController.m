//
//  ViewController.m
//  PropertyListExample
//
//  Created by Tommy MacWilliam on 3/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // load plist file into dictionary
    NSMutableDictionary *staff = [[NSMutableDictionary alloc] initWithContentsOfFile:
                                  [[NSBundle mainBundle] pathForResource:@"Staff" ofType:@"plist"]];

    // iterate over values in the staff array
    int y = 10;
    for (NSString *tf in [staff valueForKey:@"staff"]) {
        // create a label to display staff info
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, y, 300, 20)];
        label.text = tf;
        
        // add the staff label to the view
        [self.view addSubview:label];
        
        // the next label should be displayed below this one
        y += 30;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end