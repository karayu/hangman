//
//  Project2Tests.m
//  Project2Tests
//
//  Created by Kara Yu on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Project2Tests.h"

@interface Project2Tests ()

@end

@implementation Project2Tests

@synthesize evil = _evil;

- (void)setUp
{
    [super setUp];
    
    self.evil = [[EvilGamePlay alloc] init];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    STFail(@"Unit tests are not implemented yet in Project2Tests");
}

@end
