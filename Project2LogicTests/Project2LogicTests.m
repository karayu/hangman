//
//  Project2LogicTests.m
//  Project2LogicTests
//
//  Created by Kara Yu on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import "Project2LogicTests.h"

#import "EvilGamePlay.h"
#import "GoodGamePlay.h"
#import "GamePlay.h"

@interface Project2LogicTests ()

// private properties

@property (nonatomic, readwrite, strong) EvilGamePlay *evilLogic;

@end


@implementation Project2LogicTests


@synthesize evilLogic=_evilLogic;


- (void)setUp
{
    [super setUp];
    NSLog(@"setup");
    // Set-up code here.

    self.evilLogic = [[EvilGamePlay alloc] init];    
    
    STAssertNotNil(self.evilLogic, @"Cannot create Evil instance");
    
    //manually init because dictionary load doesn't seem to be working in unit test...
    self.evilLogic.words = [[NSMutableArray alloc] initWithObjects:@"BEAR", @"BOAR", @"DEAR", @"DUCK", @"HARE",
                            @"HAT", @"BLACK", @"CAT", @"GAT", @"TAG", @"READ", @"BECK", @"BEAB", @"DEAD", @"ALA",
                            @"ABBB", @"PORA", nil];
    [self.evilLogic setMaxWordLength];
    
    
}

//sees if the function to modify our words list ot only be words of a certain length works
- (void) testTryWordLength
{
    [self.evilLogic tryWordLength:3];
    NSMutableArray *tmp = [[NSMutableArray alloc]  initWithObjects: @"HAT", @"CAT", @"GAT", @"TAG", @"ALA", nil];
    STAssertTrue([self.evilLogic.words isEqualToArray:tmp], @"Words are of the wrong length");

}


- (void) testWordsByPositionForLetter
{
    NSString *letter = @"A";
    
    //creates a hashtable with the equivalence string as the key mapping to an array of words with that eq class
    NSMutableDictionary *hashtable = [self.evilLogic words: self.evilLogic.words ByPositionForLetter: letter];
    
    //for each eq class, manually creates the array of words and checks it against the hashtable
    NSMutableArray *tmp = [[NSMutableArray alloc] initWithObjects:@"ABBB", nil];    
    STAssertTrue([[hashtable objectForKey:@"0"] isEqualToArray:tmp], @"Hashtable not correct at equiv class '0'");
    [tmp removeAllObjects];
    
    //for each eq class, manually creates the array of words and checks it against the hashtable
    tmp = [[NSMutableArray alloc] initWithObjects:@"ALA", nil];
    STAssertTrue([[hashtable objectForKey:@"0-2"] isEqualToArray:tmp], @"Hashtable not correct at equiv class '0-2'");

    [tmp removeAllObjects];
    
    //for each eq class, manually creates the array of words and checks it against the hashtable
    tmp = [[NSMutableArray alloc] initWithObjects:@"HARE", @"HAT",@"CAT",@"GAT",@"TAG", nil];
    STAssertTrue([[hashtable objectForKey:@"1"] isEqualToArray:tmp], @"Hashtable not correct at equiv class '1'");
    [tmp removeAllObjects];
    
    //for each eq class, manually creates the array of words and checks it against the hashtable
    tmp = [[NSMutableArray alloc] initWithObjects:@"BEAR", @"BOAR",@"DEAR",@"BLACK",@"READ",@"BEAB", @"DEAD", nil];
    STAssertTrue([[hashtable objectForKey:@"2"] isEqualToArray:tmp], @"Hashtable not correct at equiv class '2'");
    [tmp removeAllObjects];
    
    //for each eq class, manually creates the array of words and checks it against the hashtable
    tmp = [[NSMutableArray alloc] initWithObjects:@"PORA", nil];
    STAssertTrue([[hashtable objectForKey:@"3"] isEqualToArray:tmp], @"Hashtable not correct at equiv class '3'");
    [tmp removeAllObjects];
    
    //for each eq class, manually creates the array of words and checks it against the hashtable
    tmp = [[NSMutableArray alloc] initWithObjects:@"DUCK",@"BECK", nil];
    STAssertTrue([[hashtable objectForKey:@"nonexistent"] isEqualToArray:tmp], @"Hashtable not correct at equiv class 'nonexistent'");

    [tmp removeAllObjects];
        
}


- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
}

@end