//
//  Project2Tests.m
//  Project2Tests
//
//  Created by Kara Yu on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Project2Tests.h"
#import "EvilGamePlay.h"

@interface Project2Tests()

@property (nonatomic, readwrite, strong) EvilGamePlay *evilLogic;

@end


@implementation Project2Tests

@synthesize evilLogic=_evilLogic;

- (void)setUp
{
    //[super setUp];
    NSLog(@"setup");
    // Set-up code here.
    self.evilLogic = [[EvilGamePlay alloc] init];
    STAssertNotNil(self.evilLogic, @"Cannot create Account instance");

}

- (void) testInit
{
    //makes sure that it initializes the dictionary
    STAssertNotNil(self.evilLogic.words, @"Dictionary not initialized");
    
    //makes sure that the entire dictionary was loaded
    STAssertTrue(self.evilLogic.words.count == 17, @"Dictionary not completely loaded");
    
    //makes sure that the entire dictionary was loaded
    STAssertTrue(self.evilLogic.maxWordLength == 5, @"Max word length logic wrong");
        
}

- (void) testSetWordLength
{
    
}

- (void) testWordsByPositionForLetter
{
    NSString *letter = @"A";
    
    //creates a hashtable with the equivalence string as the key mapping to an array of words with that eq class
    NSMutableDictionary *hashtable = [self.evilLogic words: self.evilLogic.words ByPositionForLetter: letter];

    //for each eq class, manually creates the array of words and checks it against the hashtable
    NSMutableArray *tmp = [[NSMutableArray alloc] initWithObjects:@"ABBB", nil];    
    tmp = [[NSMutableArray alloc] initWithObjects:@"ALA", nil];
    if (! [[hashtable objectForKey:@"0"] isEqualToArray:tmp])
        return No;
    [tmp removeAllObjects];
    
    //for each eq class, manually creates the array of words and checks it against the hashtable
    tmp = [[NSMutableArray alloc] initWithObjects:@"ALA", nil];
    if (! [[hashtable objectForKey:@"0-2"] isEqualToArray:tmp])
        return No;
    [tmp removeAllObjects];

    //for each eq class, manually creates the array of words and checks it against the hashtable
    tmp = [[NSMutableArray alloc] initWithObjects:@"HARE", @"HAT",@"CAT",@"GAT",@"TAG", nil];
    if (! [[hashtable objectForKey:@"1"] isEqualToArray:tmp])
        return No;
    [tmp removeAllObjects];
    
    //for each eq class, manually creates the array of words and checks it against the hashtable
    tmp = [[NSMutableArray alloc] initWithObjects:@"BEAR", @"BOAR",@"DEAR",@"BLACK",@"READ",@"BEAB", @"DEAD", nil];
    if (! [[hashtable objectForKey:@"2"] isEqualToArray:tmp])
        return No;    
    [tmp removeAllObjects];
    
    //for each eq class, manually creates the array of words and checks it against the hashtable
    tmp = [[NSMutableArray alloc] initWithObjects:@"PORA", nil];
    if (! [[hashtable objectForKey:@"3"] isEqualToArray:tmp])
        return No;
    [tmp removeAllObjects];

    //for each eq class, manually creates the array of words and checks it against the hashtable
    tmp = [[NSMutableArray alloc] initWithObjects:@"DUCK",@"BECK", nil];
    if (! [[hashtable objectForKey:@"nonexistent"] isEqualToArray:tmp])
        return No;
    [tmp removeAllObjects];
    
    return true;
    
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
