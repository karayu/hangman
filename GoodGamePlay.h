//
//  GoodGamePlay.h
//  project2
//
//  Created by Kara Yu on 4/2/12.
//  Copyright (c) 2012 EPIC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GamePlay.h"

@interface GoodGamePlay : GamePlay

//variable: the initially chosen word
@property (nonatomic) NSString *word;

//methods
- (NSArray *) guessLetter: (NSString *) letter;
- (int) calculateScore;
- (BOOL) checkGameWon;
- (BOOL) pickWord;

@end
