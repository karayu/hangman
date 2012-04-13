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


@interface Project2LogicTests()




@end


@implementation Project2LogicTests

@synthesize evilLogic=_evilLogic;
@synthesize goodLogic=_goodLogic;
@synthesize gameLogic=_gameLogic;


- (void)setUp
{
    //[super setUp];
    NSLog(@"setup");
    // Set-up code here.
        
    //makes sure we're testing with the right dictionary
    FileName = @"small";

    _evilLogic = [[EvilGamePlay alloc] init];    
    _goodLogic = [[GoodGamePlay alloc] init];
    _gameLogic = [[GamePlay alloc] init];
    
    STAssertNotNil(_evilLogic, @"Cannot create Evil instance");
    STAssertNotNil(_goodLogic, @"Cannot create Good instance");
    STAssertNotNil(_gameLogic, @"Cannot create Gameplay instance");

    
}

- (void) testGameInit
{
    //makes sure that it initializes the dictionary
    STAssertNotNil(_gameLogic.words, @"Dictionary not initialized");
    
    //makes sure that the entire dictionary was loaded
    STAssertTrue([_gameLogic.words count] == 17, @"Dictionary not completely loaded");
    
    //makes sure that the entire dictionary was loaded
    STAssertTrue([_gameLogic maxWordLength] == 5, @"Max word length logic wrong");
    
}

//tests whether good game play picked a work
- (void) testGoodPickWord
{
    [_goodLogic pickWord];
    STAssertNotNil(_goodLogic.word, @"Word not initialized");
    
}

//tests the main brains behind the logic, the hash table creator
- (void) testWordsByPositionForLetter
{
    NSString *letter = @"A";
    
    //creates a hashtable with the equivalence string as the key mapping to an array of words with that eq class
    NSMutableDictionary *hashtable = [_evilLogic words: _evilLogic.words ByPositionForLetter: letter];
    
    
    //for each eq class, manually creates the array of words and checks it against the hashtable
    NSMutableArray *tmp = [[NSMutableArray alloc] initWithObjects:@"ABBB", nil];    
    tmp = [[NSMutableArray alloc] initWithObjects:@"ALA", nil];  
    NSLog(@"hashtable element: %@",[hashtable objectForKey:@"0"]  );
    NSLog(@"tmp is eual to: %@", tmp);
    //STAssertTrue([[hashtable objectForKey:@"0"] isEqualToArray:tmp], @"Hashtable not correct at equiv class '0'");
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



@end